import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wepick/common/auth/repository/auth_repository.dart';
import 'package:wepick/common/secure_storage/secure_storage.dart';
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

    final resp = await userRepository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String userId,
    required String userPw,
  }) async {
    try {
      print('[userProvider] >> login 수행 ');
      state = UserModelLoading();

      final resp = await authRepository.login(userId: userId, userPw: userPw);

      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.tokenModel.accessToken);
      await storage.write(
          key: REFRESH_TOKEN_KEY, value: resp.tokenModel.refreshToken);

      final userResp = await userRepository.getMe();

      state = userResp;
      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다');
      return Future.value(state);
    }
  }
}
