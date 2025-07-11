import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_create_request_model.freezed.dart';
part 'account_create_request_model.g.dart';

@freezed
abstract class AccountCreateRequestModel with _$AccountCreateRequestModel {
  const factory AccountCreateRequestModel({
    /// example: Основной счёт
    required final String name,

    /// example: 1000.00
    required final String balance,

    /// example: RUB
    required final String currency,
  }) = _AccountCreateRequestModel;

  factory AccountCreateRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$AccountCreateRequestModelFromJson(json);
}
