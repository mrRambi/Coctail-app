import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/bloc/cubit/drink_cubit.dart';
import 'package:recipe_app/repository/drink_repo.dart';
import 'package:recipe_app/screens/coctail_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coctail app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => DrinkCubit(DrinkRepo()),
        child: const CoctailScreen(),
      ),
    );
  }
}
