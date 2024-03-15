import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza/constants/constants.dart';
import 'package:pizza/widgets/custom_form_field.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];
  var _iconSelectorExpanded = false;

  String _iconSelected = 'home';
  Color _colorSelected = colorPrimary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        iconSize: 32,
                        style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            foregroundColor:
                                Theme.of(context).colorScheme.primary),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))),
                const Text(
                  'Add Category',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                space24,
                const CustomFormField(
                  label: 'Category',
                  prefixIcon: Icon(FontAwesomeIcons.list),
                ),
                space16,
                CustomFormField(
                  readOnly: true,
                  label: 'Icon',
                  suffixIcon: const Icon(FontAwesomeIcons.chevronDown),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageIcon(AssetImage('assets/$_iconSelected.png'),),
                  ),
                  onTap: () {
                    setState(() {
                      _iconSelectorExpanded = !_iconSelectorExpanded;
                    });
                  },
                ),
                space8,
                Visibility(
                  visible: _iconSelectorExpanded,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4),
                        itemCount: myCategoriesIcons.length,
                        itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: _iconSelected ==
                                              myCategoriesIcons[index]
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _iconSelected = myCategoriesIcons[index];
                                  });
                                },
                                child: ImageIcon(
                                  color: _iconSelected ==
                                          myCategoriesIcons[index]
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface,
                                  AssetImage(
                                      'assets/${myCategoriesIcons[index]}.png'),
                                ),
                              ),
                            )),
                  ),
                ),
                space16,
                CustomFormField(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: Column(children: [
                                ColorPicker(
                                  pickerColor: _colorSelected,
                                  onColorChanged: (Color value) {
                                    setState(() {
                                      _colorSelected = value;
                                    });
                                  },
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Done'))
                              ]),
                            )));
                  },
                  readOnly: true,
                  label: 'Color',
                  suffixIcon: const Icon(FontAwesomeIcons.chevronDown),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: _colorSelected),
                    ),
                  ),
                ),
                space8,
                space16,
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Add')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
