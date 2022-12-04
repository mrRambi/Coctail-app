import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/models/drinks_model/drink.dart';
import '../../../../utils/const.dart';
import '../../../update_firestore_data.dart/cubit/update_current_user_data_cubit.dart';

class DrinkPage extends StatelessWidget {
  const DrinkPage({super.key, required this.drink});

  final Drink drink;

  @override
  Widget build(BuildContext context) {
    var ing = drink.measureProperties().toList();
    var meas = drink.ingriedientProperties().toList();
    return Scaffold(
      backgroundColor: Colors.black54,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF0b0130), Color(0xFF190957)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
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
                      child: BlocBuilder<UpdateCurrentUserDataCubit,
                          UpdateCurrentUserDataState>(
                        builder: (context, state) {
                          return state.when(
                            currentUserDataLoading: () => IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_outline,
                                  size: 30,
                                ),
                                color: Colors.white,
                                iconSize: 30),
                            currentUserDataError: (e) => Text(e),
                            currentUserDataLoadSuccess: (value) => SizedBox(
                              child: (!value.contains(drink.idDrink.toString()))
                                  ? IconButton(
                                      onPressed: () {
                                        context
                                            .read<UpdateCurrentUserDataCubit>()
                                            .addFavorite(
                                                drink.idDrink.toString());
                                      },
                                      icon: const Icon(
                                        Icons.favorite_outline,
                                        size: 30,
                                      ),
                                      color: Colors.white,
                                      iconSize: 30,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        context
                                            .read<UpdateCurrentUserDataCubit>()
                                            .removeFavorite(
                                                drink.idDrink.toString());
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        size: 30,
                                      ),
                                      color: Colors.white,
                                      iconSize: 30,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text(
                      'Category: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      drink.strAlcoholic ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 340,
                child: Text(
                  drink.strInstructions ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                width: 300,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: meas.length,
                  itemBuilder: (context, index) {
                    final measurence = meas[index];
                    final ingredience = ing[index];
                    final isIngNull = measurence == null || ingredience == null;

                    return Column(
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
