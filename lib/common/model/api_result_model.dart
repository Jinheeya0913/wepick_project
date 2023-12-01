import 'package:json_annotation/json_annotation.dart';

part 'api_result_model.g.dart';

@JsonSerializable()
class ApiResult {
  final String? status;
  final String result;
  final String resultMsg;
  final String? resultCode;

  final String? divisionCode;
  final Object? resultData;

  ApiResult({
    required this.result,
    this.status,
    this.resultCode,
    required this.resultMsg,
    this.divisionCode,
    this.resultData,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) =>
      _$ApiResultFromJson(json);

  factory ApiResult.fromData(Map<String, dynamic> json) {
    return ApiResult(
      result: json['result'],
      status: json['resultCode'],
      resultMsg: json['resultMsg'],
      resultData: json['resultData'],
    );
  }

  bool isSuccess() {
    if (resultCode == '101') {
      return true;
    } else {
      return false;
    }
  }
}
