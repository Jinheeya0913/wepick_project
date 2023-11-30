// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/const/colors.dart';
import 'package:wepick/common/image/view/image_popup.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/default_layout.dart';

import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static String get routeName => 'me';
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.read(userProvider);

    if (state is UserModelLoading || state is UserModelError) {
      return Container(
        child: Text('데이터 없음'),
      );
    }
    state as UserModel;

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: ColoredBox(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32.0,
                        horizontal: 8.0,
                      ),
                      child: ColoredBox(
                        color: Colors.black,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return ImagePopup(
                                  onImageUploadComplete:
                                      handleImageUploadComplete,
                                );
                              },
                            );
                            print('탭!');
                          },
                          child: CustomCircleAvatar(
                            radius: 80.0,
                            defaultAssetUrl: 'assets/img/user/my_profile.jpeg',
                            networkImgUrl: state.userImgUrl,
                          ),

                          // CircleAvatar(
                          //   radius: 80.0,
                          //   backgroundImage: AssetImage(
                          //     'assets/img/user/my_profile.jpeg',
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32.0,
                        horizontal: 8.0,
                      ),
                      child: ColoredBox(
                        color: Colors.pinkAccent,
                        child: Column(
                          children: [
                            Text('유저1 :${state.userNm} '),
                            Text('유저1 :${state.userEmail}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: Text('아래 데이터'),
          ),
        )
      ],
    );
  } // build

  BottomNavigationBar renderNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: PRIMARY_COLOR,
      unselectedItemColor: BODY_TEXT_COLOR,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {},
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈으로'),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '기타'),
      ],
    );
  }

  void handleImageUploadComplete() async {
    await ref.read(userProvider.notifier).getMe(); // 유저 정보 새로고침
    setState(() {});
  }
} // _UserInfoScreenState
