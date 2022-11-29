import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/feature/search/view/cubit/search_drink_cubit.dart';

import '../../../data/repositories/models/drinks_model/drink.dart';
import '../../search/view/drink_search.dart';
import '../cubit/drink_cubit.dart';
import 'widgets/display_drinks.dart';

class DrinkScreen extends StatelessWidget {
  const DrinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTypeAheadDrink(),
        Expanded(
          child: BlocBuilder<DrinkCubit, DrinkState>(
            builder: (context, state) => state.when(
              drinkLoading: () =>
                  const Center(child: CircularProgressIndicator()),
              drinkLoadFailure: (e) => Text(e),
              drinkLoadSuccess: (data) => DisplayDrinks(
                drinksData: data,
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchDrinkCubit, SearchDrinkState>(
            builder: (context, state) => state.when(
              searchedDrinkLoading: () =>
                  const Center(child: CircularProgressIndicator()),
              searchedDrinkLoadError: (e) => Text(e),
              searchedDrinkLoadSuccess: (data) => DisplayDrinks(
                drinksData: data,
              ),
            ),
          ),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                context.read<DrinkCubit>().fetchDrinks();
              },
              child: const Text('download'),
            ),
          ],
        ),
      ],
    );
  }
}
