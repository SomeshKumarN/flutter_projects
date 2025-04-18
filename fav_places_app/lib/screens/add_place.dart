import 'package:fav_places_app/model/place.dart';
import 'package:fav_places_app/providers/user_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  _savePlace() {
    final title = _titleController.text;
    if (title.isEmpty) {
      return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(Place(title: title));
    // Here you would typically call a method to save the place
    // For example: ref.read(userPlaceProvider.notifier).addPlace(Place(title: title));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Place"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            ElevatedButton(
              onPressed: _savePlace,
              child: Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}
