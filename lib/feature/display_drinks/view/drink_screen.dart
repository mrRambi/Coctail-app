import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/feature/display_drinks/view/widgets/info_dialog.dart';
import 'package:recipe_app/feature/search/view/cubit/search_drink_cubit.dart';
import 'package:recipe_app/utils/extensions.dart';

import '../../search/view/drink_search.dart';
import '../cubit/drink_cubit.dart';
import 'widgets/display_drinks.dart';

class DrinkScreen extends StatelessWidget {
  const DrinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
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
                  drinksData: data ?? [],
                ),
              ),
            ),
          ),
        ],
      ),
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
        child: SvgPicture.asset(
          'lib/assets/cube.svg',
          color: Colors.amber[800],
          height: 40,
        ));
  }
}
