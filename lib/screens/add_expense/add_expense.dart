import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/screens/add_expense/add_category.dart';
import 'package:pizza/screens/add_expense/blocs/category_bloc.dart';
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

  bool _categorySelectorEnabled = false;

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
              controller: _categoryController,
              label: 'Category',
              prefixIcon: const Icon(FontAwesomeIcons.list),
              suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<CategoryBloc>(
                                  create: (context) =>
                                      CategoryBloc(FirebaseExpenseRepositry()),
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
                          return ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                return ListTile(
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
