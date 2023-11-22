import 'package:flutter/cupertino.dart';
import 'package:wepick/common/layout/default_input_filed.dart';
import 'package:wepick/common/layout/default_layout.dart';

class TestInputField extends StatelessWidget {
  static String get routeName => 'input';
  const TestInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '인풋 테스트',
      child: Column(
        children: [
          DefaultInputField(
            subtitle: '이름',
          ),
        ],
      ),
    );
  }
}
