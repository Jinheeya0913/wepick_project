import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/user/model/partner_req_que_model.dart';
import 'package:wepick/user/model/user_model.dart';

part 'partner_search_result_model.g.dart';

abstract class PartnerSearchResultBase {}

class PartnerSearchError extends PartnerSearchResultBase {
  final String message;

  PartnerSearchError({
    required this.message,
  });
}

@JsonSerializable()
class PartnerSearchResultModel extends PartnerSearchResultBase {
  final UserModel? partnerInfo;
  final PartnerReqQueModel? reqQueInfo;

  PartnerSearchResultModel({
    this.partnerInfo,
    this.reqQueInfo,
  });

  factory PartnerSearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerSearchResultModelFromJson(json);

  Map<String, dynamic> toJson(PartnerSearchResultModel model) =>
      _$PartnerSearchResultModelToJson(model);
}
