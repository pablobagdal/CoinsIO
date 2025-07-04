import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account with _$Account {
  const factory Account({
    required final int id,
    required final int userId,

    required final String name,
    required final String balance,
    required final String currency,

    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _Account;

  factory Account.fromJson(final Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
