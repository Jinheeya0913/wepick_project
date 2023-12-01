import 'package:json_annotation/json_annotation.dart';

part 'partner_model.g.dart';

abstract class PartnerModelBase {}

class PartnerInfoModelError extends PartnerModelBase {
  final String message;

  PartnerInfoModelError({
    required this.message,
  });
}

class PartnerInfoEmptyModel extends PartnerModelBase {}

@JsonSerializable()
class PartnerInfoModel extends PartnerModelBase {
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