import 'dart:io';

import 'package:fav_places_app/model/place.dart';
import 'package:fav_places_app/providers/user_places_provider.dart';
import 'package:fav_places_app/widgets/image_input.dart';
import 'package:fav_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  _savePlace() {
    final title = _titleController.text;
    if (title.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(
        Place(title: title, image: _pickedImage!, location: _pickedLocation!));
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
            SizedBox(height: 10),
            ImageInput(
              onPickImage: (imageFile) {
                _pickedImage = imageFile;
              },
            ),
            SizedBox(height: 10),
            LocationInput(
              onPickLocation: (pickedLocation) {
                _pickedLocation = pickedLocation;
              },
            ),
            SizedBox(height: 10),
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
