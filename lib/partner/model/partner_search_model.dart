import 'package:json_annotation/json_annotation.dart';

part 'partner_search_model.g.dart';

abstract class PartnerSearchModelBase {}

class PartnerSearchLoading extends PartnerSearchModelBase {}

class PartnerSearchError extends PartnerSearchModelBase {
  final String message;

  PartnerSearchError({
    required this.message,
  });
}

@JsonSerializable()
class PartnerSearchModel extends PartnerSearchModelBase {
  final String? ptTempUserId;
  final String ptTempRegCd;
  final bool? ptTempStatus;
  final DateTime? updateDt;
  final DateTime? createDt;

  PartnerSearchModel({
    this.ptTempUserId,
    required this.ptTempRegCd,
    this.ptTempStatus,
    this.updateDt,
    this.createDt,
  });

  factory PartnerSearchModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerSearchModelToJson(this);
}
