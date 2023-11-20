import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wepick/common/secure_storage/secure_storage.dart';

import '../const/data.dart';

// Todo Interceptor 미완성
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}]');
    print('[REQ] >> ACCESS_TOKEN_KEY : [${options.headers[ACCESS_TOKEN_KEY]}]');

    /*if (options.headers[ACCESS_TOKEN_KEY] == 'true') {
      options.headers.remove(ACCESS_TOKEN_KEY);
      print('[REQ] >> accessToken >> 실제 토큰으로 대체 ');
      //
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      // print('[REQ] >> accessToken  : Baerer $accessToken');
      options.headers.addAll({
        ACCESS_TOKEN_KEY: 'Bearer $accessToken',
      });
    }*/
    //
    // if (options.headers['refreshToken'] == 'true') {
    //   print('[REQ] >> refreshToken >> 실제 토큰으로 대체 ');
    //   options.headers.remove('refreshToken');
    //   final token = await storage.read(key: REFRESH_TOKEN_KEY);
    //
    //   options.headers.addAll({
    //     'authorization': 'Bearer $token',
    //   });
    // }

    return super.onRequest(options, handler);
  }

  // 응답 받을 때

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}]');

    // print('[RES] ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 에러가 났을 때
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 새로운 토큰을 요청한다
    print(
        '[ERROR 발생] [${err.requestOptions.method}] ${err.requestOptions.uri}]');
    // print('[ERROR] > message : ' + err.stackTrace.toString());
    //
    // final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    //
    // if (refreshToken == null) {
    //   return handler.reject(err);
    // }
    //
    // final isStatus401 = err.response?.statusCode == 401;
    // final isPathRefresh = err.requestOptions.path == '/auth/token';
    //
    // if (isStatus401 && !isPathRefresh) {
    //   final dio = Dio();
    //
    //   try {
    //     final resp = await dio.post(
    //       'http://$ip/auth/token',
    //       options: Options(
    //         headers: {
    //           'authorization': 'Bearer $refreshToken',
    //         },
    //       ),
    //     );
    //     final accessToken = resp.data['accessToken'];
    //     final options = err.requestOptions;
    //
    //     // 토큰 변경
    //     options.headers.addAll({
    //       'authorization': 'Bearer $accessToken',
    //     });
    //
    //     await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
    //
    //     // 요청 재전송
    //     final response = await dio.fetch(options);
    //
    //     return handler.resolve(response);
    //   } on DioError catch (e) {
    //     /**
    //      * Circular Dependency error ::
    //      * 무한 순환 에러
    //      * ump -> dio - > ump -> dio
    //      * 상위 객체를 하나 만듦으로써 해결 가능하다.
    //      */
    //     ref.read(authProvider.notifier).logout();
    //
    //     return handler.reject(e);
    //   }
    // }

    // return handler.resolve(res);
    return handler.reject(err);
  }
}
