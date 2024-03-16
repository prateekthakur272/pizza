import 'dart:developer';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/add_expense/add_category.dart';
import 'package:pizza/screens/add_expense/blocs/category_bloc.dart';
import 'package:pizza/screens/add_expense/blocs/expense_bloc.dart';
import 'package:pizza/widgets/custom_form_field.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _expenseController = TextEditingController();
  final _dateController = TextEditingController();
  Category? _selectedCategory;

  bool _categorySelectorEnabled = false;

  final _expense = Expense.empty;

  bool _isAddButtonEnabled = true;

  @override
  void initState() {
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _expense.id = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseLoading) {
          setState(() {
            _isAddButtonEnabled = false;
          });
        } else if (state is ExpenseCreated) {
          setState(() {
            _isAddButtonEnabled = true;
            Navigator.pop(context);
          });
        } else if (state is ExpenseFailed) {
          _isAddButtonEnabled = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                label: _selectedCategory == null
                    ? 'Category'
                    : _selectedCategory!.name,
                prefixIcon: _selectedCategory == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ImageIcon(AssetImage(
                            'assets/${_selectedCategory!.icon}.png')),
                      ),
                suffixIcon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider<CategoryBloc>(
                                    create: (context) => CategoryBloc(
                                        FirebaseExpenseRepositry()),
                                    child: const AddCategoryScreen(),
                                  )));
                    },
                    icon: const Icon(Icons.add)),
                onTap: () {
                  setState(() {
                    _categorySelectorEnabled = !_categorySelectorEnabled;
                  });
                },
              ),
              space8,
              Visibility(
                  visible: _categorySelectorEnabled,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is GetCategoryListSuccess) {
                            if (state.categories.isEmpty) {
                              return const Text(
                                  'Nothing to show, create category');
                            }
                            return ListView.builder(
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  final category = state.categories[index];
                                  return ListTile(
                                    iconColor: _selectedCategory == category
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                    textColor: _selectedCategory == category
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                    onTap: () {
                                      setState(() {
                                        _selectedCategory = category;
                                        _expense.category = category;
                                      });
                                    },
                                    title: Text(category.name),
                                    leading: ImageIcon(AssetImage(
                                        'assets/${category.icon}.png')),
                                  );
                                });
                          } else {
                            return const Text('some error occurred');
                          }
                        },
                      ),
                    ),
                  )),
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
                  if (newDate != null) {
                    _dateController.text =
                        DateFormat('dd-MM-yyyy').format(newDate);
                    _expense.date = newDate;
                  }
                },
              ),
              space32,
              Visibility(
                visible: _isAddButtonEnabled,
                replacement: CircularProgressIndicator(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_selectedCategory == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.grey.shade700,
                              content: const Text('Please select category')));
                          return;
                        }
                        try {
                          _expense.amount =
                              int.parse(_expenseController.text.trim());
                          context
                              .read<ExpenseBloc>()
                              .add(CreateExpense(_expense));
                        } on FormatException catch (e) {
                          log(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Enter a valid amount')));
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: const Text('Save')),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
