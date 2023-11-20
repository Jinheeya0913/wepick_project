import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

// 에러
class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

// 정보 조회 중
class UserModelLoading extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase {
  final String userId;
  final String userNm;
  String? userPw;
  final String userAddress;
  final String userPhoneNum;
  final String userEmail;

  UserModel({
    required this.userId,
    required this.userNm,
    required this.userAddress,
    required this.userPhoneNum,
    required this.userEmail,
    this.userPw,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
