import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/models/app_user.dart';
import '../../../../data/repositories/models/drinks_model/drink.dart';
import '../../../../utils/const.dart';
import '../../../login/bloc/bloc/authentication_bloc.dart';
import '../../../update_firestore_data.dart/cubit/update_current_user_data_cubit.dart';

class DrinkPage extends StatelessWidget {
  const DrinkPage({super.key, required this.drink});

  final Drink drink;

  @override
  Widget build(BuildContext context) {
    var ing = drink.measureProperties().toList();
    var meas = drink.ingriedientProperties().toList();
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Color(0xFF0b0130), Color(0xFF190957)],
            ),
          ),
          child: SizedBox(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image:
                          NetworkImage(drink.strDrinkThumb ?? linkDrinkPicture),
                    ),
                  ),
                  width: double.infinity,
                  height: 400,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pop(context),
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: StreamBuilder<AppUser?>(
                            stream:
                                context.watch<AuthenticationBloc>().isLoged(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return FavoriteIconButton(
                                  isChecked: true,
                                  drink: drink,
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    drink.strDrink ?? 'drinkname',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Category: ',
                        style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        drink.strAlcoholic ?? '',
                        style: const TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    drink.strInstructions ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ...List.generate(
                
                  ing.length,
                  (index) {
                    final measurence = meas[index];
                    final ingredience = ing[index];
                    final isIngNull = measurence == null || ingredience == null;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isIngNull)
                            Text(
                              "$ingredience - $measurence",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          if (isIngNull) const SizedBox(),
                        ],
                      ),
                    );
                  },
                ).toList(),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    Key? key,
    required this.isChecked,
    required this.drink,
  }) : super(key: key);
  final bool isChecked;
  final Drink? drink;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCurrentUserDataCubit, UpdateCurrentUserDataState>(
      builder: (context, state) {
        return state.when(
          currentUserDataLoading: () => const IconButton(
              onPressed: null,
              icon:
                  Icon(Icons.favorite_outline, color: Colors.white, size: 30)),
          currentUserDataError: (_) => const IconButton(
            onPressed: null,
            icon: Icon(Icons.favorite_outline, color: Colors.white, size: 30),
          ),
          currentUserDataLoadSuccess: (data) =>
              !data.contains(drink?.idDrink.toString())
                  ? IconButton(
                      onPressed: () {
                        context
                            .read<UpdateCurrentUserDataCubit>()
                            .addFavorite(drink?.idDrink ?? '');
                      },
                      icon: const Icon(Icons.favorite_outline),
                      color: Colors.white,
                      iconSize: 30,
                    )
                  : IconButton(
                      onPressed: () {
                        context
                            .read<UpdateCurrentUserDataCubit>()
                            .removeFavorite(drink?.idDrink ?? '');
                      },
                      icon: const Icon(Icons.favorite),
                      color: Colors.white,
                      iconSize: 30,
                    ),
        );
      },
    );
  }
}
