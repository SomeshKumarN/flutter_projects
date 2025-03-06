import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/model/grocery_item.dart';
import 'package:shopping_app/widget/newitem.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  var _error;

  void addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewItem(),
      ),
    );

    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
    // loadItems();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadItems();
  }

  void loadItems() async {
    try {
      Uri url = Uri.https(
          'flutter-shopping-list-187e3-default-rtdb.firebaseio.com',
          'grocery_list.json');
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode != 200) {
        _error = "Failed to fetch the data.";
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
          return;
        });
      } else {
        final Map<String, dynamic> listData = json.decode(response.body);
        final List<GroceryItem> loadedItems = [];

        for (final item in listData.entries) {
          final category = categories.entries
              .firstWhere(
                  (catItem) => catItem.value.name == item.value['category'])
              .value;
          loadedItems.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ));
        }
        setState(() {
          _groceryItems = loadedItems;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Something went wrong!";
        _isLoading = false;
      });
    }
  }

  void removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    Uri url = Uri.https(
        'flutter-shopping-list-187e3-default-rtdb.firebaseio.com',
        'grocery_list/${item.id}.json');
    final response = await http.delete(url);
    debugPrint(response.body);

    if (response.statusCode != 200) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // loadItems();
    Widget content = Center(
      child: Text('No items added yet!'),
    );

    if (_isLoading) {
      content = Center(child: CircularProgressIndicator());
    }
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          background: Container(color: Color.fromRGBO(211, 69, 69, 0.8)),
          onDismissed: (direction) {
            removeItem(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }
    if (_error != null) {
      content = Center(
        child: Text(_error),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries1'),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
