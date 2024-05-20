// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      image: json['image'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: json['price'] as String? ?? '',
      url: json['url'] as String? ?? '',
      start: json['start'] as String? ?? '',
      end: json['end'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'url': instance.url,
      'start': instance.start,
      'end': instance.end,
      'note': instance.note,
    };
