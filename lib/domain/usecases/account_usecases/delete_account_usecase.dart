import 'package:coinio_app/domain/repositories/account_repository.dart';

class DeleteAccountUsecase {
  final AccountRepository accountRepository;
  DeleteAccountUsecase({required this.accountRepository});

  Future<void> call({required final int id}) async =>
      await accountRepository.deleteAccount(id: id);
}
