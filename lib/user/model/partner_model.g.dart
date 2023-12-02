// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerInfoModel _$PartnerInfoModelFromJson(Map<String, dynamic> json) =>
    PartnerInfoModel(
      partnerId: json['partnerId'] as String,
      partnerNm: json['partnerNm'] as String,
      partnerCd: json['partnerCd'] as String,
      useAt: json['useAt'] as String,
      regDt: DateTime.parse(json['regDt'] as String),
    );

Map<String, dynamic> _$PartnerInfoModelToJson(PartnerInfoModel instance) =>
    <String, dynamic>{
      'partnerCd': instance.partnerCd,
      'partnerId': instance.partnerId,
      'partnerNm': instance.partnerNm,
      'useAt': instance.useAt,
      'regDt': instance.regDt.toIso8601String(),
    };
