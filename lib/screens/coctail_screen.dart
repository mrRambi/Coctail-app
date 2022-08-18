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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: BlocBuilder<DrinkCubit, DrinkState>(
              builder: (context, state) => state.when(
                drinkLoading: () =>
                    const Center(child: CircularProgressIndicator()),
                drinkLoadFailure: (e) => Text(e),
                drinkLoadSuccess: (data) => DisplayDrinkWidget(
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

class DisplayDrinkWidget extends StatelessWidget {
  const DisplayDrinkWidget({Key? key, required DrinksData drinksData})
      : _drinksData = drinksData,
        super(key: key);

  final DrinksData _drinksData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _drinksData.drinks?.length,
      itemBuilder: (context, index) {
        return CoctailCard(
            strDrink: _drinksData.drinks?[index].strDrink ?? 'Drinks Name',
            strImageSource: _drinksData.drinks?[index].strImageSource ??
                'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80');
      },
    );
  }
}
