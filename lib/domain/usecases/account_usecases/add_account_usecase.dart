import 'package:coinio_app/domain/models/account_create_request/account_create_request.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class AddAccountUsecase {
  final AccountRepository accountRepository;
  AddAccountUsecase({required this.accountRepository});

  Future<void> call({required final AccountCreateRequest account}) async =>
      await accountRepository.addAccount(account: account);
}
