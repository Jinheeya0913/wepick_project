import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wepick/common/dio/dio.dart';

import '../../const/data.dart';
import '../../model/api_result_model.dart';

part 'file_repository.g.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FileRepository(dio, baseUrl: 'http://$ip/file');
});

@RestApi()
abstract class FileRepository {
  factory FileRepository(
    Dio dio, {
    String baseUrl,
  }) = _FileRepository;

  @POST('/me/setProfileImg')
  @Headers({
    'authorization': 'true',
    'Content-Type': 'multipart/form-data',
  })
  Future<ApiResult> setProfileImage({
    @Body() required FormData image,
  });
}
