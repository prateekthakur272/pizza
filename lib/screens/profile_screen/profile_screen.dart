import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza/blocs/authentication_bloc.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/auth/blocs/sign_in_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user =
        (context.read<AuthenticationBloc>().state as AuthenticationSuccess)
            .user;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 32,
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        foregroundColor: Theme.of(context).colorScheme.primary),
                  )),
              const FaIcon(
                FontAwesomeIcons.user,
                size: 56,
              ),
              space16,
              Text(
                user.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(user.email),
              space32,
              ElevatedButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(SignOutRequired());
                    Navigator.pop(context);
                  },
                  child: const Text('Sign out'))
            ],
          ),
        ),
      ),
    );
  }
}
