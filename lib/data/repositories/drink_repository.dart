import 'package:injectable/injectable.dart';
import 'package:recipe_app/data/service/drink_service.dart';

@injectable
class DrinkRepository {
  final DrinkService drinkService;

  DrinkRepository({
    required this.drinkService,
  });

  fetchTopTenDrinks() => drinkService.fetchDrinkFromSever();
  fetchSpecificDrink(String specificDrinkId) =>
      drinkService.fetchDrinkByIdFromSever(specificDrinkId);
}
