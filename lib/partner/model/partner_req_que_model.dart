import 'package:json_annotation/json_annotation.dart';

part 'partner_req_que_model.g.dart';

// 파트너 요청 목록 모델
@JsonSerializable()
class PartnerReqQueModel {
  final String ptRequesterId;
  final String ptAcceptorId;
  final DateTime? regDt;
  final DateTime? updateDt;
  final String ptReqStatus;

  PartnerReqQueModel({
    required this.ptRequesterId,
    required this.ptAcceptorId,
    required this.ptReqStatus,
    this.regDt,
    this.updateDt,
  });

  factory PartnerReqQueModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerReqQueModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerReqQueModelToJson(this);
}
