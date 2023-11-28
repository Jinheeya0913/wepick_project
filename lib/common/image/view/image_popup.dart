// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wepick/common/dio/file_dio.dart';
import 'package:wepick/common/layout/component/custom_error_pop.dart';
import 'package:wepick/user/provider/user_provider.dart';

import '../../file/provider/file_provider.dart';

class ImagePopup extends ConsumerStatefulWidget {
  const ImagePopup({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ImagePopup> createState() => _ImagePopupState();
}

class _ImagePopupState extends ConsumerState<ImagePopup> {
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
              onPressed: () async {
                if (_image != null) {
                  final result = await ref
                      .read(fileProvider.notifier)
                      .setProfileImage(_image!);
                  // ignore: curly_braces_in_flow_control_structures
                  if (result != null) if (result.resultData != null) {
                    Navigator.of(context).pop();
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (_) => CustomSimpleAlertPop(
                        title: 'title',
                        content: '변경이 완료되었습니다',
                      ),
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => CustomSimpleAlertPop(
                      title: '이미지 전송 실패',
                      content: '사진을 선택해주세요',
                    ),
                  );
                }
              },
              child: Text('사진 업로드'),
            ),
          ],
        ),
      ),
    );
  }
}
