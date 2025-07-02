import 'dart:async';

import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/models/account_update_request/account_update_request.dart';
import 'package:coinio_app/domain/usecases/account_usecases/account_usecases.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_event.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountUsecase getAccountUsecase;
  final GetAccountsUsecase getAccountsUsecase;
  final AddAccountUsecase addAccountUsecase;
  final GetAccountHistoryUsecase getAccountHistoryUsecase;
  final UpdateAccountUsecase updateAccountUsecase;
  final DeleteAccountUsecase deleteAccountUsecase;

  AccountBloc({
    required this.getAccountUsecase,
    required this.getAccountsUsecase,
    required this.addAccountUsecase,
    required this.getAccountHistoryUsecase,
    required this.updateAccountUsecase,
    required this.deleteAccountUsecase,
  }) : super(AccountInitial()) {
    on<LoadAccount>(_onLoadAccount);
    on<UpdateAccount>(_onUpdateAccount);
  }

  Future<void> _onUpdateAccount(
    UpdateAccount event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      // some sort of mapper
      final updateAccountRequest = AccountUpdateRequest(
        name: event.account.name,
        balance: event.account.balance,
        currency: event.account.currency,
      );
      await updateAccountUsecase(account: updateAccountRequest);
      final updatedAccount = await getAccountUsecase(id: event.account.id);
      emit(AccountLoaded(account: updatedAccount));
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onLoadAccount(
    LoadAccount event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      final account = await getAccountUsecase(id: event.id);
      emit(AccountLoaded(account: account));
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }
}
