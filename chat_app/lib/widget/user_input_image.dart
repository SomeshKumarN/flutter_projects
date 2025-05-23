import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInputImage extends StatefulWidget {
  const UserInputImage({super.key, required this.onSelectImage});
  final void Function(File pickedImage) onSelectImage;

  @override
  State<UserInputImage> createState() => _UserInputImageState();
}

class _UserInputImageState extends State<UserInputImage> {
  File? _pickedImageFile;
  void _selectImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onSelectImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _selectImage,
          icon: Icon(Icons.photo),
          label: Text('Select Photo'),
        ),
      ],
    );
  }
}
