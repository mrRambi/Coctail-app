// ignore_for_file: avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';
import 'package:recipe_app/data/remote_data_sources/drink_api.dart';
import 'package:recipe_app/data/repositories/drink_repository.dart';
import 'package:recipe_app/data/service/drink_service.dart';
import 'package:recipe_app/feature/display_drinks/view/drink_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_app/feature/favorite/bloc/cubit/favorite_drink_of_user_cubit.dart';
import 'package:recipe_app/feature/login/bloc/bloc/authentication_bloc.dart';
import 'package:recipe_app/feature/login/bloc/cubit/login_cubit.dart';
import 'package:recipe_app/feature/registration/cubit/sign_up_cubit.dart';

import 'data/remote_data_sources/firebase_repo.dart';

import 'di.dart';
import 'feature/display_drinks/cubit/drink_cubit.dart';

import 'feature/favorite/view/favorite_screen.dart';
import 'feature/search/view/cubit/search_drink_cubit.dart';
import 'feature/update_firestore_data.dart/cubit/update_current_user_data_cubit.dart';
import 'l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp();
  configureDependencies();
  await getIt.allReady();

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (context) => CurrentUserRepo(getIt(), getIt()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DrinkCubit(
              DrinkRepository(
                drinkService: DrinkService(drinkApi: DrinkApi()),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(getIt()),
          ),
          BlocProvider(
            create: (context) => LoginCubit(getIt(), getIt()),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(getIt(), getIt()),
          ),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  FavoriteDrinkOfUserCubit(getIt())..getFavoriteByApi()),
          BlocProvider(
            create: (context) =>
                UpdateCurrentUserDataCubit(getIt())..readUserColection(),
          ),
          BlocProvider(
            create: (context) => SearchDrinkCubit(getIt())..readFavorite(''),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          theme: ThemeData(
            canvasColor: Colors.grey[800],
            colorScheme: const ColorScheme.highContrastDark(),
            textTheme: GoogleFonts.lobsterTextTheme(
              const TextTheme(
                headline1: TextStyle(color: Colors.white),
                headline6: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white),
              ),
            ),
          ),
          home: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _selectedIndex = 0;
  PageController controller = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    controller.animateToPage(index,
        duration: const Duration(microseconds: 1000), curve: Curves.elasticIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      extendBody: true,
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF0b0130), Color(0xFF190957)],
          ),
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: const <Widget>[
            DrinkScreen(),
            FavoriteScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              backgroundColor: Colors.red,
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              backgroundColor: Colors.blue,
              label: ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
