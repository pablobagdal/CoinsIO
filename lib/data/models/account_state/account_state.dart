import 'package:freezed_annotation/freezed_annotation.dart';
part 'account_state.freezed.dart';
part 'account_state.g.dart';

@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState({
    /// example: 1
    required final int id,

    /// example: Основной счет
    required final String name,

    /// example: 1000.00
    required final String balance,

    /// example: USD
    required final String currency,
  }) = _AccountState;

  factory AccountState.fromJson(final Map<String, dynamic> json) =>
      _$AccountStateFromJson(json);
}
