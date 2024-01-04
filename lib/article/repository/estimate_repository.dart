import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wepick/common/dio/dio.dart';

import '../../common/const/data.dart';

part 'estimate_repository.g.dart';

final estimateRepositoryProvider = Provider<EstimateRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return EstimateRepository(dio, baseUrl: "http://$ip/estimate");
});

@RestApi()
abstract class EstimateRepository {
  factory EstimateRepository(Dio dio, {String baseUrl}) = _EstimateRepository;
}
