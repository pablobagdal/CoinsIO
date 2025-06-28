import 'package:coinio_app/domain/models/account/account.dart';

abstract class AccountEvent {}

class ChangeAccount extends AccountEvent {}

class UpdateAccountCurrency extends AccountEvent {
  final Account account;
  final String newCurrency;

  UpdateAccountCurrency({required this.account, required this.newCurrency});
}

class UpdateAccountName extends AccountEvent {
  final String newName;

  UpdateAccountName({required this.newName});
}
