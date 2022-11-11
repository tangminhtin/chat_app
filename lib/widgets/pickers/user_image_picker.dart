import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(XFile pickedImage) imagePickFn;

  const UserImagePicker({
    super.key,
    required this.imagePickFn,
  });

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (image == null) {
      return;
    }
    setState(() {
      _pickedImage = image;
    });
    widget.imagePickFn(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.orangeAccent,
          backgroundImage: _pickedImage != null
              ? FileImage(
                  File(_pickedImage!.path),
                )
              : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(
            Icons.image,
            color: Colors.blue,
          ),
          label: const Text(
            'Add image',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
