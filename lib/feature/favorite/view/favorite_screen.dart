import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/feature/favorite/view/widgets/favorite_display.dart';

import '../../../di.dart';
import '../../login/bloc/bloc/authentication_bloc.dart';
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
          children: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return state.map(
                    unknown: (_) => const SizedBox(),
                    authenticated: (_) => IconButton(
                        onPressed: () => context
                            .read<AuthenticationBloc>()
                            .add(const AuthenticationEvent.logoutRequested()),
                        icon: const Icon(Icons.logout)),
                    unauthenticated: (_) => const SizedBox());
              },
            ),
          ],
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
