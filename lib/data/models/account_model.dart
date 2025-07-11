import 'package:coinio_app/data/models/category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required final int id,
    required final int userId,

    required final String name,
    required final String balance,
    required final String currency,

    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _AccountModel;

  factory AccountModel.fromJson(final Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}

@freezed
abstract class AccountBrief with _$AccountBriefModel {
  const factory AccountBrief({
    required final int id,
    required final String name,
    required final String balance,
    required final String currency,
  }) = _AccountBrief;

  factory AccountBrief.fromJson(final Map<String, dynamic> json) =>
      _$AccountBriefFromJson(json);
}

@freezed
abstract class AccountCreateRequest with _$AccountCreateRequest {
  const factory AccountCreateRequest({
    /// example: Основной счёт
    required final String name,

    /// example: 1000.00
    required final String balance,

    /// example: RUB
    required final String currency,
  }) = _AccountCreateRequest;

  factory AccountCreateRequest.fromJson(final Map<String, dynamic> json) =>
      _$AccountCreateRequestFromJson(json);
}

@freezed
abstract class AccountHistoryResponse with _$AccountHistoryResponse {
  const factory AccountHistoryResponse({
    /// example: 1
    required final int accountId,

    /// example: Основной счет
    required final String accountName,

    /// example: USD
    required final String currency,

    /// example: 2000.00
    required final String currentBalance,

    /// example: [AccountHistory{...}]
    required final List<AccountHistoryModel> history,
  }) = _AccountHistoryResponse;

  factory AccountHistoryResponse.fromJson(final Map<String, dynamic> json) =>
      _$AccountHistoryResponseFromJson(json);
}

enum ChangeType {
  @JsonValue('MODIFICATION')
  modification,
  @JsonValue('CREATION')
  creation,
}

@freezed
abstract class AccountHistoryModel with _$AccountHistoryModel {
  const factory AccountHistoryModel({
    /// example: 1
    required final int id,

    /// example: 1
    required final int accountId,

    /// example: MODIFICATION or CREATION
    required final ChangeType changeType,

    /// previous state of the account
    required final AccountStateModel previousState,

    /// new state of the account after the change
    required final AccountStateModel newState,

    /// timestamp of the change
    required final DateTime changeTimestamp,

    /// creation timestamp of the history record
    required final DateTime createdAt,
  }) = _AccountHistoryModel;

  factory AccountHistoryModel.fromJson(final Map<String, dynamic> json) =>
      _$AccountHistoryModelFromJson(json);
}

@freezed
abstract class AccountResponse with _$AccountResponse {
  const factory AccountResponse({
    /// example: 1
    required final int id,

    /// example: Основной счёт
    required final String name,

    /// example: 1000.00
    required final String balance,

    /// example: RUB
    required final String currency,

    /// example: [StatItem{
    ///  categoryId*	integer
    ///  example: 1
    ///  categoryName*	string
    ///  example: Зарплата
    ///  emoji*	string
    ///  example: 💰
    ///  amount*	string
    ///  example: 5000.00
    ///  }]
    required final List<StatItemModel> incomeStats,

    /// example: [StatItem{
    /// categoryId*	integer
    /// example: 1
    /// categoryName*	string
    /// example: Зарплата
    /// emoji*	string
    /// example: 💰
    /// amount*	string
    /// example: 5000.00
    /// }]
    required final List<StatItemModel> expenseStats,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _AccountResponse;

  factory AccountResponse.fromJson(final Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);
}

@freezed
abstract class AccountStateModel with _$AccountStateModel {
  const factory AccountStateModel({
    /// example: 1
    required final int id,

    /// example: Основной счет
    required final String name,

    /// example: 1000.00
    required final String balance,

    /// example: USD
    required final String currency,
  }) = _AccountStateModel;

  factory AccountStateModel.fromJson(final Map<String, dynamic> json) =>
      _$AccountStateModelFromJson(json);
}

@freezed
abstract class AccountUpdateRequest with _$AccountUpdateRequest {
  const factory AccountUpdateRequest({
    /// example: Основной счёт
    required final String name,

    /// example: 100.00
    required final String balance,

    /// example: RUB
    required final String currency,
  }) = _AccountUpdateRequest;

  factory AccountUpdateRequest.fromJson(final Map<String, dynamic> json) =>
      _$AccountUpdateRequestFromJson(json);
}
