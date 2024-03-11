import 'package:flutter/material.dart';
import 'package:pizza/constants/constants.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final int value;
  final Color? iconBackground;
  final IconData icon;
  final DateTime transactionTimeStamp;
  const TransactionItem({super.key, required this.title, required this.value, this.iconBackground, required this.icon, required this.transactionTimeStamp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface
      ),
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
                  color: iconBackground ?? Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Icon(icon, color: Colors.white,)
            ],
          ),
          space16,
          Text(title,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          space16,
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Rs $value', style: const TextStyle(),),
              Text(transactionTimeStamp.toString(), style: TextStyle(color: Theme.of(context).colorScheme.outline),)
            ],
          )
        ],
      ),
    );
  }
}