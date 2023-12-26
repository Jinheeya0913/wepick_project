// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerInfoModel _$PartnerInfoModelFromJson(Map<String, dynamic> json) =>
    PartnerInfoModel(
      partnerId: json['partnerId'] as String,
      partnerNm: json['partnerNm'] as String,
      partnerImgUrl: json['partnerImgUrl'] as String?,
      partnerAlias: json['partnerAlias'] as String?,
      partnerConnCd: json['partnerConnCd'] as String,
      partnerConnYn: json['partnerConnYn'] as bool,
      regDt: DateTimeUtil.dateTimeFromJson(json['regDt'] as String?),
      meetDt: DateTimeUtil.dateTimeFromJson(json['meetDt'] as String?),
    );

Map<String, dynamic> _$PartnerInfoModelToJson(PartnerInfoModel instance) =>
    <String, dynamic>{
      'partnerConnCd': instance.partnerConnCd,
      'partnerId': instance.partnerId,
      'partnerNm': instance.partnerNm,
      'partnerImgUrl': instance.partnerImgUrl,
      'partnerAlias': instance.partnerAlias,
      'partnerConnYn': instance.partnerConnYn,
      'regDt': DateTimeUtil.dateTimeToJson(instance.regDt),
      'meetDt': DateTimeUtil.dateTimeToJson(instance.meetDt),
    };
