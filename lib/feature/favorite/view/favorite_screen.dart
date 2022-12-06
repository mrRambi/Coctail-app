import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/feature/favorite/view/widgets/favorite_display.dart';
import 'package:recipe_app/feature/login/view/widgets/login_form.dart';

import '../../../di.dart';
import '../../display_drinks/view/drink_screen.dart';
import '../../login/bloc/bloc/authentication_bloc.dart';
import '../../login/view/login_screen.dart';
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
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                authenticated: ((data) => BlocBuilder<FavoriteDrinkOfUserCubit,
                        FavoriteDrinkOfUserState>(
                      builder: (context, state) => state.when(
                          favoriteLoading: () {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          favoriteLoadError: (e) => Text(e),
                          favoriteLoadSuccess: (data) {
                            return FavoriteDisplay(
                              currentUserRepo: getIt(),
                              drinksData: data,
                            );
                          }),
                    )),
              );
            },
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return state.map(
                    unknown: (_) => const LoginScreen(),
                    unauthenticated: (_) => const LoginForm(),
                    authenticated: (_) {
                      return BlocBuilder<FavoriteDrinkOfUserCubit,
                          FavoriteDrinkOfUserState>(
                        builder: (context, state) => state.when(
                            favoriteLoading: () {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            favoriteLoadError: (e) => Text(e),
                            favoriteLoadSuccess: (data) {
                              return FavoriteDisplay(
                                currentUserRepo: getIt(),
                                drinksData: data,
                              );
                            }),
                      );
                    });
              },
            ),
          ),
        ),
      ],
    );
  }
}
