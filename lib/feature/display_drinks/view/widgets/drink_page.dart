import 'package:flutter/material.dart';

import '../../../../data/repositories/models/drinks_model/drink.dart';
import '../../../../utils/const.dart';

class DrinkPage extends StatelessWidget {
  const DrinkPage({super.key, required this.drink});

  final Drink drink;

  @override
  Widget build(BuildContext context) {
    var ing = drink.measureProperties().toList();
    var meas = drink.ingriedientProperties().toList();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.exit_to_app_outlined),
          ),
          SizedBox(
              height: 200,
              width: 200,
              child: Image.network(drink.strDrinkThumb ?? linkDrinkPicture)),
          SizedBox(
            child: Text(drink.strDrink ?? 'drinkname'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    child: Text('Category'),
                  ),
                  SizedBox(
                    child: Text(drink.strCategory ?? ''),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    child: Text('Glass'),
                  ),
                  SizedBox(
                    child: Text(drink.strGlass ?? ''),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    child: Text('Alcoholic?'),
                  ),
                  SizedBox(
                    child: Text(drink.strAlcoholic ?? ''),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 200,
            width: 300,
            child: ListView.builder(
              itemCount: ing.length,
              itemBuilder: (context, index) {
                final measurence = meas[index];
                final ingredience = ing[index];
                final isIngNull = measurence == null || ingredience == null;

                return Column(
                  children: [
                    if (!isIngNull) Text("$ingredience - $measurence"),
                    if (isIngNull) const SizedBox(),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            child: Text(drink.strInstructions ?? ''),
          ),
        ],
      ),
    );
  }
}
