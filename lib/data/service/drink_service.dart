import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/remote_data_sources/drink_api.dart';

import '../repositories/models/drinks_model/drink.dart';
import '../repositories/models/drinks_model/drinks_data.dart';

@singleton
class DrinkService {
  final DrinkApi _drinkApi;

  DrinkService({
    required DrinkApi drinkApi,
  }) : _drinkApi = drinkApi;

  Future<List<Drink>?> fetchDrinkFromSever() =>
      _drinkApi.fetchDrinkFromSever('random.php');

  Future<List<Drink>?> fetchDrinkByIdFromSever(String idOfDrink) =>
      _drinkApi.fetchDrinkFromSever('lookup.php?i=$idOfDrink');
}
