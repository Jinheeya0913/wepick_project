import 'package:flutter/material.dart';
import 'package:wepick/common/layout/default_layout.dart';

class ReviewCreateScreen extends StatelessWidget {
  static get routeName => 'reviewCreate';
  const ReviewCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '리뷰 작성',
      child: Container(),
    );
  }
}
