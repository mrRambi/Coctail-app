import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/repository/models/drinks_data/drinks_data.dart';

class DrinkRepo {
  Future<DrinksData?> fetchDrinkFromSever() async {
    String url = dotenv.get('API_URL');
    final result = await http.Client()
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    if (result.statusCode == 200) {
      final models = result.body;
      print(models);
      DrinksData postModel = DrinksData.fromJson(jsonDecode(models));
      print(postModel);
      return postModel;
    } else {
      return null;
    }
  }
}
