import 'package:dartz/dartz.dart';
import 'package:coinio_app/core/datasource_failures.dart';
import 'package:coinio_app/data/models/freezed_models/account_models/account_model.dart';
import 'package:coinio_app/domain/repositories/bank_account_repository.dart';

class GetCurrentAccount {
  GetCurrentAccount(this.accountRepository);

  final BankAccountRepository accountRepository;

  Future<Either<Failure, AccountModel>> call() async {
    final failOrAccounts = await accountRepository.getAccounts();

    return failOrAccounts.fold(
      (fail) => Left(fail),
      (accounts) => Right(accounts.response.first),
    );
  }
}
