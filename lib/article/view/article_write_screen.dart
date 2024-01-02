// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wepick/article/component/review_tab.dart';
import 'package:wepick/article/view/gift_write_layout.dart';
import 'package:wepick/article/view/hall_write_layout.dart';
import 'package:wepick/article/view/package_write_layout.dart';
import 'package:wepick/common/layout/custom/button/custom_home_button.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';
import 'package:wepick/common/layout/default_layout.dart';

import '../../common/const/colors.dart';
import '../../common/layout/custom/button/custom_circle_icon_text_button.dart';

class ArticleWriteScreen extends StatefulWidget {
  static get routeName => 'articleWrite';

  const ArticleWriteScreen({Key? key}) : super(key: key);

  @override
  State<ArticleWriteScreen> createState() => _ArticleWriteScreenState();
}

class _ArticleWriteScreenState extends State<ArticleWriteScreen>
    with SingleTickerProviderStateMixin {
  int selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '견적 작성',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _icon(0, '예식장', FontAwesomeIcons.building),
                  _icon(1, 'input', FontAwesomeIcons.building),
                  _icon(2, '예물', FontAwesomeIcons.building),
                ],
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                switch (selectedRadio) {
                  case 0:
                    return Expanded(child: HallWriteLayout());
                  case 1:
                    return Expanded(child: PackageWriteLayout());
                  case 2:
                    return Expanded(child: GiftWriteLayout());
                  default:
                    return Expanded(child: Container());
                }
              },
            ),
            Row(
              children: [Text('버튼')],
            ),
          ],
        ),
      ),
    );
  }

  //https://stackoverflow.com/questions/67285333/radio-button-style-using-icon-buttons-in-flutter
  Widget _icon(int index, String text, IconData icon) {
    return InkResponse(
      child: Column(
        children: [
          Icon(
            icon,
            color: selectedRadio == index ? Colors.red : null,
          ),
          Text(
            text,
            style: TextStyle(color: selectedRadio == index ? Colors.red : null),
          ),
        ],
      ),
      onTap: () => setState(() {
        selectedRadio = index;
      }),
    );
  }

  Widget buildForm(String formTitle) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            formTitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // 여기에 각 폼 필드를 추가하세요.
        ],
      ),
    );
  }
}
