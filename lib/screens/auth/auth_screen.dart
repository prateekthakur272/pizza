import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/authentication_bloc.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/auth/blocs/sign_in_bloc.dart';
import 'package:pizza/screens/auth/blocs/sign_up_bloc.dart';
import 'package:pizza/screens/auth/views/sign_in_view.dart';
import 'package:pizza/screens/auth/views/sign_up_view.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        // Container(
        //   color: Colors.yellow.shade200,
        // ),
        Align(
          alignment: const AlignmentDirectional(-5, -1.2),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: colorPrimary),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(2, 1.2),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.6,
            height: MediaQuery.of(context).size.width / 1.6,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: colorSecondary),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
          child: Container(),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  'Pizza',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                const Text(
                  'Your budget buddy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                space8,
                space8,
                if (showLogin)
                  BlocProvider(
                    create: (context) => SignInBloc(
                        context.read<AuthenticationBloc>().userRepository),
                    child: const SignInView(),
                  ),
                if (!showLogin)
                  BlocProvider(
                    create: (context) => SignUpBloc(
                        context.read<AuthenticationBloc>().userRepository),
                    child: const SignUpView(),
                  ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          showLogin = !showLogin;
                        });
                      },
                      child: const Text('Don\'t have an account? Create one')),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
