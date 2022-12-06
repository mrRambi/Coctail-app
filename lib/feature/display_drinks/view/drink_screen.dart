import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/feature/display_drinks/view/widgets/info_dialog.dart';
import 'package:recipe_app/feature/display_drinks/view/widgets/user_page.dart';
import 'package:recipe_app/feature/search/view/cubit/search_drink_cubit.dart';
import 'package:recipe_app/utils/extensions.dart';

import '../../login/bloc/bloc/authentication_bloc.dart';
import '../../search/view/drink_search.dart';
import '../cubit/drink_cubit.dart';
import 'widgets/display_drinks.dart';

class DrinkScreen extends StatelessWidget {
  const DrinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const SearchTypeAheadDrink(),
        const SizedBox(
          height: 5,
        ),
        Text(
          context.loc.chooseDrink,
          style: GoogleFonts.lobster(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
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
      ],
    );
  }
}

class UserPageButton extends StatelessWidget {
  const UserPageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state.map(
            unknown: (_) => const SizedBox(),
            authenticated: (_) => IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        
                        return UserPage();
                      }));
                },
                icon: const Icon(Icons.account_circle)),
            unauthenticated: (_) => const SizedBox());
      },
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.orange[500],
      backgroundColor: Colors.black,
      onPressed: () async {
        context.read<DrinkCubit>().fetchDrinks();

        await showDialog(
            context: context,
            builder: (BuildContext context) => const InfoDialog());
      },
      child: const Icon(
        Icons.add,
        size: 35,
      ),
    );
  }
}
