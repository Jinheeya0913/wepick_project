import 'package:flutter/material.dart';

class UserInfoTab extends StatefulWidget {
  final bool isRow;

  const UserInfoTab({
    this.isRow = true,
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfoTab> createState() => _UserInfoTabState();
}

class _UserInfoTabState extends State<UserInfoTab> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(children: [
              Text('파트너 알림'),
              Text('0건'),
            ]),
          ),
          Expanded(
            child: Column(children: [
              Text('진행 상황'),
              Text('0건'),
            ]),
          ),
          Expanded(
            child: Column(children: [
              Text('진행 상황'),
              Text('0건'),
            ]),
          ),
        ],
      ),
    );
  }
}
