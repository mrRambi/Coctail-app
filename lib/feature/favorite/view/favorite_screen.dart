import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/feature/favorite/view/widgets/favorite_display.dart';

import '../../../di.dart';
import '../../display_drinks/view/drink_screen.dart';
import '../bloc/cubit/favorite_drink_of_user_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [UserPageButton()],
        ),
        Expanded(
          child:
              BlocBuilder<FavoriteDrinkOfUserCubit, FavoriteDrinkOfUserState>(
            builder: (context, state) => state.when(
              favoriteLoading: () =>
                  const Center(child: CircularProgressIndicator()),
              favoriteLoadError: (e) => Text(e),
              favoriteLoadSuccess: (data) => FavoriteDisplay(
                currentUserRepo: getIt(),
                drinksData: data,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
