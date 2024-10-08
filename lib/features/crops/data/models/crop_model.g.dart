// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CropModelImpl _$$CropModelImplFromJson(Map<String, dynamic> json) =>
    _$CropModelImpl(
      harvestDate:
          _timestampToDateTime(json['expected_harvest_date'] as Timestamp),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      quantityUnit: json['quantity_unit'] as String? ?? 'units',
      sowedOn: _timestampToDateTime(json['sowed_on'] as Timestamp),
    );

Map<String, dynamic> _$$CropModelImplToJson(_$CropModelImpl instance) =>
    <String, dynamic>{
      'expected_harvest_date': _dateTimeToTimestamp(instance.harvestDate),
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'quantity_unit': instance.quantityUnit,
      'sowed_on': _dateTimeToTimestamp(instance.sowedOn),
    };
