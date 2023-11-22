import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/user_provider.dart';

class DefaultLayout extends ConsumerWidget {
  final Widget child;
  final String? title;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    this.backgroundColor,
    required this.child,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModelBase? state = ref.read(userProvider);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      drawer: state is! UserModel
          ? null
          : renderDrawer(state.userNm, state.userEmail),
    );
  }

  // null을 반환하기 위한 퀘션마크
  AppBar? renderAppBar() {
    if (title != null) {
      return AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message_outlined,
            ),
          ),
        ],
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    } else {
      return null;
    }
  }

  Drawer? renderDrawer(String accountName, String accountEmail) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/img/user/my_profile.jpeg',
              ),
            ),
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
          ),
        ],
      ),
    );
  }
}
