import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  final int id;
  final String image;
  final String name;
  final String price;
  final String url;
  final String start;
  final String end;
  final String note;

  ServiceModel({
    this.id = 0,
    this.image = '',
    this.name = '',
    this.price = '',
    this.url = '',
    this.start = '',
    this.end = '',
    this.note = '',
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
