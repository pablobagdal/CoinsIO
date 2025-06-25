import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_update_request.freezed.dart';
part 'account_update_request.g.dart';

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
