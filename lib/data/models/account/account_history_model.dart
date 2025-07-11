import 'package:coinio_app/data/models/account/account_state_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_history_model.g.dart';
part 'account_history_model.freezed.dart';

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
