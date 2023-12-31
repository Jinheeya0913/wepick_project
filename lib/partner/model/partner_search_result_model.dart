// ignore_for_file: slash_for_doc_comments

import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/partner/model/partner_req_que_model.dart';
import 'package:wepick/user/model/user_model.dart';

part 'partner_search_result_model.g.dart';

/**
 * 파트너 요청 목록 및 요청인 정보 담는 용도
 */

abstract class PartnerSearchInfoBase {}

// 파트너 검색 결과 모델
@JsonSerializable()
class PartnerSearchInfoModel extends PartnerSearchInfoBase {
  final UserModel? partnerInfo;
  final PartnerReqQueModel? reqQueInfo;

  PartnerSearchInfoModel({
    this.partnerInfo,
    this.reqQueInfo,
  });

  factory PartnerSearchInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerSearchInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerSearchInfoModelToJson(this);

  static List<PartnerSearchInfoModel> convertObjectListToModelList(
      List<dynamic> objectList) {
    print('[convertObjectListToModelList] objList => modelList 시작');

    return objectList
        .map((object) =>
            PartnerSearchInfoModel.fromJson(object as Map<String, dynamic>))
        .toList();
  }
}

class PartnerSearchResultError extends PartnerSearchInfoBase {
  final String message;

  PartnerSearchResultError({
    required this.message,
  });
}
