// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult _$ApiResultFromJson(Map<String, dynamic> json) => ApiResult(
      result: json['result'] as String,
      resultCode: json['resultCode'] as String,
      resultMsg: json['resultMsg'] as String,
      resultData: json['resultData'],
    );

Map<String, dynamic> _$ApiResultToJson(ApiResult instance) => <String, dynamic>{
      'result': instance.result,
      'resultCode': instance.resultCode,
      'resultMsg': instance.resultMsg,
      'resultData': instance.resultData,
    };
