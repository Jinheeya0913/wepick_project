import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wepick/common/dio/dio.dart';

import '../../common/const/data.dart';
import '../model/user_model.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: 'http://$ip/user');
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(
    Dio dio, {
    String baseUrl,
  }) = _UserRepository;

  @POST('/login')
  Future<void> login();

  @POST('/me')
  @Headers({'authorization': 'true'})
  Future<UserModel> getMe();

  @POST('/join')
  Future<void> join();
}
