// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerSearchResultModel _$PartnerSearchResultModelFromJson(
        Map<String, dynamic> json) =>
    PartnerSearchResultModel(
      partnerInfo: json['partnerInfo'] == null
          ? null
          : UserModel.fromJson(json['partnerInfo'] as Map<String, dynamic>),
      reqQueInfo: json['reqQueInfo'] == null
          ? null
          : PartnerReqQueModel.fromJson(
              json['reqQueInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartnerSearchResultModelToJson(
        PartnerSearchResultModel instance) =>
    <String, dynamic>{
      'partnerInfo': instance.partnerInfo,
      'reqQueInfo': instance.reqQueInfo,
    };
