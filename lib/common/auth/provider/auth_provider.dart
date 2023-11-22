// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/view/root_tab.dart';
import 'package:wepick/common/view/splash_screen.dart';
import 'package:wepick/common/view/test/test_default_input_filed.dart';
import 'package:wepick/common/view/test/test_tab.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/user_provider.dart';
import 'package:wepick/user/view/join_screen_1.dart';
import 'package:wepick/user/view/join_screen_2.dart';
import 'package:wepick/user/view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) {
    return AuthProvider(ref: ref);
  },
);

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  /**
   * 라우터 등록
   */

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'join',
              name: JoinScreen.routeName,
              builder: (_, __) => JoinScreen(),
            ),
            GoRoute(
              path: 'join2',
              name: JoinScreen2.routeName,
              builder: (_, __) => JoinScreen2(),
            )
          ],
        ),
        GoRoute(
            path: '/test',
            name: TestTab.routeName,
            builder: (_, __) => TestTab(),
            routes: [
              GoRoute(
                path: 'input',
                name: TestInputField.routeName,
                builder: (_, __) => TestInputField(),
              ),
            ]),
      ];

  /** Splash Screen
  *  앱을  시작했을 때
  *  토큰이 존재하는지 확인하고
  *  로그인으로 보낼지 홈스크린으로 보낼지 확인하는 과정이 필요하다
  */

  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userProvider);
    final logginIn = state.location == '/login';
    final location = state.location;

    print('[authProvider] >> state.location : ${location}');

    if (location.startsWith('/login/join') // 회원가입
        ||
        location.startsWith('/test')) // 테스트
    {
      return location;
    }

    if (user == null) {
      print('[authProvider] >> user Null 로그인 페이지로 이동 ');
      return logginIn ? null : '/login';
    }

    // userModel
    // 사용자 정보가 있으면 홈으로 이동
    if (user is UserModel) {
      // 로그인 중인 페이지 || 스플래쉬 페이지
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    // UserModelError
    if (user is UserModelError) {
      print('[authProvider] >> 오류 페이지로 이동');
      return !logginIn ? '/login' : null;
    }

    if (user is UserModelLoading) {
      print('[authProvider] >> 무한 로딩;;');
    }

    return null;
  }
}
