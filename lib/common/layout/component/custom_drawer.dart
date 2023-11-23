import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/user/provider/user_provider.dart';
import 'package:wepick/user/view/userInfo_modify_screen.dart';
import 'package:wepick/user/view/userInfo_screen.dart';

import '../../../user/model/user_model.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final UserModel state = ref.read(userProvider) as UserModel;

    // final UserModel state = UserModel.createEncPwModel(
    //   userId: 'taran0913',
    //   userNm: '하이',
    //   userPw: 'wlsgmlhan0913',
    //   userPhoneNum: '01098672202',
    //   userEmail: 'taran0913@naver.com',
    // );

    String accountName = state.userNm;
    String accountEmail = state.userEmail;
    String? accountImgUrl = state.userImgUrl;

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                accountImgUrl ?? 'assets/img/user/my_profile.jpeg',
              ),
            ),

            accountName: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(accountName),
                ],
              ),
            ),
            accountEmail: Text(accountEmail),
            // onDetailsPressed: () {
            //   print('아래로 펼치기 ');
            // },
            decoration: BoxDecoration(
              color: Colors.purple[200],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text('내 정보!'),
            onTap: () {
              context.goNamed('me');
            },
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('설정'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
