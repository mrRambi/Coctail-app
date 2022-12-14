import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/repositories/models/app_user.dart';
import 'package:recipe_app/data/repositories/models/drinks_model/drink.dart';
import 'package:recipe_app/data/service/drink_service.dart';

import 'firebase_repo.dart';
import 'firestore_repo.dart';

@injectable
class CurrentUserRepo {
  final AuthenticationRepository authenticationRepository;
  final DataFireStoreRepo _dataFireStoreRepo;
  String usersCollection = 'users';
  final DrinkService _drinkService;

  CurrentUserRepo(this._drinkService, this.authenticationRepository,
      {DataFireStoreRepo? dataFireStoreRepo})
      : _dataFireStoreRepo = dataFireStoreRepo ?? DataFireStoreRepo() {
    authenticationRepository.user.listen((user) {
      setUser(user);
    });
  }

  late final StreamSubscription<AppUser?> userSubscription;
  late final StreamController<AppUser?> userController;

  AppUser? userNr;

  setUser(AppUser? user) {
    userNr = user;
  }

  Future<void> creatUser(AppUser data) async {
    try {
      await _dataFireStoreRepo.createCollection(
        collectionName: usersCollection,
        docName: data.id,
        data: data.toJson(),
      );
    } catch (e) {
      e.toString();
    }
  }

  Future<Map<String, dynamic>?> readUserDocument() async {
    return await _dataFireStoreRepo.readDocument(
      collectionName: usersCollection,
      documentName: userNr?.id ?? 'no data',
    );
  }

  Future<List<String>> readUserToStringList() async {
    final favoriteDrinks = await readUserDocument();
    if (favoriteDrinks == null) return [];
    List listOfFavoriteDrinks = favoriteDrinks['favoriteDrinks'] as List;
    final listOfString = listOfFavoriteDrinks.map((e) => e.toString()).toList();

    return listOfString;
  }

  Future<List<Drink>> readUserToDrinkList() async {
    final favoriteDrinks = await readUserDocument();

    List listOfFavoriteDrinks = favoriteDrinks?['favoriteDrinks'] as List;
    final l = listOfFavoriteDrinks.map((e) => e.toString()).toList();
    List<Drink>? listOfDrink = [];
    for (var i in l) {
      final listOfDrinkServiceItem = Drink(idDrink: i);
      listOfDrink.add(listOfDrinkServiceItem);
    }

    return listOfDrink;
  }

  Future<List<Drink>> getDrinksApiByFirestoreFavorite() async {
    final favoriteDrinks = await readUserDocument();

    if (favoriteDrinks?['favoriteDrinks'] == null) {
      return [];
    }

    List listOfFavoriteDrinks = favoriteDrinks?['favoriteDrinks'] as List;

    final l = listOfFavoriteDrinks.map((e) => e.toString()).toList();

    List<Drink>? listOfDrink = [];
    for (var i in l) {
      final listOfDrinkServiceItem =
          await _drinkService.fetchDrinkByIdFromSever(i);
      listOfDrink.add(listOfDrinkServiceItem?.first ?? Drink());
    }

    return listOfDrink;
  }

  Future<List<String>> addFavoriteDrinkToUser(String id) async {
    final favoriteDrinks = await readUserToStringList();

    favoriteDrinks.add(id);

    await updateFavoriteDrinksList(favoriteDrinks);

    return favoriteDrinks;
  }

  Future<List<String>> removeFavoriteDrinkToUser(String id) async {
    final favoriteDrinks = await readUserToStringList();

    favoriteDrinks.remove(id);

    await updateFavoriteDrinksList(favoriteDrinks);

    return favoriteDrinks;
  }

  Future<void> updateFavoriteDrinksList(List<String> data) async {
    await _dataFireStoreRepo.updateCollectionField(
        collectionName: usersCollection,
        docName: userNr?.id ?? '',
        parameters: {'favoriteDrinks': data});
  }
}
