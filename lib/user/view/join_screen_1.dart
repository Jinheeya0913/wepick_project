import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/const/api_message.dart';
import 'package:wepick/common/const/error.dart';
import 'package:wepick/common/component/custom_alert_pop.dart';
import 'package:wepick/common/utils/validationUtil.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/user_provider.dart';

import '../../common/component/text/custom_text_form_field.dart';
import '../../common/layout/default_layout.dart';

class JoinScreen extends ConsumerStatefulWidget {
  static String get routeName => "join";
  const JoinScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.read(userProvider.notifier);

    String userNm = '';
    String userId = '';
    String userPw = '';
    String userPwConfirm = '';
    String userAddress = '';
    String userEmail = '';
    String userPhoneNum = '';

    return DefaultLayout(
      title: '회원가입 1/2',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                // manual : done을 눌렀을 때 키보드 비활성
                // onDrag : 드래그 하면
                child: SafeArea(
                  top: true,
                  bottom: true,
                  left: true,
                  right: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        contentPadding: 10,
                        hintText: '이름을 입력해주세요',
                        onChanged: (String value) {
                          userNm = value;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        contentPadding: 10,
                        hintText: 'ID를 입력해주세요',
                        onChanged: (String value) {
                          userId = value;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        contentPadding: 10,
                        hintText: '비밀번호을 입력해주세요',
                        obscureText: true,
                        onChanged: (String value) {
                          userPw = value;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        contentPadding: 10,
                        hintText: '비밀번호을 재입력해주세요',
                        obscureText: true,
                        onChanged: (String value) {
                          userPwConfirm = value;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        contentPadding: 10,
                        hintText: '이메일을 입력해주세요',
                        onChanged: (String value) {
                          userEmail = value;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        // 전화번호 입력
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              digitOnly: true,
                              contentPadding: 10,
                              maxLength: 11,
                              hintText: '전화번호 (\'-\' 없이 입력)',
                              onChanged: (String value) {
                                userPhoneNum = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('인증번호'),
                          )
                        ],
                      ),
                      Row(
                        // 인증번호 입력
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              digitOnly: true,
                              contentPadding: 10,
                              maxLength: 4,
                              hintText: '인증번호',
                              onChanged: (String value) {
                                userPhoneNum = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('인증확인'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('개인정보 이용동의'),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '자세히보기',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                ColoredBox(
                  color: Colors.pinkAccent,
                  child: Row(
                    children: [
                      Text('체크'),
                      Text('ㅁ'),
                    ],
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF22A45D),
                ),
                onPressed: () async {
                  String? valid = checkValid(userNm, userId, userPw,
                      userPwConfirm, userEmail, userPhoneNum);

                  // Todo 회원가입 버튼 동작 작성하기
                  if (valid != null) {
                    // 검증 실패
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomSimpleAlertPop(
                          title: '회원가입 실패',
                          content: valid,
                        );
                      },
                    );
                  } else {
                    final user = UserModel.createEncPwModel(
                      userId: userId,
                      userNm: userNm,
                      userPw: userPw,
                      userPhoneNum: userPhoneNum,
                      userEmail: userEmail,
                    );

                    final result = await state.join(user: user);

                    if (result.status != SUCCESS_CODE) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomSimpleAlertPop(
                            title: '회원가입 실패',
                            content: valid,
                          );
                        },
                      );
                    }

                    // 정상 임시
                  }
                },
                child: const Text('회원가입 2/2'),
              ),
            )
          ],
        ),
      ),
    );
  }

  String? checkValid(String userNm, String userId, String userPw,
      String userPwConfirm, String userEmail, String userPhoneNum) {
    // 입력값 확인

    if (userNm == '') {
      return JOIN_INPUT_NAME;
    } else if (userId == '') {
      return JOIN_INPUT_ID;
    } else if (userPw == '') {
      return JOIN_INPUT_PASSWORD_1;
    } else if (userPwConfirm == '') {
      return JOIN_INPUT_PASSWORD_2;
    } else if (userPw != userPwConfirm) {
      return JOIN_INPUT_PASSWORD_NEQ;
    } else if (userEmail == '') {
      return JOIN_INPUT_EMAIL;
    } else if (userPhoneNum == '') {
      return JOIN_INPUT_PHONE;
    }

    // 비밀번호 정규식 확인
    String? validPw = ValidUtil.validPasswordFormat(userPw);

    if (validPw != null) {
      print('valid >> 비밀번호 ${validPw}');
      return validPw;
    }

    // 전화번호 형식 확인
    String? validPhone = ValidUtil.validPhoneNumberFormat(userPhoneNum);

    if (validPhone != null) {
      print('valid >> 전화번호 : ${validPhone}');
      return validPhone;
    }

    // 이메일 정규식 확인

    String? validEmail = ValidUtil.validEmailFormat(userEmail);

    if (validEmail != null) {
      print('valid >> 전화번호 : ${validEmail}');
      return validEmail;
    }

    return null;
  }

  void joinFailed(String? valid) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomSimpleAlertPop(
          title: '회원가입 실패',
          content: valid,
        );
      },
    );
  }
}
