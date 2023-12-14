// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_req_que_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerReqQueModel _$PartnerReqQueModelFromJson(Map<String, dynamic> json) =>
    PartnerReqQueModel(
      ptRequesterId: json['ptRequesterId'] as String,
      ptAcceptorId: json['ptAcceptorId'] as String,
      ptTempCd: json['ptTempCd'] as String,
      ptReqStatus: json['ptReqStatus'] as String,
      regDt: DateTimeUtil.dateTimeFromJson(json['regDt'] as String?),
      updateDt: DateTimeUtil.dateTimeFromJson(json['updateDt'] as String?),
    );

Map<String, dynamic> _$PartnerReqQueModelToJson(PartnerReqQueModel instance) =>
    <String, dynamic>{
      'ptRequesterId': instance.ptRequesterId,
      'ptAcceptorId': instance.ptAcceptorId,
      'ptTempCd': instance.ptTempCd,
      'regDt': DateTimeUtil.dateTimeToJson(instance.regDt),
      'updateDt': DateTimeUtil.dateTimeToJson(instance.updateDt),
      'ptReqStatus': instance.ptReqStatus,
    };
