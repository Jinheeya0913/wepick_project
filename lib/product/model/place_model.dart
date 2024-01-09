import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  final int? placeCd;
  final String? placeNm;
  final String? placeAddress;
  final String? placePhone;

  const PlaceModel({
    this.placeCd,
    this.placeNm,
    this.placeAddress,
    this.placePhone,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
