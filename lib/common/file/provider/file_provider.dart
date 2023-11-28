import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wepick/common/file/model/common_file_model.dart';
import 'package:wepick/common/file/repository/file_repository.dart';
import 'package:wepick/common/provider/secure_storage.dart';

import '../../model/api_result_model.dart';

final fileProvider =
    StateNotifierProvider<FileStateNotifier, FileModelBase?>((ref) {
  final fileRepository = ref.watch(fileRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return FileStateNotifier(fileRepository: fileRepository, storage: storage);
});

/**
 * 파일 관련한 동작을 수행할 때
 */

class FileStateNotifier extends StateNotifier<FileModelBase?> {
  final FlutterSecureStorage storage;
  final FileRepository fileRepository;

  FileStateNotifier({
    required this.storage,
    required this.fileRepository,
  }) : super(null);

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
      apiResult = await fileRepository.setProfileImage(image: formData);
      print('[userProvider] >> setProfileImage 결과 성공 : ${apiResult.resultMsg}');
    } catch (e) {
      print('[userProvider] >> setProfileImage 결과 실팽 : ${e}');
    }

    return apiResult;
  }
}
