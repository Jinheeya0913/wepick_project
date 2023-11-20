// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginResponse _$AuthLoginResponseFromJson(Map<String, dynamic> json) =>
    AuthLoginResponse(
      tokenModel:
          TokenModel.fromJson(json['tokenModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthLoginResponseToJson(AuthLoginResponse instance) =>
    <String, dynamic>{
      'tokenModel': instance.tokenModel,
    };
