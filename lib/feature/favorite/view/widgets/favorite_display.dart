import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';

import '../../../../data/repositories/models/drinks_model/drink.dart';
import '../../../../utils/const.dart';
import '../../bloc/cubit/favorite_drink_of_user_cubit.dart';

class FavoriteDisplay extends StatelessWidget {
  const FavoriteDisplay({
    Key? key,
    required this.currentUserRepo,
    required this.drinksData,
  }) : super(key: key);

  final CurrentUserRepo currentUserRepo;
  final List<Drink> drinksData;

  @override
  Widget build(BuildContext context) {
    var ing = drinksData.map((e) => e.ingriedientProperties()).toList();
    var meas = drinksData.map((e) => e.measureProperties()).toList();

    return RefreshIndicator(
      onRefresh: () =>
          context.read<FavoriteDrinkOfUserCubit>().getFavoriteByApi(),
      child: ListView.builder(
        itemCount: drinksData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(drinksData[index].strDrink ?? ''),
                  content: SizedBox(
                    height: 200,
                    width: 150,
                    child: ListView.builder(
                      // itemCount: ing?.length,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final measurence = meas[0][index];
                        final ingredience = ing[0][index];
                        final isIngNull =
                            measurence == null || ingredience == null;

                        return Column(
                          children: [
                            if (index == 0)
                              Text(drinksData[index].strInstructions ?? ''),
                            if (isIngNull) const SizedBox(),
                            if (!isIngNull) Text("$ingredience - $measurence"),
                          ],
                        );
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("Ok"),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(
                      0.0,
                      10.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.multiply,
                  ),
                  image: NetworkImage(
                      drinksData[index].strDrinkThumb ?? linkDrinkPicture),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        // drinksData.drinks?[index].strDrink ?? 'drink name',
                        '',
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
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         padding: const EdgeInsets.all(5),
                  //         margin: const EdgeInsets.all(10),
                  //         decoration: BoxDecoration(
                  //           color: Colors.black.withOpacity(0.4),
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //         child: Row(
                  //           children: [
                  //             BlocBuilder<FavoriteDrinkOfUserCubit,
                  //                 FavoriteDrinkOfUserState>(
                  //               builder: (context, state) {
                  //                 return state.when(
                  //                   favoriteLoading: () => IconButton(
                  //                       onPressed: () {},
                  //                       icon:
                  //                           const Icon(Icons.favorite_outline),
                  //                       color: Colors.white,
                  //                       iconSize: 18),
                  //                   favoriteLoadError: (e) => Text(e),
                  //                   favoriteLoadSuccess: (value) => SizedBox(
                  //                     child: !value.contains(
                  //                             drinksData.drinks?[index].idDrink)
                  //                         ? IconButton(
                  //                             onPressed: () {
                  //                               context
                  //                                   .read<
                  //                                       FavoriteDrinkOfUserCubit>()
                  //                                   .addFavorite(drinksData
                  //                                           .drinks?[index]
                  //                                           .idDrink ??
                  //                                       '');
                  //                             },
                  //                             icon: const Icon(
                  //                                 Icons.favorite_outline),
                  //                             color: Colors.white,
                  //                             iconSize: 18,
                  //                           )
                  //                         : IconButton(
                  //                             onPressed: () {
                  //                               context
                  //                                   .read<
                  //                                       FavoriteDrinkOfUserCubit>()
                  //                                   .removeFavorite(drinksData
                  //                                           .drinks?[index]
                  //                                           .idDrink ??
                  //                                       '');
                  //                             },
                  //                             icon: const Icon(Icons.favorite),
                  //                             color: Colors.white,
                  //                             iconSize: 18,
                  //                           ),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //             const SizedBox(width: 7),
                  //             Text(
                  //               context.loc.favoriteButton,
                  //               style: const TextStyle(
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
