import 'package:json_annotation/json_annotation.dart';

part 'partner_req_que_model.g.dart';

@JsonSerializable()
class PartnerReqQueModel {
  final String ptRequesterId;
  final String ptAcceptorId;
  final DateTime regDt;
  final DateTime? updateDt;
  final String ptReqStatus;

  PartnerReqQueModel({
    required this.ptRequesterId,
    required this.ptAcceptorId,
    required this.regDt,
    required this.ptReqStatus,
    this.updateDt,
  });

  factory PartnerReqQueModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerReqQueModelFromJson(json);
}
