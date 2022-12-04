import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recipe_app/data/repositories/search_repo.dart';
import 'package:recipe_app/di.dart';
import 'package:recipe_app/utils/const.dart';
import 'package:recipe_app/utils/extensions.dart';

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
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                selected = !selected;
              });
            },
            child: const Icon(Icons.search)),
        const SizedBox(
          width: 5,
        ),
        AnimatedContainer(
          curve: Curves.ease,
          duration: const Duration(seconds: 2),
          width: selected ? 300 : 0,
          height: selected ? 40 : 0,
          child: TypeAheadField<Drink>(
            debounceDuration: const Duration(microseconds: 300),
            textFieldConfiguration: TextFieldConfiguration(
              controller: _typeAheadController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: context.loc.findUrDrink,
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
                title: Text(
                  itemData?.strDrink ?? unknowData,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            },
            onSuggestionSelected: ((suggestion) {
              context
                  .read<SearchDrinkCubit>()
                  .readFavorite(suggestion.strDrink!.toLowerCase());
            }),
          ),
        ),
      ],
    );
  }
}
