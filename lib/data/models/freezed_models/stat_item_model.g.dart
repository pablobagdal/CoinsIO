// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatItemModel _$StatItemModelFromJson(Map<String, dynamic> json) =>
    _StatItemModel(
      categoryId: (json['categoryId'] as num).toInt(),
      categoryName: json['categoryName'] as String,
      emoji: json['emoji'] as String,
      amount: const DecimalConverter().fromJson(json['amount']),
    );

Map<String, dynamic> _$StatItemModelToJson(_StatItemModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'emoji': instance.emoji,
      'amount': const DecimalConverter().toJson(instance.amount),
    };
