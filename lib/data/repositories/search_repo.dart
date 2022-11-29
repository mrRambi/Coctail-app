//logika do sciagania gowna z neta w konkretnym formacie

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'package:recipe_app/data/repositories/drink_repository.dart';
import 'package:recipe_app/data/repositories/models/drinks_model/drink.dart';
import 'package:recipe_app/data/service/drink_service.dart';

import '../../di.dart';

@injectable
class SearchRepo {
  DrinkRepository drinkRepository;
  SearchRepo({
    required this.drinkRepository,
  });

  Future<List<Drink>> getDrinkSuggestions(String query) async {
    List<Drink> list = await drinkRepository.searchDrinkByName(query);
    return list;
  }
}
