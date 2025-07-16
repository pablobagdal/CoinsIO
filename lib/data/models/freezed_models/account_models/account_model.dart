import "package:decimal/decimal.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:coinio_app/core/enums/currency_enum.dart";
import "package:coinio_app/core/utils/date_time_converter.dart";
import "package:coinio_app/core/utils/decimal_converter.dart";

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required int id,
    required int userId,
    required String name,
    @DecimalConverter() required Decimal balance,
    required CurrencyEnum currency,
    @DateTimeConverter() required DateTime createdAt,
    @DateTimeConverter() required DateTime updatedAt,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, Object?> json) =>
      _$AccountModelFromJson(json);
}
