import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:wepick/common/provider/go_router_provider.dart';

void main() {
  // flutter run --no-enable-impeller
  //  flutter pub run build_runner watch
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하기 위해서는 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  // runApp 호출 전 Flutter Sdk 초기화

  KakaoSdk.init(
    nativeAppKey: '9f24a29b858f9d349526d0239f9221ee',
    javaScriptAppKey: '6c61202fac17ac2bfa6ae6f9d87d0ebc',
  );

  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      localizationsDelegates: const [
        // 앱 자체 언어 설정 로컬라이제이션 구성
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        // 앱에서 지원하는 언어 목록 설정
        Locale('ko', 'KR'), // 한국어
        Locale('en', 'US'), // 한국어
      ],
      // 라우터 사용
      // 디버그 배너 비활성화
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      routerConfig: router,
    );
  }
}
