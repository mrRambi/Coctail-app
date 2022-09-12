import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';
import 'package:recipe_app/data/repositories/drink_repository.dart';
import 'package:recipe_app/feature/display_drinks/view/drink_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_app/feature/favorite/bloc/cubit/favorite_drink_of_user_cubit.dart';
import 'package:recipe_app/feature/favorite/view/favorite.dart';
import 'package:recipe_app/feature/login/bloc/bloc/authentication_bloc.dart';
import 'package:recipe_app/feature/login/bloc/cubit/login_cubit.dart';
import 'package:recipe_app/feature/login/view/widgets/login_form.dart';
import 'package:recipe_app/feature/registration/cubit/sign_up_cubit.dart';

import 'data/remote_data_sources/firebase_repo.dart';
import 'di.dart';
import 'feature/display_drinks/cubit/drink_cubit.dart';

import 'l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  final currentUserRepo = CurrentUserRepo();

  configureDependencies();
  await dotenv.load(fileName: ".env");

  runApp(MyApp(
    authenticationRepository: authenticationRepository,
    currentUserRepo: currentUserRepo,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      required AuthenticationRepository authenticationRepository,
      required CurrentUserRepo currentUserRepo})
      : _authenticationRepository = authenticationRepository,
        _currentUserRepo = currentUserRepo,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  final CurrentUserRepo _currentUserRepo;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider(
          create: (context) => CurrentUserRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DrinkCubit(
              DrinkRepository(
                drinkService: getIt(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(_authenticationRepository),
          ),
          BlocProvider(
            create: (context) => LoginCubit(_authenticationRepository),
          ),
          BlocProvider(
            create: (context) =>
                SignUpCubit(_authenticationRepository, _currentUserRepo),
          ),
          BlocProvider(
            create: (context) => FavoriteDrinkOfUserCubit(getIt()),
          ),
        ],
        child: MaterialApp(
          title: 'Coctail app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          theme: ThemeData(
            primarySwatch: Colors.blue,
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('space for awesome icon'),
          ],
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: <Widget>[
          const DrinkScreen(),
          Builder(builder: (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return state.map(
                    unknown: (_) => BlocProvider(
                          create: (context) => AuthenticationBloc(getIt()),
                          child: const LoginForm(),
                        ),
                    authenticated: (_) => const Favorite(),
                    unauthenticated: (_) => const LoginForm());
              },
            );
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.loop_outlined),
              backgroundColor: Colors.red,
              label: 'Main Page'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: Colors.blue,
              label: 'Login Page'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
