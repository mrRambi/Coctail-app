import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/utils/extensions.dart';

import '../../../../utils/const.dart';
import '../../../login/bloc/bloc/authentication_bloc.dart';
import '../../../update_firestore_data.dart/cubit/update_current_user_data_cubit.dart';
import '../../cubit/drink_cubit.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrinkCubit, DrinkState>(
        builder: (context, state) => state.when(
            drinkLoading: () =>
                const Center(child: CircularProgressIndicator()),
            drinkLoadFailure: (e) => Text(e),
            drinkLoadSuccess: (data) {
              var ing = data[0].measureProperties().toList();
              var meas = data[0].ingriedientProperties().toList();
              return Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.black,
                          Color(0xFF383836),
                          Color(0xFF1b151f)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 470,
                    width: 330,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.07),
                                BlendMode.multiply,
                              ),
                              image: NetworkImage(
                                  data[0].strDrinkThumb ?? linkDrinkPicture),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5.0,
                                spreadRadius: 5.0,
                              ),
                            ],
                          ),
                          width: 200,
                          height: 200,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: BlocBuilder<AuthenticationBloc,
                                    AuthenticationState>(
                                  builder: (context, state) {
                                    return state.map(
                                      unknown: (_) => const SizedBox(),
                                      unauthenticated: (_) => const SizedBox(),
                                      authenticated: (_) => BlocBuilder<
                                          UpdateCurrentUserDataCubit,
                                          UpdateCurrentUserDataState>(
                                        builder: (context, state) {
                                          return state.when(
                                            currentUserDataLoading: () =>
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.favorite_outline,
                                                      size: 22,
                                                    ),
                                                    color: Colors.white,
                                                    iconSize: 18),
                                            currentUserDataError: (e) =>
                                                Text(e),
                                            currentUserDataLoadSuccess:
                                                (value) => SizedBox(
                                              child: (!value.contains(data[0]
                                                      .idDrink
                                                      .toString()))
                                                  ? IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                UpdateCurrentUserDataCubit>()
                                                            .addFavorite(data[0]
                                                                .idDrink
                                                                .toString());
                                                      },
                                                      icon: const Icon(
                                                        Icons.favorite_outline,
                                                        size: 20,
                                                      ),
                                                      color: Colors.white,
                                                      iconSize: 20,
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                UpdateCurrentUserDataCubit>()
                                                            .removeFavorite(
                                                                data[0]
                                                                    .idDrink
                                                                    .toString());
                                                      },
                                                      icon: const Icon(
                                                        Icons.favorite,
                                                        size: 20,
                                                      ),
                                                      color: Colors.white,
                                                      iconSize: 20,
                                                    ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 280,
                          height: 55,
                          child: Text(
                            data[0].strDrink ?? '',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          height: 140,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Category: ',
                                          style: TextStyle(
                                              color: Colors.amber[200]),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          data[0].strAlcoholic ?? '',
                                          style: TextStyle(
                                              color: Colors.amber[200]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  child: Text(data[0].strInstructions ?? ''),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: meas.length,
                                    itemBuilder: (context, index) {
                                      final measurence = meas[index];
                                      final ingredience = ing[index];
                                      final isIngNull = measurence == null ||
                                          ingredience == null;

                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            if (!isIngNull)
                                              Text(
                                                  "$ingredience - $measurence"),
                                            if (isIngNull) const SizedBox(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: Text(
                                context.loc.out,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                  foregroundColor: Colors.white),
                              child: Text(
                                context.loc.next,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                context.read<DrinkCubit>().fetchDrinks();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
