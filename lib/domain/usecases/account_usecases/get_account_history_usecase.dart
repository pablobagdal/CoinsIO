import 'package:coinio_app/data/models/account_history_response/account_history_response.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class GetAccountHistoryUsecase {
  final AccountRepository accountRepository;
  GetAccountHistoryUsecase({required this.accountRepository});

  Future<AccountHistoryResponse> call({required final int id}) async =>
      await accountRepository.getAccountHistory(id: id);
}
