import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/const/api_message.dart';
import 'package:wepick/common/view/test/test_kakao.dart';
import 'package:wepick/common/view/test/test_pop_route.dart';
import 'package:wepick/user/view/popup/image_popup.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/common/view/test/test_custom_drawer.dart';
import 'package:wepick/common/view/test/test_default_input_filed.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/user_provider.dart';

class TestTab extends ConsumerWidget {
  static String get routeName => 'test';
  const TestTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.read(userProvider.notifier);
    return DefaultLayout(
      title: '테스트',
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.pushNamed(TestInputField.routeName);
            },
            child: Text('Default Input Field'),
          ),
          ElevatedButton(
            onPressed: () async {
              final user = UserModel.createEncPwModel(
                userId: 'test43124321',
                userNm: 'test',
                userPw: 'wlsgmlHan1!',
                userPhoneNum: '0101231212312321',
                userEmail: 'teas12341234@naver.com',
              );

              print('userId : ${user.userId}');
              print('userNm : ${user.userNm}');
              print('userPw : ${user.userPw}');
              print('userPhoneNum : ${user.userPhoneNum}');
              print('userEmail : ${user.userEmail}');
              print('userImgUrl : ${user.userImgUrl}');

              final resp = await userState.join(user: user);

              if (resp.status != SUCCESS_CODE) {
                print(resp.resultMsg);
              }

              print(resp.resultMsg);
            },
            child: Text('Join Test'),
          ),
          ElevatedButton(
            onPressed: () {
              context.pushNamed(TestDrawerTab.routeName);
            },
            child: Text('Test Tab'),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return ImagePopup();
                },
              );
            },
            child: Text('Image Tab'),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed(KaKaoShareTest.routeName);
            },
            child: Text('kakao test'),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed(TestPopRoute.routeName);
            },
            child: Text('pop route test'),
          ),
        ],
      ),
    );
  }
}
