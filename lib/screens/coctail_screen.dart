import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/drink_cubit.dart';

import '../repository/models/drinks_data/drinks_data.dart';
import 'widgets/coctail_card.dart';

class CoctailScreen extends StatelessWidget {
  const CoctailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('space for awesome icon'),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      ),
    );
  }
}

class DisplayDrinks extends StatelessWidget {
  const DisplayDrinks({Key? key, required DrinksData drinksData})
      : _drinksData = drinksData,
        super(key: key);

  final DrinksData _drinksData;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<DrinkCubit>().fetchDrinks(),
      child: ListView.builder(
        itemCount: _drinksData.drinks?.length,
        itemBuilder: (context, index) {
          print(_drinksData.drinks?[index].strImageSource);
          return CoctailCard(
              strDrink: _drinksData.drinks?[index].strDrink ?? 'Drinks Name',
              strImageSource: _drinksData.drinks?[index].strDrinkThumb ??
                  'https://c.pxhere.com/images/f4/05/58efa5e8778a37e56bafdf192118-1593200.jpg!d');
        },
      ),
    );
  }
}
