import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/partner/model/partner_req_que_model.dart';
import 'package:wepick/partner/model/partner_search_result_model.dart';

part 'partner_model.g.dart';

abstract class PartnerInfoModelBase {}

class PartnerInfoModelError extends PartnerInfoModelBase {
  final String message;

  PartnerInfoModelError({
    required this.message,
  });
}

class PartnerInfoEmptyModel extends PartnerInfoModelBase {
  // 만약 파트너 정보가 없다면, 파트너 요청 목록 정보를 갖고 있음
  final List<PartnerSearchInfoModel>? requestInfoList;

  PartnerInfoEmptyModel({
    this.requestInfoList,
  });
}

@JsonSerializable()
class PartnerInfoModel extends PartnerInfoModelBase {
  final String partnerCd;
  final String partnerId;
  final String partnerNm;
  final String useAt;
  final DateTime regDt;

  PartnerInfoModel({
    required this.partnerId,
    required this.partnerNm,
    required this.partnerCd,
    required this.useAt,
    required this.regDt,
  });

  factory PartnerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerInfoModelFromJson(json);

  Map<String, dynamic> toJson(PartnerInfoModel model) =>
      _$PartnerInfoModelToJson(model);
}
