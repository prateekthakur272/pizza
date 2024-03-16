import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/screens/add_expense/add_expense.dart';
import 'package:pizza/screens/add_expense/blocs/category_bloc.dart';
import 'package:pizza/screens/home/views/home.dart';
import 'package:pizza/screens/home/views/stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          IndexedStack(index: index, children: const [HomeView(), StatsView()]),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add',
        shape: const CircleBorder(),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddExpenseScreen()));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider<CategoryBloc>(
                        create: (context) =>
                            CategoryBloc(FirebaseExpenseRepositry())..add(GetCategoryList()),
                        child: const AddExpenseScreen(),
                      )));
        },
        child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  transform: const GradientRotation(pi / 4),
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    // Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary
                  ]),
            ),
            child: const Icon(CupertinoIcons.add)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          elevation: 8,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.graph_square_fill), label: 'Stats'),
          ],
        ),
      ),
    );
  }
}
