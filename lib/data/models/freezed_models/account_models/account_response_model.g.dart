// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountResponseModel _$AccountResponseModelFromJson(
  Map<String, dynamic> json,
) => _AccountResponseModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  balance: const DecimalConverter().fromJson(json['balance']),
  currency: $enumDecode(_$CurrencyEnumEnumMap, json['currency']),
  incomeStats: (json['incomeStats'] as List<dynamic>)
      .map((e) => StatItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  expenseStats: (json['expenseStats'] as List<dynamic>)
      .map((e) => StatItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: const DateTimeConverter().fromJson(json['createdAt'] as String),
  updatedAt: const DateTimeConverter().fromJson(json['updatedAt'] as String),
);

Map<String, dynamic> _$AccountResponseModelToJson(
  _AccountResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'balance': const DecimalConverter().toJson(instance.balance),
  'currency': _$CurrencyEnumEnumMap[instance.currency]!,
  'incomeStats': instance.incomeStats,
  'expenseStats': instance.expenseStats,
  'createdAt': const DateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
};

const _$CurrencyEnumEnumMap = {
  CurrencyEnum.RUB: 'RUB',
  CurrencyEnum.USD: 'USD',
  CurrencyEnum.EUR: 'EUR',
};
