import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final Function(File imageFile) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: Icon(Icons.camera),
      label: Text('Take Picture!'),
      onPressed: _takePicture,
    );

    if (imageFile != null) {
      content = GestureDetector(
          onTap: _takePicture,
          child: Image.file(
            imageFile!,
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ));
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        height: 250,
        width: double.infinity,
        child: content);
  }

  void _takePicture() async {
    var imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (selectedImage == null) {
      return;
    }
    setState(() {
      imageFile = File(selectedImage.path);
    });
    widget.onPickImage(imageFile!);
  }
}
