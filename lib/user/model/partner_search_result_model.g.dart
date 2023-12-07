// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerSearchInfoModel _$PartnerSearchInfoModelFromJson(
        Map<String, dynamic> json) =>
    PartnerSearchInfoModel(
      partnerInfo: json['partnerInfo'] == null
          ? null
          : UserModel.fromJson(json['partnerInfo'] as Map<String, dynamic>),
      reqQueInfo: json['reqQueInfo'] == null
          ? null
          : PartnerReqQueModel.fromJson(
              json['reqQueInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartnerSearchInfoModelToJson(
        PartnerSearchInfoModel instance) =>
    <String, dynamic>{
      'partnerInfo': instance.partnerInfo,
      'reqQueInfo': instance.reqQueInfo,
    };
