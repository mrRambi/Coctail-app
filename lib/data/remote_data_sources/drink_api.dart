import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../repositories/models/drinks_model/drink.dart';

@injectable
class DrinkApi {
  @factoryMethod
  Future<List<Drink?>?> fetchDrinkFromSever(String parametr) async {
    String url = dotenv.get('API_URL');
    String uri = '$url$parametr';
    final result = await http.Client()
        .get(Uri.parse(uri), headers: {"Content-Type": "application/json"});
    if (result.statusCode == 200) {
      final models = result.body;

      var postModel = jsonDecode(models);

      if (postModel['drinks'] == null) return [];

      final mapOfDrinksToList = postModel['drinks'] as List;

      List<Drink?>? listOfDrinks = mapOfDrinksToList
          .map((e) => Drink.fromJson(e as Map<String, dynamic>))
          .toList();

      return listOfDrinks;
    } else {
      return null;
    }
  }
}
