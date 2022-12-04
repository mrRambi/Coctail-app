import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login/bloc/bloc/authentication_bloc.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});
  final String? userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Align(
            heightFactor: 5,
            widthFactor: 8,
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 40,
                )),
          ),
          Center(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            width: 320,
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Email:  $userEmail',
                  style: const TextStyle(fontSize: 20),
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
                    Navigator.pop(context);
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
    );
  }
}
