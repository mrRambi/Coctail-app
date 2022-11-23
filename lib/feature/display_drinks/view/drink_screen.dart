import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/drink_cubit.dart';
import 'widgets/display_drinks.dart';

class DrinkScreen extends StatelessWidget {
  const DrinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: BlocBuilder<DrinkCubit, DrinkState>(
            builder: (context, state) => state.when(
              drinkLoading: () =>
                  const Center(child: CircularProgressIndicator()),
              drinkLoadFailure: (e) => Text(e),
              drinkLoadSuccess: (data) => DisplayDrinks(
                drinksData: data ,
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
