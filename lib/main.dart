import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/user/view/login_screen.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 배너 비활성화
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: LoginScreen(),
    );
  }
}
