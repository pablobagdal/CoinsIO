import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

// extension TransactionTypeExtension on bool {
//   String get isIncomeName {
//     switch (this) {
//       case true:
//         return 'Доход';
//       case false:
//         return 'Расход';
//     }
//   }
// }

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    /// example: 1
    required int id,

    /// example: 1
    required int accountId,

    /// example: 1
    required int categoryId,

    /// example: 500.00
    required String amount,

    /// example: 2023-10-01T12:00:00Z
    required DateTime transactionDate,

    /// example: Зарплата за месяц
    String? comment,

    /// example: 2023-10-01T12:00:00Z
    required DateTime createdAt,

    /// example: 2023-10-01T12:00:00Z
    required DateTime updatedAt,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
