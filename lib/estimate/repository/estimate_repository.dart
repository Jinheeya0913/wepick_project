import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wepick/common/dio/dio.dart';

import '../../common/const/data.dart';
import '../../common/model/api_result_model.dart';

part 'estimate_repository.g.dart';

final estimateRepositoryProvider = Provider<EstimateRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return EstimateRepository(dio, baseUrl: "http://$ip/estimate");
});

@RestApi()
abstract class EstimateRepository {
  factory EstimateRepository(Dio dio, {String baseUrl}) = _EstimateRepository;

  // 파트너 만난일 수정
  @POST("/writeHall")
  @Headers({
    'authorization': 'true',
    'content-type': 'application/json',
  })
  Future<ApiResult> writeHallEstimate(
      @Body() Map<String, dynamic> hallEstimateInfo);
}
