import 'package:json_annotation/json_annotation.dart';
import 'package:wepick/article/model/estimate_model_base.dart';
import 'package:wepick/article/model/hall_model.dart';

part 'hall_estimate_model.g.dart';

@JsonSerializable()
class HallEstimateModel extends HallModel implements EstimateModelBase {
  // 예약시간
  final String bookingTime;
  // 예약날짜
  final String bookingDate;
  // 대관료
  final int rentalFee;
  // 식비
  final int foodFee;
  // 보증인원
  final int guaranteedPrsnl;
  // 후기
  final String memo;

  const HallEstimateModel({
    required this.bookingTime,
    required this.bookingDate,
    required this.rentalFee,
    required this.foodFee,
    required this.guaranteedPrsnl,
    required this.memo,
    super.hallCd,
    required super.placeCd,
    required super.hallNm,
  });

  factory HallEstimateModel.fromJson(Map<String, dynamic> json) =>
      _$HallEstimateModelFromJson(json);
}
