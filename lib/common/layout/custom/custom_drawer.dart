import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/view/root_tab.dart';
import 'package:wepick/user/provider/user_provider.dart';

import '../../../user/model/user_model.dart';
import 'custom_circleAvatar.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final UserModel state = ref.read(userProvider) as UserModel;

    String accountName = state.userNm;
    String accountEmail = state.userEmail;
    String? accountImgUrl = state.userImgUrl;

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CustomCircleAvatar(
              networkImgUrl: accountImgUrl,
              defaultAssetUrl: 'assets/img/user/my_profile.jpeg',
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
            leading: Icon(Icons.home_outlined),
            title: Text('홈으로'),
            onTap: () {
              print('홈으로');
              Navigator.of(context).pop();
              context.pushNamed(RootTab.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('설정'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('로그아웃'),
            onTap: () {
              ref.read(userProvider.notifier).logout();
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('글 작성(임시)'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
