import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wepick/common/auth/repository/auth_repository.dart';
import 'package:wepick/common/model/api_result_model.dart';
import 'package:wepick/common/provider/secure_storage.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/repository/user_repository.dart';

import '../../common/const/data.dart';

final userProvider =
    StateNotifierProvider<UserStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserStateNotifier(
    authRepository: authRepository,
    userRepository: userRepository,
    storage: storage,
  );
});

class UserStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final FlutterSecureStorage storage;

  UserStateNotifier({
    required this.authRepository,
    required this.userRepository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // Todo : 토큰 만료 오류일 경우 에러 해결 하기 (완료)
    getMe();
    // logout();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      // 토큰이 둘다 없으면 상태를 null로 만들어 로그오프 된 상태임을 알려야 함.
      print('[userMeProvider] >> getMe >> 토큰 없음');
      state = null;
      return;
    }

    print('[userMeProvider] >> getMe >> 토큰 있음');

    final resp = await userRepository.getMe();

    if (resp.resultCode == "101") {
      // 응답이 정상일 때
      print('[userMeProvider] >> resp >> ${resp.resultCode}');
      final resultData = Map<String, dynamic>.from(resp.resultData as Map);
      final userData = UserModel.fromJson(resultData);
      state = userData;
    } else if (resp.resultCode == "200") {
      // 응답이 정상이 아닐 때 :: 200 토큰 만료
      print('[userMeProvider] >> resp >> result : ${resp.result}');
      print('[userMeProvider] >> resp >> status : ${resp.status}');

      final divisionCode = resp.result.split(':')[1];
      print('[userMeProvider] >> resp >> divisionCode : $divisionCode');

      if (divisionCode == 'T001') {
        // 토큰 재발급
        print('[userMeProvider] >> 토큰 재발급 ');
        final validResp = await authRepository.validToken(
            accessToken: accessToken, refreshToken: refreshToken);

        if (validResp != null) {
          final tokenResult = validResp.tokenModel;
          if (tokenResult != null) {
            storage.write(
                key: ACCESS_TOKEN_KEY, value: tokenResult.accessToken);
            storage.write(
                key: ACCESS_TOKEN_KEY, value: tokenResult.refreshToken);
          }

          final apiResult = validResp.apiResult;
          final apiDataMap =
              Map<String, dynamic>.from(apiResult.resultData as Map);
          final userData = UserModel.fromJson(apiDataMap);
          state = userData;
        } else {
          state = UserModelError(message: '토큰 재발급 오류 ');
        }
      } else {
        print('[userMeProvider] >> RefreshToken 만료 >> 로그인 창으로 ');
        // 재로그인
        logout();
      }
    } else {
      // Todo AlertDialog와 함께 로그인 페이지로 이동
      // 비정상 응답 >> 로그아웃
      print('[userMeProvider] >> resp >> ${resp.result}');
      print('[userMeProvider] >> resp >> ${resp.resultCode}');
      print('[userMeProvider] >> resp >> ${resp.status}');
      logout();
    }
  }

  Future<UserModelBase> login({
    required String userId,
    required String userPw,
  }) async {
    try {
      print('[userProvider] >> login 수행 ');
      state = UserModelLoading();

      final resp = await authRepository.login(userId: userId, userPw: userPw);

      if (resp != null && resp.tokenModel != null) {
        final accessToken = resp.tokenModel!.accessToken;
        final refreshToken = resp.tokenModel!.refreshToken;

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
      }

      print('[userProvider] >> getMe 수행 ');
      final meResp = await userRepository.getMe();
      print('[userProvider] >> getMe 결과 : ${meResp.toString()}');

      final userData = Map<String, dynamic>.from(meResp.resultData as Map);
      final user = UserModel.fromJson(userData);

      state = user;
      return user;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다');
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    print('[userMeProvider] >> 로그아웃 ');
    state = null;

    // 한 번에 여러 개 await
    await Future.wait(
      [
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ],
    );
  }

  Future<ApiResult> join({
    required UserModel user,
  }) async {
    final requestModel = user.userModelToJson(user);

    return await userRepository.join(user: requestModel);
  }

  Future<ApiResult?> setProfileImage(XFile file) async {
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file.path,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    ApiResult? apiResult;

    try {
      apiResult = await userRepository.setProfileImage(image: formData);
      print('[userProvider] >> setProfileImage 결과 성공 : ${apiResult.resultMsg}');
    } catch (e) {
      print('[userProvider] >> setProfileImage 결과 실팽 : ${e}');
    }

    return apiResult;
  }
}
