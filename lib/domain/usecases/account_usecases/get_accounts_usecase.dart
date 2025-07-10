import 'package:coinio_app/data/models/account/account.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class GetAccountsUsecase {
  final AccountRepository accountRepository;

  GetAccountsUsecase({required this.accountRepository});

  Future<List<Account>> call() async => await accountRepository.getAccounts();
}
