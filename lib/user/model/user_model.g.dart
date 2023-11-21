// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String,
      userNm: json['userNm'] as String,
      userAddress: json['userAddress'] as String,
      userPhoneNum: json['userPhoneNum'] as String,
      userEmail: json['userEmail'] as String,
      userImgUrl: json['userImgUrl'] as String?,
      userPw: json['userPw'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'userNm': instance.userNm,
      'userPw': instance.userPw,
      'userAddress': instance.userAddress,
      'userPhoneNum': instance.userPhoneNum,
      'userEmail': instance.userEmail,
      'userImgUrl': instance.userImgUrl,
    };
