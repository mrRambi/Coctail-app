import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/drink_cubit.dart';

import '../repository/models/drinks_data/drinks_data.dart';

class CoctailScreen extends StatelessWidget {
  const CoctailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            height: 400,
            child: BlocBuilder<DrinkCubit, DrinkState>(
              builder: (context, state) => state.when(
                drinkLoading: () => const CircularProgressIndicator(),
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
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _drinksData.toString(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
