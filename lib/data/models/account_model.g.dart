// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      balance: json['balance'] as String,
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'balance': instance.balance,
      'currency': instance.currency,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_AccountBrief _$AccountBriefFromJson(Map<String, dynamic> json) =>
    _AccountBrief(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      balance: json['balance'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$AccountBriefToJson(_AccountBrief instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'balance': instance.balance,
      'currency': instance.currency,
    };

_AccountCreateRequest _$AccountCreateRequestFromJson(
  Map<String, dynamic> json,
) => _AccountCreateRequest(
  name: json['name'] as String,
  balance: json['balance'] as String,
  currency: json['currency'] as String,
);

Map<String, dynamic> _$AccountCreateRequestToJson(
  _AccountCreateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'balance': instance.balance,
  'currency': instance.currency,
};

_AccountHistoryResponse _$AccountHistoryResponseFromJson(
  Map<String, dynamic> json,
) => _AccountHistoryResponse(
  accountId: (json['accountId'] as num).toInt(),
  accountName: json['accountName'] as String,
  currency: json['currency'] as String,
  currentBalance: json['currentBalance'] as String,
  history:
      (json['history'] as List<dynamic>)
          .map((e) => AccountHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AccountHistoryResponseToJson(
  _AccountHistoryResponse instance,
) => <String, dynamic>{
  'accountId': instance.accountId,
  'accountName': instance.accountName,
  'currency': instance.currency,
  'currentBalance': instance.currentBalance,
  'history': instance.history,
};

_AccountHistoryModel _$AccountHistoryModelFromJson(Map<String, dynamic> json) =>
    _AccountHistoryModel(
      id: (json['id'] as num).toInt(),
      accountId: (json['accountId'] as num).toInt(),
      changeType: $enumDecode(_$ChangeTypeEnumMap, json['changeType']),
      previousState: AccountStateModel.fromJson(
        json['previousState'] as Map<String, dynamic>,
      ),
      newState: AccountStateModel.fromJson(
        json['newState'] as Map<String, dynamic>,
      ),
      changeTimestamp: DateTime.parse(json['changeTimestamp'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AccountHistoryModelToJson(
  _AccountHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'accountId': instance.accountId,
  'changeType': _$ChangeTypeEnumMap[instance.changeType]!,
  'previousState': instance.previousState,
  'newState': instance.newState,
  'changeTimestamp': instance.changeTimestamp.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$ChangeTypeEnumMap = {
  ChangeType.modification: 'MODIFICATION',
  ChangeType.creation: 'CREATION',
};

_AccountResponse _$AccountResponseFromJson(Map<String, dynamic> json) =>
    _AccountResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      balance: json['balance'] as String,
      currency: json['currency'] as String,
      incomeStats:
          (json['incomeStats'] as List<dynamic>)
              .map((e) => StatItemModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      expenseStats:
          (json['expenseStats'] as List<dynamic>)
              .map((e) => StatItemModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AccountResponseToJson(_AccountResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'balance': instance.balance,
      'currency': instance.currency,
      'incomeStats': instance.incomeStats,
      'expenseStats': instance.expenseStats,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_AccountStateModel _$AccountStateModelFromJson(Map<String, dynamic> json) =>
    _AccountStateModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      balance: json['balance'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$AccountStateModelToJson(_AccountStateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'balance': instance.balance,
      'currency': instance.currency,
    };

_AccountUpdateRequest _$AccountUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _AccountUpdateRequest(
  name: json['name'] as String,
  balance: json['balance'] as String,
  currency: json['currency'] as String,
);

Map<String, dynamic> _$AccountUpdateRequestToJson(
  _AccountUpdateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'balance': instance.balance,
  'currency': instance.currency,
};
