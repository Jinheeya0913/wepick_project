import 'package:flutter/cupertino.dart';

import '../../common/layout/default_layout.dart';

class UserInfoModiScreen extends StatefulWidget {
  static String get routeName => 'modify';

  const UserInfoModiScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoModiScreen> createState() => _UserInfoModiScreenState();
}

class _UserInfoModiScreenState extends State<UserInfoModiScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '테스트',
      child: Text('data'),
    );
  }
}
