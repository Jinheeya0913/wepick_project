import 'package:json_annotation/json_annotation.dart';

part 'api_result_model.g.dart';

@JsonSerializable()
class ApiResult {
  final String result;
  final String resultCode;
  final String resultMsg;
  final Object? resultData;

  ApiResult({
    required this.result,
    required this.resultCode,
    required this.resultMsg,
    this.resultData,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) =>
      _$ApiResultFromJson(json);

  factory ApiResult.fromData(Map<String, dynamic> json) {
    return ApiResult(
      result: json['result'],
      resultCode: json['resultCode'],
      resultMsg: json['resultMsg'],
      resultData: json['resultData'],
    );
  }
}
