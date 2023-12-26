import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wepick/common/dio/dio.dart';

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

  @POST("/sendPartnerRequest")
  @Headers({'authorization': 'true'})
  Future<ApiResult> sendPartnerRequest({
    @Body() required Map<String, dynamic> reqInfo,
  });

  // 파트너 요청 목록 조회
  @POST("/selectMyPartnerRequestQue")
  @Headers({'authorization': 'true'})
  Future<ApiResult> selectPartnerRequestList();

  // 파트너 요청 거절
  @POST("/refusePartnerRequest")
  @Headers({'authorization': 'true'})
  Future<ApiResult> refusePartnerRequest(
      {@Body() required Map<String, dynamic> ptRequestQue});

  // 파트너 요청 수락
  @POST("/acceptPartnerRequest")
  @Headers({'authorization': 'true'})
  Future<ApiResult> acceptPartnerRequest(
      {@Body() required Map<String, dynamic> ptRequestQue});

  // 파트너 만난일 수정
  @POST("/setPartnerMeetDate")
  @Headers({
    'authorization': 'true',
    'content-type': 'application/json',
  })
  Future<ApiResult> setMeetDt({
    @Body() required String? meetDt,
  });

  // 파트너 만난일 수정
  @POST("/setPartnerAlias")
  @Headers({
    'authorization': 'true',
    'content-type': 'application/json',
  })
  Future<ApiResult> setPartnerAlias(@Body() String partnerAlias);
}
