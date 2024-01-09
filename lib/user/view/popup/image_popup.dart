// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wepick/common/dio/file_dio.dart';
import 'package:wepick/common/component/custom_alert_pop.dart';
import 'package:wepick/common/component/custom_circleAvatar.dart';
import 'package:wepick/user/provider/user_provider.dart';

import '../../../common/const/data.dart';
import '../../../file/provider/file_provider.dart';

class ImagePopup extends ConsumerStatefulWidget {
  final Function? onImageUploadComplete;
  String? networkImgUrl;

  ImagePopup({
    this.onImageUploadComplete,
    this.networkImgUrl,
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
      actions: [
        ElevatedButton(
          child: Text('변경완료'),
          onPressed: () async {
            if (_image != null) {
              final result = await ref
                  .read(fileProvider.notifier)
                  .setProfileImage(_image!);
              // ignore: curly_braces_in_flow_control_structures
              if (result != null) if (result.resultData != null) {
                Navigator.of(context).pop();

                if (widget.onImageUploadComplete != null) {
                  widget.onImageUploadComplete!.call();
                }

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
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('닫기'),
        ),
      ],
      contentPadding: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_image != null)
            Image.file(
              File(_image!.path),
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          if (_image == null && widget.networkImgUrl != null)
            Image.network(
              'http://$ip/file/me/getProfileImg?pid=${widget.networkImgUrl}',
              width: 200.0,
              height: 200.0,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                  _pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt_outlined),
              ),
              IconButton(
                icon: Icon(Icons.photo_camera_back),
                onPressed: () async {
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
