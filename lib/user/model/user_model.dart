import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/Base64Util.dart';

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
  final String? userPw;
  final String userPhoneNum;
  final String userEmail;
  final String? userImgUrl;

  UserModel({
    required this.userId,
    required this.userNm,
    required this.userPhoneNum,
    required this.userEmail,
    this.userImgUrl,
    this.userPw,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> userModelToJson() => _$UserModelToJson(this);

  factory UserModel.createEncPwModel({
    required String userId,
    required String userNm,
    required String userPw,
    required String userPhoneNum,
    required String userEmail,
    String? userImgUrl,
  }) {
    String encodedPw = Base64Util.base64Encoder(userPw);

    return UserModel(
      userId: userId,
      userPw: encodedPw,
      userNm: userNm,
      userPhoneNum: userPhoneNum,
      userEmail: userEmail,
      userImgUrl: userImgUrl,
    );
  }
}
