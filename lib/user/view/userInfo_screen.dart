// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/image/view/image_popup.dart';
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

    return DefaultLayout(
      title: '내 정보',
      child: Column(
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
                                  return ImagePopup();
                                },
                              );
                              print('탭!');
                            },
                            child: CircleAvatar(
                              radius: 80.0,
                              backgroundImage: AssetImage(
                                'assets/img/user/my_profile.jpeg',
                              ),
                            ),
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
      ),
    );
  }
}
