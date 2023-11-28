import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/auth/model/auth_login_response_model.dart';
import 'package:wepick/common/auth/model/token_model.dart';
import 'package:wepick/common/auth/provider/auth_provider.dart';
import 'package:wepick/common/const/api_message.dart';
import 'package:wepick/common/dio/dio.dart';
import 'package:wepick/common/model/api_result_model.dart';
import 'package:wepick/common/provider/secure_storage.dart';

import '../../const/data.dart';
import '../model/auth_login_request_model.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return AuthRepository(
      baseUrl: 'http://$ip/auth',
      dio: dio,
    );
  },
);

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<AuthLoginResponse?> login({
    required String userId,
    required String userPw,
  }) async {
    print('[authRepository] >>  로그인 수행 ');
    final loginModel = AuthLoginRequestModel.createEncPwModel(
      userId: userId,
      userPw: userPw,
    );

    final resp = await dio.post(
      '$baseUrl/login',
      data: jsonEncode(loginModel.toJson(loginModel)),
    );

    if (resp.data != null) {
      final apiResult = ApiResult.fromData(resp.data);

      if (apiResult.status != SUCCESS_CODE) {
        print('[authRepo] >> 실패하였습니다.');
        return null;
      }

      final accessToken = resp.headers['accessToken'].toString();
      final refreshToken = resp.headers['refreshToken'].toString();

      final tokenModel =
          TokenModel(accessToken: accessToken, refreshToken: refreshToken);

      final responseModel =
          AuthLoginResponse(tokenModel: tokenModel, apiResult: apiResult);

      // AuthLoginResponse.print('[authRepository] >>  로그인 수행 종료 ');
      return responseModel;
    } else {
      return null;
    }
  }

  Future<AuthLoginResponse?> validToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    final resp = await dio.post(
      '$baseUrl/validToken',
      options: Options(
        headers: {
          ACCESS_TOKEN_KEY: accessToken,
          REFRESH_TOKEN_KEY: refreshToken,
        },
      ),
    );

    final respAccess = resp.headers[ACCESS_TOKEN_KEY].toString();
    final respRefresh = resp.headers[REFRESH_TOKEN_KEY].toString();

    final tokenModel =
        TokenModel(accessToken: respAccess, refreshToken: respRefresh);

    print('[authRepo] >> respAccess : $respAccess');
    print('[authRepo] >> respRefresh : $respRefresh');

    final apiResult = ApiResult.fromData(resp.data);

    print('[authRepo] >> apiResult : ${apiResult.resultCode}');
    print('[authRepo] >> apiResult : ${apiResult.resultMsg}');

    final authResponse = AuthLoginResponse(
      apiResult: apiResult,
      tokenModel: tokenModel,
    );
    return authResponse;
  }
}
