import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories.values.first;

  void saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new Item"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text("Name"),
              ),
              maxLength: 50,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1) {
                  return 'Name should be atleast 2 characters long.';
                }
                return null;
              },
              onSaved: (newValue) {
                _enteredName = newValue!;
              },
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("Quantity"),
                  ),
                  initialValue: _enteredQuantity.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0) {
                      return 'Quantity should be a positive number.';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredQuantity = int.parse(newValue!);
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButtonFormField(
                  value: _selectedCategory,
                  items: [
                    for (var category in categories.entries)
                      DropdownMenuItem(
                        value: category.value,
                        child: Row(children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: category.value.color,
                          ),
                          SizedBox(width: 10),
                          Text(category.value.name)
                        ]),
                      ),
                  ],
                  onChanged: (context) {},
                  onSaved: (newValue) {
                    _selectedCategory = newValue!;
                  },
                ),
              ),
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                },
                child: Text('Reset'),
              ),
              ElevatedButton(
                onPressed: saveItem,
                child: Text('Add Item'),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
