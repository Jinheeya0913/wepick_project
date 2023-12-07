import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/user/model/partner_req_que_model.dart';
import 'package:wepick/user/model/user_model.dart';

part 'partner_search_result_model.g.dart';

abstract class PartnerSearchInfoBase {}

class PartnerSearchResultError extends PartnerSearchInfoBase {
  final String message;

  PartnerSearchResultError({
    required this.message,
  });
}

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
}
