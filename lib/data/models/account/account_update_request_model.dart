import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_update_request_model.freezed.dart';
part 'account_update_request_model.g.dart';

@freezed
abstract class AccountUpdateRequestModel with _$AccountUpdateRequestModel {
  const factory AccountUpdateRequestModel({
    /// example: Основной счёт
    required final String name,

    /// example: 100.00
    required final String balance,

    /// example: RUB
    required final String currency,
  }) = _AccountUpdateRequestModel;

  factory AccountUpdateRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$AccountUpdateRequestModelFromJson(json);
}
