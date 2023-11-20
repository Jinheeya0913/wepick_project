import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/auth/repository/auth_repository.dart';
import 'package:wepick/common/const/data.dart';
import 'package:wepick/common/dio/dio.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/user_provider.dart';

import '../../common/auth/model/auth_login_request_model.dart';
import '../../common/const/colors.dart';
import '../../common/layout/component/custom_text_form_field.dart';
import '../../common/layout/default_layout.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreeState();
}

class _LoginScreeState extends ConsumerState<LoginScreen> {
  String userId = '';
  String userPw = '';

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(authRepositoryProvider);
    final state = ref.watch(userProvider.notifier);

    // final authState = ref.watch(auth)
    // final state = ref.watch(userProvider);
    return DefaultLayout(
      child: SingleChildScrollView(
        child: SafeArea(
          // SafeArea를 통해 기종마다 다른 출력 규격으로 인해 화면이 잘리는 현상을 방지
          top: true,
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(
                  height: 16.8,
                ),
                const _SubTitle(),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (value) {
                    userId = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  obscureText: true,
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (value) {
                    userPw = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  // 우하단에 그림자가 생겨 입체적으로 보이는 버튼
                  // Todo : 로그인 구현해볼 것
                  onPressed: (() async {
                    final loginModel = AuthLoginRequestModel.createEncPwModel(
                        userId: userId, userPw: userPw);

                    final resp =
                        await state.login(userId: userId, userPw: userPw);

                    if (resp is UserModel) {
                      print('[LoginScreen] >> ${resp.userId}');
                    } else {
                      print('[LoginScreen] >> ${resp.toString()}');

                      if (resp is UserModelError) {
                        print('[LoginScreen] >> ${resp.message}');
                      }
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text(
                    '로그인',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Tdoo 회원가입을 생성해주시오
                    /*Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const JoinScreen(),
                    ));*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BODY_TEXT_COLOR,
                  ),
                  child: const Text(
                    '회원가입',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text(
                    '유저 정보 테스트',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요!',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }
}