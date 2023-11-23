import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/custom_drawer.dart';
import 'package:wepick/user/view/userInfo_modify_screen.dart';

import '../../../user/model/user_model.dart';

class TestDefaultLayout extends ConsumerWidget {
  final Widget child;
  final String? title;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;

  const TestDefaultLayout({
    this.backgroundColor,
    required this.child,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // test용
    final UserModel state = UserModel.createEncPwModel(
      userId: 'taran0913',
      userNm: '테스트',
      userPw: 'wlsgmlhan0913',
      userPhoneNum: '01098672202',
      userEmail: 'taran0913@naver.com',
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      drawer: CustomDrawer(),
    );
  }

  // null을 반환하기 위한 퀘션마크
  AppBar? renderAppBar() {
    if (title != null) {
      return AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message_outlined,
            ),
          ),
        ],
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    } else {
      return null;
    }
  }
}
