import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  const factory Account({
    /// example: 1
    required final int id,

    /// example: 1
    required final int userId,

    /// example: Основной счёт
    required final String name,

    /// example: 1000.00
    required final String balance,

    /// example: RUB
    required final String currency,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _Account;

  factory Account.fromJson(final Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
