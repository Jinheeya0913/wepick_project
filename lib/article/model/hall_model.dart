import 'package:json_annotation/json_annotation.dart';

part 'hall_model.g.dart';

@JsonSerializable()
class HallModel {
  // 장소 코드
  final int placeCd;
  // 홀 코드
  final int? hallCd;
  // 홍 이름
  final String hallNm;

  const HallModel({
    required this.hallCd,
    required this.placeCd,
    required this.hallNm,
  });

  factory HallModel.fromJson(Map<String, dynamic> json) =>
      _$HallModelFromJson(json);
}
