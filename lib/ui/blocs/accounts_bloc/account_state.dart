import 'package:coinio_app/domain/models/account/account.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {
  AccountInitial();
}

class AccountLoading extends AccountState {
  AccountLoading();
}

class AccountLoaded extends AccountState {
  final Account account;
  AccountLoaded({required this.account});
}

class AccountError extends AccountState {
  final Account? account;
  final String message;
  AccountError({required this.message, this.account});
}
