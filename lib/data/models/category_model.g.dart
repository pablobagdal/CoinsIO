// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      isIncome: json['isIncome'] as bool,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'emoji': instance.emoji,
      'isIncome': instance.isIncome,
    };

_StatItemModel _$StatItemModelFromJson(Map<String, dynamic> json) =>
    _StatItemModel(
      categoryId: (json['categoryId'] as num).toInt(),
      categoryName: json['categoryName'] as String,
      emoji: json['emoji'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$StatItemModelToJson(_StatItemModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'emoji': instance.emoji,
      'amount': instance.amount,
    };
