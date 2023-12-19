import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/common/utils/boolUtil.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';
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
  final String partnerConnCd;
  final String partnerId;
  final String partnerNm;
  // @JsonKey(
  //   fromJson: BoolUtil.boolFromJson,
  //   toJson: BoolUtil.boolToJson,
  // )
  final bool partnerConnYn;

  @JsonKey(
    toJson: DateTimeUtil.dateTimeToJson,
    fromJson: DateTimeUtil.dateTimeFromJson,
  )
  final DateTime? regDt;

  @JsonKey(
    toJson: DateTimeUtil.dateTimeToJson,
    fromJson: DateTimeUtil.dateTimeFromJson,
  )
  final DateTime? meetDt;

  PartnerInfoModel({
    required this.partnerId,
    required this.partnerNm,
    required this.partnerConnCd,
    required this.partnerConnYn,
    required this.regDt,
    this.meetDt,
  });

  factory PartnerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerInfoModelFromJson(json);

  Map<String, dynamic> toJson(PartnerInfoModel model) =>
      _$PartnerInfoModelToJson(model);
}
