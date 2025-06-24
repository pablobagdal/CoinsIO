import 'package:freezed_annotation/freezed_annotation.dart';
part 'account_state.freezed.dart';
part 'account_state.g.dart';

@freezed
abstract class AccountState with _$AccountState {
  const factory AccountState({
    /// example: 1
    required int id,

    /// example: Основной счет
    required String name,

    /// example: 1000.00
    required String balance,

    /// example: USD
    required String currency,
  }) = _AccountState;

  factory AccountState.fromJson(Map<String, dynamic> json) =>
      _$AccountStateFromJson(json);
}
