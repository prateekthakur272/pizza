import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/widgets/custom_form_field.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _expenseController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).colorScheme.primary,
                elevation: 2,
                child: const Icon(Icons.close),
              ),
            ),
            const Text(
              'Add Expense',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            space16,
            CustomFormField(
              label: 'Amount',
              controller: _expenseController,
              prefixIcon: const Icon(FontAwesomeIcons.rupeeSign),
            ),
            space16,
            CustomFormField(
              readOnly: true,
              controller: _categoryController,
              label: 'Category',
              prefixIcon: const Icon(FontAwesomeIcons.list),
              suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
              onTap: () {
                
              },
            ),
            space16,
            CustomFormField(
              readOnly: true,
              label: 'Date',
              controller: _dateController,
              prefixIcon: const Icon(FontAwesomeIcons.calendar),
              onTap: () async {
                final newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)));
                  if(newDate!=null){
                    _dateController.text = DateFormat('dd-MM-yyyy').format(newDate);
                  }
              },
            ),
            space32,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black),
                  ),
                  child: const Text('Save')),
            )
          ],
        ),
      )),
    );
  }
}
