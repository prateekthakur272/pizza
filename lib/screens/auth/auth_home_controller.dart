import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/authentication_bloc.dart';
import 'package:pizza/screens/add_expense/blocs/expense_bloc.dart';
import 'package:pizza/screens/auth/auth_screen.dart';
import 'package:pizza/screens/home/home_screen.dart';

class AuthHomeController extends StatelessWidget {
  const AuthHomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationSuccess) {
        return BlocProvider(
          create: (context) => ExpenseBloc(FirebaseExpenseRepositry()),
          child: const HomeScreen(),
        );
      }
      return const AuthScreen();
    });
  }
}
