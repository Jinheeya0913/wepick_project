import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/product/model/place_model.dart';

part 'hall_model.g.dart';

@JsonSerializable()
class HallModel {
  // 장소 코드
  final PlaceModel? placeInfo;
  // 홀 코드
  final int? hallCd;
  // 홍 이름
  final String hallNm;

  const HallModel({
    this.placeInfo,
    required this.hallCd,
    required this.hallNm,
  });

  factory HallModel.fromJson(Map<String, dynamic> json) =>
      _$HallModelFromJson(json);
}
