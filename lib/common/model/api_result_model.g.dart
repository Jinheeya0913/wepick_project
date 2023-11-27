// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult _$ApiResultFromJson(Map<String, dynamic> json) => ApiResult(
      result: json['result'] as String,
      status: json['status'] as String?,
      resultCode: json['resultCode'] as String?,
      resultMsg: json['resultMsg'] as String,
      divisionCode: json['divisionCode'] as String?,
      resultData: json['resultData'],
    );

Map<String, dynamic> _$ApiResultToJson(ApiResult instance) => <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
      'resultMsg': instance.resultMsg,
      'resultCode': instance.resultCode,
      'divisionCode': instance.divisionCode,
      'resultData': instance.resultData,
    };
