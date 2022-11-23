import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../repositories/models/drinks_model/drinks_data.dart';

@injectable
class DrinkApi {
  @factoryMethod
  Future<DrinksData?> fetchDrinkFromSever(String parametr) async {
    String url = dotenv.get('API_URL');
    String uri = '$url$parametr';
    final result = await http.Client()
        .get(Uri.parse(uri), headers: {"Content-Type": "application/json"});
    if (result.statusCode == 200) {
      final models = result.body;

      DrinksData postModel = DrinksData.fromJson(jsonDecode(models));

      return postModel;
    } else {
      return null;
    }
  }
}
