import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/main.dart';

import '../../../login/bloc/bloc/authentication_bloc.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});
  final String? userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Material(
        child: ColoredBox(
          color: Colors.black,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                          size: 40,
                        )),
                  ),
                ],
              ),
              Center(
                  child: SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Email:  $userEmail',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent[700],
                        disabledForegroundColor: Colors.grey.withOpacity(0.25),
                      ),
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(const AuthenticationEvent.logoutRequested());

                        Navigator.of(context).pushAndRemoveUntil<void>(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const AppView()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
