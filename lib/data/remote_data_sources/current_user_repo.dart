import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/repositories/models/app_user.dart';
import 'package:recipe_app/data/repositories/models/drinks_model/drinks_data.dart';
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

  Future<List<DrinksData?>> getDrinksApiByFirestoreFavorite() async {
    final favoriteDrinks = await readUser();

    var listOfFavoriteDrinks = favoriteDrinks!['favoriteDrinks'];

    List<DrinksData?> resultList = await listOfFavoriteDrinks
        .map((e) => _drinkService.fetchDrinkByIdFromSever(e))
        .toList();
    return resultList;
  }

  Future<List<dynamic>> addFavoriteDrinkToUser(String id) async {
    final favoriteDrinks = await readUser();

    var specyficFavoriteDrink = favoriteDrinks!['favoriteDrinks'];
    specyficFavoriteDrink.add(id);

    await updateFavoriteDrinksList(specyficFavoriteDrink);

    return specyficFavoriteDrink;
  }

  Future<List<dynamic>> removeFavoriteDrinkToUser(String id) async {
    final favoriteDrinks = await readUser();

    List<dynamic> specyficFavoriteDrink = favoriteDrinks!['favoriteDrinks'];
    specyficFavoriteDrink.remove(id);

    await updateFavoriteDrinksList(specyficFavoriteDrink);
    return specyficFavoriteDrink;
  }

  Future<void> updateFavoriteDrinksList(dynamic data) async {
    await _dataFireStoreRepo.updateCollectionField(
        collectionName: usersCollection,
        docName: userId!,
        parameters: {'favoriteDrinks': data});
  }
}
