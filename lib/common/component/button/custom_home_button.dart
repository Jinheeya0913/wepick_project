import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/view/root_tab.dart';

class CustomHomeButton extends StatelessWidget {
  const CustomHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.goNamed(RootTab.routeName);
      },
      icon: const Icon(Icons.home_outlined),
    );
  }
}
