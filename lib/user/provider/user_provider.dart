import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    // Todo : 토큰 만료 오류일 경우 에러 해결 하기
    // logout();
    getMe();
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
    } else {
      // 응답이 정상이 아닐 때
      print('[userMeProvider] >> resp >> ${resp.resultCode}');
      print('[userMeProvider] >> resp >> ${resp.status}');

      // 임시적으로 로그아웃 로직.
      // Todo : Refresh Token으로 accessToken 재발급 하여 getMe 수행하는 로직추가
      // logout();
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

  Future<ApiResult> setProfileImage(XFile file) async {
    var formData = FormData.fromMap({
      'image': file,
    });
    ApiResult apiResult = await userRepository.setProfileImage(image: formData);

    print('[userProvider] >> setProfileImage 결과 : ${apiResult.resultMsg}');
    return apiResult;
  }
}
