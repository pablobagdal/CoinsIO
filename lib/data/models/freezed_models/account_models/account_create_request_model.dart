import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:coinio_app/core/enums/currency_enum.dart';
import 'package:coinio_app/core/utils/decimal_converter.dart';

part 'account_create_request_model.freezed.dart';
part 'account_create_request_model.g.dart';

@freezed
abstract class AccountCreateRequestModel with _$AccountCreateRequestModel {
  const factory AccountCreateRequestModel({
    required String name,
    @DecimalConverter() required Decimal balance,
    required CurrencyEnum currency,
  }) = _AccountCreateRequestModel;

  factory AccountCreateRequestModel.fromJson(Map<String, Object?> json) =>
      _$AccountCreateRequestModelFromJson(json);
}
