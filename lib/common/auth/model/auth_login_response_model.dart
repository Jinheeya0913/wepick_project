import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/common/auth/model/token_model.dart';

part 'auth_login_response_model.g.dart';

@JsonSerializable()
class AuthLoginResponse {
  final TokenModel tokenModel;

  AuthLoginResponse({
    required this.tokenModel,
  });

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseFromJson(json);
}
