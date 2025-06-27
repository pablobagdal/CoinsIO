import 'package:coinio_app/domain/models/account/account.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class GetAccountUsecase {
  final AccountRepository accountRepository;

  GetAccountUsecase({required this.accountRepository});

  Future<Account> call(int id) async =>
      await accountRepository.getAccount(id: id);
}
