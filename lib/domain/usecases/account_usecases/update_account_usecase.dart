import 'package:coinio_app/data/models/account_update_request/account_update_request.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class UpdateAccountUsecase {
  final AccountRepository accountRepository;
  UpdateAccountUsecase({required this.accountRepository});

  Future<void> call({required final AccountUpdateRequest account}) async =>
      await accountRepository.updateAccount(account: account);
}
