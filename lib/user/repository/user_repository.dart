import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wepick/common/dio/dio.dart';
import 'package:wepick/common/dio/file_dio.dart';
import 'package:wepick/common/model/api_result_model.dart';

import '../../common/const/data.dart';
import '../model/user_model.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: 'http://$ip/user');
});

// 파일 업로드를 위한 dio
final fileUserRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(fileProvider);
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

  // Todo 토큰 만룔됐을 때 오류 해결할 것
  @POST('/me')
  @Headers({'authorization': 'true'})
  Future<ApiResult> getMe();

  @POST('/join')
  @Headers({'content-type': 'application/json'})
  Future<ApiResult> join({
    @Body() required Map<String, dynamic> user,
  });

  @POST('/me/setProfileImg')
  @Headers({
    'authorization': 'true',
    'Content-Type': 'multipart/form-data',
  })
  Future<ApiResult> setProfileImage({
    @Body() required FormData image,
  });
}
