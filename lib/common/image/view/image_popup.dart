// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePopup extends StatefulWidget {
  const ImagePopup({
    Key? key,
  }) : super(key: key);

  @override
  State<ImagePopup> createState() => _ImagePopupState();
}

class _ImagePopupState extends State<ImagePopup> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile as XFile;
      });
    }

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('이미지 업로드'),
      contentPadding: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            _image != null
                ? Image.file(
                    File(_image!.path),
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  )
                : Text('사진 없음'),
            ElevatedButton(
              onPressed: () async {
                _pickImage(ImageSource.camera);
              },
              child: Text('카메라에서 사진 선택'),
            ),
            ElevatedButton(
              onPressed: () async {
                _pickImage(ImageSource.gallery);
              },
              child: Text('갤러리에서 사진 선택'),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: Text('사진 업로드'),
            ),
          ],
        ),
      ),
    );
  }
}
