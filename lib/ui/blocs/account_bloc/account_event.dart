import 'package:coinio_app/data/models/account/account.dart';

abstract class AccountEvent {}

class ChangeAccount extends AccountEvent {}

class UpdateAccount extends AccountEvent {
  final Account account;

  UpdateAccount({required this.account});
}

class LoadAccount extends AccountEvent {
  final int id;
  LoadAccount({required this.id});
}

class LoadAccounts extends AccountEvent {
  LoadAccounts();
}
