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
