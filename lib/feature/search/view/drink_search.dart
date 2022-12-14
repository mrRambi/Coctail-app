import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recipe_app/data/repositories/search_repo.dart';
import 'package:recipe_app/di.dart';
import 'package:recipe_app/utils/const.dart';

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
    final media = MediaQuery.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                child: const Icon(
                  Icons.search,
                  size: 30,
                )),
            const SizedBox(
              width: 5,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: media.size.width),
              child: AnimatedContainer(
                curve: Curves.ease,
                duration: const Duration(seconds: 1),
                width: selected ? media.size.width * 0.7 : 0,
                height: selected ? 50 : 0,
                child: TypeAheadField<Drink?>(
                  debounceDuration: const Duration(microseconds: 100),
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    onChanged: (value) =>
                        context.read<SearchDrinkCubit>().readFavorite(value),
                    onSubmitted: (value) {
                      context.read<SearchDrinkCubit>().readFavorite(value);
                      _typeAheadController.clear();
                    },
                  ),
                  suggestionsCallback: (pattern) async {
                    return await SearchRepo(drinkRepository: getIt())
                            .getDrinkSuggestions(pattern) ??
                        [];
                  },
                  itemBuilder: (context, Drink? itemData) {
                    return ListTile(
                      title: Text(
                        itemData == null
                            ? unknowData
                            : itemData.strDrink ?? unknowData,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  },
                  onSuggestionSelected: ((suggestion) {
                    context.read<SearchDrinkCubit>().readFavorite(
                        suggestion?.strDrink?.toLowerCase() ?? 'No Drink');
                    _typeAheadController.clear();
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}
