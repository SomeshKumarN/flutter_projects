import 'package:expense_tracker_app/models/expense.dart' as Expense;
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

  void _validateAndSave() {
    final enteredExpense = double.tryParse(_amountControllor.text);
    final isEnteredAmountValid = enteredExpense == null || enteredExpense <= 0;
    if (_titleControllor.text.trim().isEmpty ||
        isEnteredAmountValid ||
        _selectedDate == null) {
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
      return;
    }
    widget.onAddExpense(Expense.Expense(
        amount: enteredExpense,
        title: _titleControllor.text,
        category: _selectedCategory,
        date: _selectedDate!));
  }

  @override
  void dispose() {
    _titleControllor.dispose();
    _amountControllor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleControllor,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
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
    );
  }
}
