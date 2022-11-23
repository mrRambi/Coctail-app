import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/feature/favorite/view/widgets/favorite_display.dart';

import '../../../di.dart';
import '../bloc/cubit/favorite_drink_of_user_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child:
              BlocBuilder<FavoriteDrinkOfUserCubit, FavoriteDrinkOfUserState>(
            builder: (context, state) => state.when(
              favoriteLoading: () =>
                  const Center(child: CircularProgressIndicator()),
              favoriteLoadError: (e) => Text(e),
              favoriteLoadSuccess: (data) => FavoriteDisplay(
                currentUserRepo: getIt(),
                drinksData: data ?? [],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                context.read<FavoriteDrinkOfUserCubit>().getFavoriteByApi();
              },
              child: const Text('dwn fav'),
            ),
          ],
        ),
      ],
    );
  }
}
