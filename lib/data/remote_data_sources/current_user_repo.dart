import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/repositories/models/app_user.dart';

import 'firestore_repo.dart';

@injectable
class CurrentUserRepo {
  final User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final DataFireStoreRepo _dataFireStoreRepo;
  String usersCollection = 'users';

  CurrentUserRepo({DataFireStoreRepo? dataFireStoreRepo})
      : _dataFireStoreRepo = dataFireStoreRepo ?? DataFireStoreRepo();

  void creatUser(AppUser data) {
    try {
      _dataFireStoreRepo.createCollection(
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
        collectionName: usersCollection, documentName: userId ?? 'no data');
  }

  Future<List<dynamic>> addFavoriteDrinkToUser(String name) async {
    final favoriteDrinks = await readUser();
  
    var specyficFavoriteDrink = favoriteDrinks?['favoriteDrinks'];
    specyficFavoriteDrink.add(name);
    
    await updateFavoriteDrinksList(specyficFavoriteDrink);
    return specyficFavoriteDrink;
  }

  Future<List<dynamic>> removeFavoriteDrinkToUser(String name) async {
    final favoriteDrinks = await readUser();
    
    List<dynamic> specyficFavoriteDrink = favoriteDrinks!['favoriteDrinks'];
    specyficFavoriteDrink.remove(name);

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
