import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizza/constants/constants.dart';

class TransactionItem extends StatelessWidget {
  final Expense expense;
  const TransactionItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(expense.category.color),
                ),
              ),
              ImageIcon(
                AssetImage('assets/${expense.category.icon}.png'),
                color: Theme.of(context).colorScheme.surface,
              ),
            ],
          ),
          space16,
          Text(
            expense.category.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          space16,
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rs ${expense.amount}',
                style: const TextStyle(),
              ),
              Text(
                DateFormat().format(expense.date),
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              )
            ],
          )
        ],
      ),
    );
  }
}
