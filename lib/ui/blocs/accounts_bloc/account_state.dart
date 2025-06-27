import 'package:coinio_app/domain/models/account/account.dart';

abstract class AccountState {
  final Account account;

  AccountState({required this.account});
}

class AccountLoading extends AccountState {
  AccountLoading({required super.account});
}

class AccountLoaded extends AccountState {
  AccountLoaded({required super.account});
}

class AccountError extends AccountState {
  AccountError({required super.account});
}
