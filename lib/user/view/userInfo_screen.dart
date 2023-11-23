import 'package:flutter/material.dart';
import 'package:wepick/common/layout/default_layout.dart';

class UserInfoScreen extends StatefulWidget {
  static String get routeName => 'userInfo';
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Text('정보수정'),
    );
  }
}
