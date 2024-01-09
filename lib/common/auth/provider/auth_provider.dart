// ignore_for_file: slash_for_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/estimate/view/esti_write_screen.dart';
import 'package:wepick/product/view/search_hall_screen.dart';
import 'package:wepick/product/view/search_place_screen.dart';
import 'package:wepick/common/view/root_tab.dart';
import 'package:wepick/common/view/splash_screen.dart';
import 'package:wepick/common/view/test/template/test_googleMap.dart';
import 'package:wepick/common/view/test/test_custom_drawer.dart';
import 'package:wepick/common/view/test/test_default_input_filed.dart';
import 'package:wepick/common/view/test/test_kakao.dart';
import 'package:wepick/common/view/test/test_liquid.dart';
import 'package:wepick/common/view/test/test_pop_route.dart';
import 'package:wepick/common/view/test/test_tab.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';
import 'package:wepick/partner/view/partnerInfo_screen.dart';
import 'package:wepick/partner/view/partner_request_info_screen.dart';
import 'package:wepick/review/view/review_create_screen.dart';
import 'package:wepick/review/view/review_hall_write_screen.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/user_provider.dart';
import 'package:wepick/user/view/join_screen_1.dart';
import 'package:wepick/user/view/join_screen_2.dart';
import 'package:wepick/user/view/login_screen.dart';
import 'package:wepick/user/view/userInfo_modify_screen.dart';
import 'package:wepick/user/view/myweding_screen.dart';

import '../../view/test/test_pop_route2.dart';

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
          routes: [
            GoRoute(
              path: 'partnerReqInfo',
              name: PartnerRequestInfoScreen.routeName,
              builder: (_, state) => PartnerRequestInfoScreen(),
            ),
          ],
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
          path: '/me',
          name: MyWedingScreen.routeName,
          builder: (_, __) => MyWedingScreen(),
        ),
        GoRoute(
          path: '/partnerInfo',
          name: PartnerInfoScreen.routeName,
          builder: (_, state) => PartnerInfoScreen(),
        ),
        GoRoute(
          path: '/articleWrite',
          name: ArticleWriteScreen.routeName,
          builder: (_, state) => ArticleWriteScreen(),
          routes: [],
        ),
        GoRoute(
          path: '/placeSearch',
          name: SearchPlaceScreen.routeName,
          builder: (_, state) => const SearchPlaceScreen(),
        ),
        GoRoute(
          path: '/reviewWriteHall',
          name: ReviewWriteHallScreen.routeName,
          builder: (_, state) => const ReviewWriteHallScreen(),
        ),
        GoRoute(
          path: '/hallSearch:placeName',
          name: SearchHallScreen.routeName,
          builder: (_, state) => SearchHallScreen(
            placeName: state.pathParameters["placeName"].toString(),
          ),
        ),
        GoRoute(
          // 테스트용 Router
          path: '/test',
          name: TestTab.routeName,
          builder: (_, __) => TestTab(),
          routes: [
            GoRoute(
              path: 'input',
              name: TestInputField.routeName,
              builder: (_, __) => TestInputField(),
            ),
            GoRoute(
              path: 'testhome',
              name: TestDrawerTab.routeName,
              builder: (_, __) => TestDrawerTab(),
            ),
            GoRoute(
              path: 'modify',
              name: UserInfoModiScreen.routeName,
              builder: (_, __) => UserInfoModiScreen(),
            ),
            GoRoute(
              path: 'kakaoShare',
              name: KaKaoShareTest.routeName,
              builder: (_, __) => KaKaoShareTest(),
            ),
            GoRoute(
              path: 'popRoute',
              name: TestPopRoute.routeName,
              builder: (_, __) => TestPopRoute(),
            ),
            GoRoute(
              path: 'popRoute2',
              name: TestPopRoute2.routeName,
              builder: (_, __) => TestPopRoute2(),
            ),
            GoRoute(
              path: 'liquid',
              name: TestLiquid.routeName,
              builder: (_, __) => TestLiquid(),
            ),
            // GoRoute(
            //   path: 'googleMap',
            //   name: TestGoogleMap.routeName,
            //   builder: (_, __) => TestGoogleMap(),
            // ),
          ],
        ),
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
