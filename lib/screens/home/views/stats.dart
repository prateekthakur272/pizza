import 'package:flutter/material.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/home/widgets/chart.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Text(
              'Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            space24,
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surface
              ),
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: const MyChart()),
          ],
        ),
      ),
    );
  }
}
