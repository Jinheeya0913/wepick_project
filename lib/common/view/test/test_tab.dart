import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/common/view/test/test_default_input_filed.dart';

class TestTab extends StatelessWidget {
  static String get routeName => 'test';
  const TestTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '테스트',
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.pushNamed(TestInputField.routeName);
            },
            child: Text('Default Input Field'),
          )
        ],
      ),
    );
  }
}
