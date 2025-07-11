import 'package:freezed_annotation/freezed_annotation.dart';
part 'account_state_model.freezed.dart';
part 'account_state_model.g.dart';

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
