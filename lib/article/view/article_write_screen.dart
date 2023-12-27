// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wepick/article/component/review_tab.dart';
import 'package:wepick/common/layout/custom/button/custom_home_button.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';
import 'package:wepick/common/layout/default_layout.dart';

import '../../common/const/colors.dart';

class ArticleWriteScreen extends StatefulWidget {
  static get routeName => 'articleWrite';

  const ArticleWriteScreen({Key? key}) : super(key: key);

  @override
  State<ArticleWriteScreen> createState() => _ArticleWriteScreenState();
}

class _ArticleWriteScreenState extends State<ArticleWriteScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '리뷰 작성',
      leadingButton: CustomHomeButton(),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          Center(
            child: Container(
              child: const Text('data'),
            ),
          ),
          Center(
            child: Container(
              child: const Text('data'),
            ),
          ),
          Center(
            child: Container(
              child: const Text('data'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          tabController.animateTo(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.building),
            label: '예식장',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.building),
            label: '스드메',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: '예물',
          ),
        ],
      ),
    );
  }

  void tabListener() {
    setState(() {
      index = tabController.index;
    });
  }
}
