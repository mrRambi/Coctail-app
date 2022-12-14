import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/feature/favorite/view/widgets/favorite_display.dart';
import 'package:recipe_app/feature/login/view/login_screen.dart';

import '../../login/bloc/bloc/authentication_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) => state.when(
        unknown: () => const LoginScreen(),
        unauthenticated: () => const LoginScreen(),
        authenticated: (user) => const FavoriteDisplay(),
      ),
    );
  }
}
