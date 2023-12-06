import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wepick/common/dio/dio.dart';
import 'package:wepick/user/model/partner_search_model.dart';

import '../../common/const/data.dart';
import '../../common/model/api_result_model.dart';

part 'partner_repository.g.dart';

final partnerRepositoryProvider = Provider<PartnerRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PartnerRepository(dio, baseUrl: "http://$ip/partner");
});

@RestApi()
abstract class PartnerRepository {
  factory PartnerRepository(Dio dio, {String baseUrl}) = _PartnerRepository;

  @POST("/getMyPartner")
  @Headers({'authorization': 'true'})
  Future<ApiResult> getPartner();

  @POST("/getMyPartnerRegCode")
  @Headers({'authorization': 'true'})
  Future<ApiResult> getMyPartnerCode();

  @POST("/searchPartnerWithCode")
  @Headers({'authorization': 'true'})
  Future<ApiResult> searchPartnerCode({
    @Body() required Map<String, dynamic> partner,
  });
}
