import 'dart:io';

import 'package:expense_tracker_app/models/expense.dart' as Expense;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense.Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleControllor = TextEditingController();
  final _amountControllor = TextEditingController();
  Expense.Category _selectedCategory = Expense.Category.leisure;
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Invalid Data!"),
              content: Text("Please check inputs."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Okay"),
                )
              ],
            );
          });
    }
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Invalid Data!"),
              content: Text("Please check inputs."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Okay"),
                )
              ],
            );
          });
    }
  }

  void _validateAndSave() {
    final enteredExpense = double.tryParse(_amountControllor.text);
    final isEnteredAmountValid = enteredExpense == null || enteredExpense <= 0;
    if (_titleControllor.text.trim().isEmpty ||
        isEnteredAmountValid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(Expense.Expense(
        amount: enteredExpense,
        title: _titleControllor.text,
        category: _selectedCategory,
        date: _selectedDate!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleControllor.dispose();
    _amountControllor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constrains) {
      final width = constrains.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSize + 16),
            child: Column(
              children: [
                if (width > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleControllor,
                          maxLength: 50,
                          decoration: InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountControllor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleControllor,
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width > 600)
                  Row(
                    children: [
                      DropdownButton(
                          icon: Icon(
                            Expense.categoryIcons[_selectedCategory],
                          ),
                          value: _selectedCategory,
                          items: Expense.Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              _selectedCategory = value;
                            });
                            print(value);
                          }),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected.'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.date_range),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountControllor,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected.'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.date_range),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                SizedBox(
                  height: 15,
                ),
                if (width > 600)
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _validateAndSave,
                        child: Text("Save Expense"),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          icon: Icon(
                            Expense.categoryIcons[_selectedCategory],
                          ),
                          value: _selectedCategory,
                          items: Expense.Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              _selectedCategory = value;
                            });
                            print(value);
                          }),
                      Spacer(),
                      ElevatedButton(
                        onPressed: _validateAndSave,
                        child: Text("Save Expense"),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
