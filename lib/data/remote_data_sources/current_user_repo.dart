import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/repositories/models/app_user.dart';
import 'package:recipe_app/data/repositories/models/drinks_model/drink.dart';
import 'package:recipe_app/data/service/drink_service.dart';

import 'firestore_repo.dart';

@injectable
class CurrentUserRepo {
  final User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final DataFireStoreRepo _dataFireStoreRepo;
  String usersCollection = 'users';
  final DrinkService _drinkService;

  CurrentUserRepo(this._drinkService, {DataFireStoreRepo? dataFireStoreRepo})
      : _dataFireStoreRepo = dataFireStoreRepo ?? DataFireStoreRepo();

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

  Future<Map<String, dynamic>?> readUser() async {
    return await _dataFireStoreRepo.readDocument(
      collectionName: usersCollection,
      documentName: userId ?? 'no data',
    );
  }

  Future<List<String>> readUserToStringList() async {
    final favoriteDrinks = await readUser();

    List listOfFavoriteDrinks = favoriteDrinks!['favoriteDrinks'] as List;
    final listOfString = listOfFavoriteDrinks.map((e) => e.toString()).toList();

    return listOfString;
  }

  Future<List<Drink>?> readUserToDrinkList() async {
    final favoriteDrinks = await readUser();

    List listOfFavoriteDrinks = favoriteDrinks!['favoriteDrinks'] as List;
    final l = listOfFavoriteDrinks.map((e) => e.toString()).toList();
    List<Drink>? listOfDrink = [];
    for (var i in l) {
      final listOfDrinkServiceItem = Drink(idDrink: i);
      listOfDrink.add(listOfDrinkServiceItem);
    }

    return listOfDrink;
  }

  Future<List<Drink>?> getDrinksApiByFirestoreFavorite() async {
    final favoriteDrinks = await readUser();

    List listOfFavoriteDrinks = favoriteDrinks!['favoriteDrinks'] as List;
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

    // List<String> specyficFavoriteDrink = favoriteDrinks!['favoriteDrinks'];
    favoriteDrinks.add(id);

    await updateFavoriteDrinksList(favoriteDrinks);

    return favoriteDrinks;
  }

  Future<List<String>> removeFavoriteDrinkToUser(String id) async {
    final favoriteDrinks = await readUserToStringList();

    // List<String> specyficFavoriteDrink = favoriteDrinks!['favoriteDrinks'];
    favoriteDrinks.remove(id);

    await updateFavoriteDrinksList(favoriteDrinks);

    return favoriteDrinks;
  }

  Future<void> updateFavoriteDrinksList(List<String> data) async {
    await _dataFireStoreRepo.updateCollectionField(
        collectionName: usersCollection,
        docName: userId!,
        parameters: {'favoriteDrinks': data});
  }
}
