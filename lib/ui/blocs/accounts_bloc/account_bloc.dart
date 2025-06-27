import 'dart:async';

import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/usecases/accounts/get_account_usecase.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_event.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountUsecase getAccountUsecase;

  AccountBloc({required this.getAccountUsecase})
    : super(
        AccountLoading(
          account: Account(
            id: 123,
            userId: 1,
            name: 'Мой СЧËТ',
            balance: '1233',
            currency: 'RUB',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ),
      ) {
    // on<someEvent>(someMethod);
    on<UpdateAccountName>(_onUpdateAccountName);
  }

  Future<void> _onUpdateAccountName(
    UpdateAccountName event,
    Emitter<AccountState> emit,
  ) async {
    // emit(AccountLoading(account: account))
    // TODO update name logic

    // this account should be accessed from mock repo via any usecase
    final account = Account(
      id: 123,
      userId: 1,
      name: event.newName,
      balance: '1233',
      currency: 'RUB',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // emit(AccountLoading(account: account));
    emit(AccountLoaded(account: account));
  }
}
