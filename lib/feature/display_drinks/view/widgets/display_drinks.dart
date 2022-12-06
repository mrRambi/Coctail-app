import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/feature/display_drinks/view/widgets/drink_page.dart';

import 'package:recipe_app/feature/update_firestore_data.dart/cubit/update_current_user_data_cubit.dart';

import '../../../../data/repositories/models/drinks_model/drink.dart';
import '../../../../utils/const.dart';
import '../../../login/bloc/bloc/authentication_bloc.dart';

class DisplayDrinks extends StatelessWidget {
  const DisplayDrinks({Key? key, required List<Drink?> drinksData})
      : _drinksData = drinksData,
        super(key: key);

  final List<Drink?> _drinksData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _drinksData.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrinkPage(
                        drink: _drinksData[index]!,
                      ))),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(
                    0.0,
                    10.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 10.0,
                ),
              ],
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.07),
                  BlendMode.multiply,
                ),
                image: NetworkImage(
                    _drinksData[index]?.strDrinkThumb ?? linkDrinkPicture),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      _drinksData[index]?.strDrink ?? 'Drink name',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return state.map(
                          unknown: (_) => const SizedBox(),
                          unauthenticated: (_) => const SizedBox(),
                          authenticated: (_) => BlocBuilder<
                              UpdateCurrentUserDataCubit,
                              UpdateCurrentUserDataState>(
                            builder: (context, state) {
                              return state.when(
                                currentUserDataLoading: () => IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      size: 25,
                                    ),
                                    color: Colors.white,
                                    iconSize: 18),
                                currentUserDataError: (e) => Text(e),
                                currentUserDataLoadSuccess: (value) => SizedBox(
                                  child: (!value.contains(_drinksData[index]
                                          ?.idDrink
                                          .toString()))
                                      ? IconButton(
                                          onPressed: () {
                                            context
                                                .read<
                                                    UpdateCurrentUserDataCubit>()
                                                .addFavorite(_drinksData[index]
                                                        ?.idDrink
                                                        .toString() ??
                                                    '');
                                          },
                                          icon: const Icon(
                                            Icons.favorite_outline,
                                            size: 25,
                                          ),
                                          color: Colors.white,
                                          iconSize: 18,
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            context
                                                .read<
                                                    UpdateCurrentUserDataCubit>()
                                                .removeFavorite(
                                                    _drinksData[index]
                                                            ?.idDrink
                                                            .toString() ??
                                                        '');
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            size: 25,
                                          ),
                                          color: Colors.white,
                                          iconSize: 18,
                                        ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
