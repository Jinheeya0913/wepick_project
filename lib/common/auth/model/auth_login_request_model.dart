import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/common/utils/Base64Util.dart';

part 'auth_login_request_model.g.dart';

@JsonSerializable()
class AuthLoginRequestModel {
  final String userId;
  final String userPw;

  AuthLoginRequestModel({
    required this.userId,
    required this.userPw,
  });

  factory AuthLoginRequestModel.createEncPwModel({
    required String userId,
    required String userPw,
  }) {
    String encodedPw = Base64Util.base64Encoder(userPw);

    return AuthLoginRequestModel(
      userId: userId,
      userPw: encodedPw,
    );
  }

  factory AuthLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginRequestModelFromJson(json);

  Map<String, dynamic> toJson(AuthLoginRequestModel model) =>
      _$AuthLoginRequestModelToJson(model);
}
