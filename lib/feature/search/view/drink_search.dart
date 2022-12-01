import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recipe_app/data/repositories/search_repo.dart';
import 'package:recipe_app/di.dart';

import '../../../data/repositories/models/drinks_model/drink.dart';
import 'cubit/search_drink_cubit.dart';

class SearchTypeAheadDrink extends StatefulWidget {
  const SearchTypeAheadDrink({
    super.key,
  });

  @override
  State<SearchTypeAheadDrink> createState() => _SearchTypeAheadDrinkState();
}

class _SearchTypeAheadDrinkState extends State<SearchTypeAheadDrink> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TypeAheadField<Drink>(
        debounceDuration: const Duration(microseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search_off_outlined),
            border: OutlineInputBorder(),
            labelText: 'search specific drink',
          ),
          onChanged: (value) =>
              context.read<SearchDrinkCubit>().readFavorite(value),
          onSubmitted: (value) =>
              context.read<SearchDrinkCubit>().readFavorite(value),
        ),
        suggestionsCallback: (pattern) async {
          return await SearchRepo(drinkRepository: getIt())
              .getDrinkSuggestions(pattern);
        },
        itemBuilder: (context, Drink? itemData) {
          return ListTile(
            title: Text(itemData?.strDrink ?? 'no data'),
          );
        },
        
        onSuggestionSelected: ((suggestion) {
          context
              .read<SearchDrinkCubit>()
              .readFavorite(suggestion.strDrink!.toLowerCase());
        }),
      ),
    );
  }
}
