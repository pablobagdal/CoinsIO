import 'package:coinio_app/data/models/account/account_create_request_model.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class AddAccountUsecase {
  final AccountRepository accountRepository;
  AddAccountUsecase({required this.accountRepository});

  Future<void> call({required final AccountCreateRequest account}) async =>
      await accountRepository.addAccount(account: account);
}
