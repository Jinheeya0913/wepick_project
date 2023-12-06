// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wepick/common/layout/component/text/custom_text_con_bottom_ln.dart';

class PartnerSearchResultPopup extends StatelessWidget {
  static String get routeName => 'partnerSearchResultPop';

  const PartnerSearchResultPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomTextConBottom(text: '파트너 찾기'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                height: 300,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 16.0,
              ),
              Icon(
                Icons.circle,
                color: Colors.lightGreen,
              ),
            ],
          )
        ],
      ),
    );
  }
}
