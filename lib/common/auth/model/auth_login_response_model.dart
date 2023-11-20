import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/common/auth/model/token_model.dart';
import 'package:wepick/common/model/api_result_model.dart';

import '../../../user/model/user_model.dart';

part 'auth_login_response_model.g.dart';

@JsonSerializable()
class AuthLoginResponse {
  final ApiResult apiResult;
  final TokenModel tokenModel;
  final UserModel? userModel;

  AuthLoginResponse({
    required this.apiResult,
    required this.tokenModel,
    this.userModel,
  });

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseFromJson(json);
}
