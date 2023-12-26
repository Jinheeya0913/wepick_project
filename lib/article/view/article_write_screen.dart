// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';
import 'package:wepick/common/layout/default_layout.dart';

class ArticleWriteScreen extends StatefulWidget {
  static get routeName => 'articleWrite';

  const ArticleWriteScreen({Key? key}) : super(key: key);

  @override
  State<ArticleWriteScreen> createState() => _ArticleWriteScreenState();
}

class _ArticleWriteScreenState extends State<ArticleWriteScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '리뷰 작성',
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    hintText: '제목',
                    onChanged: (value) {},
                  ),

                  Expanded(
                    child: CustomTextFormField(
                      maxLines: null,
                      hintText: '내용을 입력하세요',
                      onChanged: (value) {},
                    ),
                  ),
                  // 버튼
                  Row(),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('올리기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
