import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/utils/extensions.dart';

import '../../../../data/repositories/models/drinks_model/drink.dart';
import '../../../../utils/const.dart';
import '../../../display_drinks/view/widgets/user_page.dart';
import '../../../update_firestore_data.dart/cubit/update_current_user_data_cubit.dart';
import '../../bloc/cubit/favorite_drink_of_user_cubit.dart';

class FavoriteDisplay extends StatefulWidget {
  const FavoriteDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteDisplay> createState() => _FavoriteDisplayState();
}

class _FavoriteDisplayState extends State<FavoriteDisplay> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FavoriteDrinkOfUserCubit>().getFavoriteByApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    context.loc.favoriteButton,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserPage()));
                    },
                    icon: const Icon(
                      Icons.account_circle,
                      size: 35,
                    )),
              )
            ],
          ),
          BlocBuilder<FavoriteDrinkOfUserCubit, FavoriteDrinkOfUserState>(
            builder: (context, state) => state.when(
              favoriteLoading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              favoriteLoadError: (e) =>
                  const Text('Sorry, an error occurred. Try again.'),
              favoriteLoadSuccess: (data) => FavoriteBuilder(drinksData: data),
            ),
          )
        ],
      ),
    );
  }
}

class FavoriteBuilder extends StatelessWidget {
  const FavoriteBuilder({
    Key? key,
    required this.drinksData,
  }) : super(key: key);

  final List<Drink> drinksData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () =>
            context.read<FavoriteDrinkOfUserCubit>().getFavoriteByApi(),
        child: drinksData.isEmpty
            ? const Center(
                child: Text(
                  'Add your first favorite drink!',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: drinksData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      var ing = drinksData[index]
                          .ingriedientProperties()
                          .whereType<String>()
                          .toList();
                      var meas = drinksData[index]
                          .measureProperties()
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
                                    height: 290,
                                    width: 250,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: meas.length,
                                      itemBuilder: (context, index) {
                                        var ingIndex = ing[index];
                                        var measIndex = meas[index];

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              " $ingIndex - $measIndex",
                                              style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 10),
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
                          image: NetworkImage(drinksData[index].strDrinkThumb ??
                              linkDrinkPicture),
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
                                          borderRadius:
                                              BorderRadius.circular(25)),
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
                                                .read<
                                                    UpdateCurrentUserDataCubit>()
                                                .removeFavorite(
                                                    drinksData[index].idDrink!)
                                                .then((value) =>
                                                    Navigator.of(context).pop())
                                                .then((value) => context
                                                    .read<
                                                        FavoriteDrinkOfUserCubit>()
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
      ),
    );
  }
}
