import 'package:coinio_app/data/models/account/account.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class GetAccountUsecase {
  final AccountRepository accountRepository;

  GetAccountUsecase({required this.accountRepository});

  Future<Account> call({required final int id}) async =>
      await accountRepository.getAccount(id: id);
}
