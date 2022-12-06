import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';
import 'package:recipe_app/utils/extensions.dart';

import '../../../../data/repositories/models/drinks_model/drink.dart';
import '../../../../utils/const.dart';
import '../../../update_firestore_data.dart/cubit/update_current_user_data_cubit.dart';
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
//
    return RefreshIndicator(
      onRefresh: () =>
          context.read<FavoriteDrinkOfUserCubit>().getFavoriteByApi(),
      child: ListView.builder(
        itemCount: drinksData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              var ing = drinksData[index]
                  .ingriedientProperties()
                  .toList()
                  .whereType<String>()
                  .toList();
              var meas = drinksData[index]
                  .measureProperties()
                  .toList()
                  .whereType<String>()
                  .toList();

              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.white,
                  title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        drinksData[index].strDrink ?? '',
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      )),
                  content: SizedBox(
                      width: 300,
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              drinksData[index].strInstructions ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 200,
                              width: 250,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: meas.length,
                                itemBuilder: (context, index) {
                                  var meal = ing[index];
                                  var date = meas[index];
                                  return Text(
                                    " $meal - $date",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(context.loc.out,
                          style: const TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 250,
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
                    Colors.black.withOpacity(0.1),
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
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 35,
                      ),
                      onPressed: () async {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              backgroundColor: Colors.white,
                              title: Text(
                                context.loc.wannaDelete,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    context.loc.out,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    context.loc.yes,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<UpdateCurrentUserDataCubit>()
                                        .removeFavorite(
                                            drinksData[index].idDrink!)
                                        .then((value) =>
                                            Navigator.of(context).pop())
                                        .then((value) => context
                                            .read<FavoriteDrinkOfUserCubit>()
                                            .getFavoriteByApi());
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        drinksData[index].strDrink ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
