import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/authentication_bloc.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/add_expense/blocs/expense_bloc.dart';
import 'package:pizza/screens/home/widgets/transaction_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ExpenseBloc>().add(GetExpenses());
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
      if (state is ExpensesFetched) {
        final expenses = state.expenses;
        return SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(children: [
                Row(
                  children: [
                    // Container(
                    //   height: 56,
                    //   width: 56,
                    //   decoration: BoxDecoration(
                    //       color: colorTertiary, shape: BoxShape.circle),
                    // ),
                    FloatingActionButton(
                      elevation: 0,
                      backgroundColor: colorTertiary,
                      foregroundColor: Colors.black,
                      onPressed: () {},
                      shape: const CircleBorder(),
                      child: const Icon(CupertinoIcons.person_fill),
                    ),
                    space8,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome,',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: outlineColor),
                          ),
                          Text(
                            (context.read<AuthenticationBloc>().state
                                    as AuthenticationSuccess)
                                .user
                                .name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ]),
                    space8,
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.settings_solid))
                  ],
                ),
                space24,
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [colorPrimary, colorTertiary, colorSecondary],
                        transform: const GradientRotation(pi / 4)),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(fontSize: 18, color: colorOnPrimary),
                      ),
                      Text(
                        (expenses.map((e) => e.amount)).reduce((value, element) => value+element).toString(),
                        style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: colorOnPrimary),
                      ),
                      space16,
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(.2)),
                            child: const Icon(
                              CupertinoIcons.arrow_down,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          space8,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Income',
                                style: TextStyle(color: colorOnPrimary),
                              ),
                              Text(
                                'Rs. 12000',
                                style: TextStyle(
                                    color: colorOnPrimary,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          space24,
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(.4)),
                            child: const Icon(
                              CupertinoIcons.arrow_up,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          space8,
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expanses',
                                style: TextStyle(color: colorOnPrimary),
                              ),
                              Text(
                                'Rs. 7000',
                                style: TextStyle(
                                    color: colorOnPrimary,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                space24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                space16,
                Expanded(
                  child: ListView.separated(
                    itemCount: expenses.length,
                    separatorBuilder: (context, index) => space16,
                    itemBuilder: (context, index) => TransactionItem(expense: expenses[index],),
                  ),
                )
              ])),
        );
      }
      if(state is ExpenseLoading){
        return const Center(child: CircularProgressIndicator());
      }
      return const Center(child: Text('error'));
    });
  }
}
