// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginResponse _$AuthLoginResponseFromJson(Map<String, dynamic> json) =>
    AuthLoginResponse(
      apiResult: ApiResult.fromJson(json['apiResult'] as Map<String, dynamic>),
      tokenModel: json['tokenModel'] == null
          ? null
          : TokenModel.fromJson(json['tokenModel'] as Map<String, dynamic>),
      userModel: json['userModel'] == null
          ? null
          : UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthLoginResponseToJson(AuthLoginResponse instance) =>
    <String, dynamic>{
      'apiResult': instance.apiResult,
      'tokenModel': instance.tokenModel,
      'userModel': instance.userModel,
    };
