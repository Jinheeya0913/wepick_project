// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginRequestModel _$AuthLoginRequestModelFromJson(
        Map<String, dynamic> json) =>
    AuthLoginRequestModel(
      userId: json['userId'] as String,
      userPw: json['userPw'] as String,
    );

Map<String, dynamic> _$AuthLoginRequestModelToJson(
        AuthLoginRequestModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userPw': instance.userPw,
    };
