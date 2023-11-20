import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/auth/model/auth_login_response_model.dart';
import 'package:wepick/common/dio/dio.dart';

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

  Future<AuthLoginResponse> login({
    required String userId,
    required String userPw,
  }) async {
    final loginModel = AuthLoginRequestModel.createEncPwModel(
      userId: userId,
      userPw: userPw,
    );

    final resp = await dio.post(
      '$baseUrl/login',
      data: jsonEncode(loginModel),
    );

    print('[authRepository] >>  ' + resp!.headers.map.toString());
    print('[authRepository] >>  ' + resp!.data.toString());

    return AuthLoginResponse.fromJson(resp!.headers.map);
  }
}
