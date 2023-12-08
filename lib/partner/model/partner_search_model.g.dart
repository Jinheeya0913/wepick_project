// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerSearchModel _$PartnerSearchModelFromJson(Map<String, dynamic> json) =>
    PartnerSearchModel(
      ptTempUserId: json['ptTempUserId'] as String?,
      ptTempRegCd: json['ptTempRegCd'] as String,
      ptTempStatus: json['ptTempStatus'] as bool?,
      updateDt: json['updateDt'] == null
          ? null
          : DateTime.parse(json['updateDt'] as String),
      createDt: json['createDt'] == null
          ? null
          : DateTime.parse(json['createDt'] as String),
    );

Map<String, dynamic> _$PartnerSearchModelToJson(PartnerSearchModel instance) =>
    <String, dynamic>{
      'ptTempUserId': instance.ptTempUserId,
      'ptTempRegCd': instance.ptTempRegCd,
      'ptTempStatus': instance.ptTempStatus,
      'updateDt': instance.updateDt?.toIso8601String(),
      'createDt': instance.createDt?.toIso8601String(),
    };
