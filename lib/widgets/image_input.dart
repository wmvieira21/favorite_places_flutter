import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectingImage});

  final Function(File image) onSelectingImage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
        maxHeight: 300,
        imageQuality: 100);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
      widget.onSelectingImage(_selectedImage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onSecondary),
      label: Text('Take picture'),
      icon: Icon(Icons.camera),
      onPressed: () => _takePicture(),
    );

    if (_selectedImage != null) {
      return GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.fill,
          width: double.infinity,
          height: 300,
        ),
      );
    }

    return Container(
        width: double.infinity,
        height: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 230)),
        ),
        child: content);
  }
}
