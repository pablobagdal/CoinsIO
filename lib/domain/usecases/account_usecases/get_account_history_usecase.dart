import 'package:coinio_app/data/models/account/account_history_response_model.dart';
import 'package:coinio_app/domain/repositories/account_repository.dart';

class GetAccountHistoryUsecase {
  final AccountRepository accountRepository;
  GetAccountHistoryUsecase({required this.accountRepository});

  Future<AccountHistoryResponse> call({required final int id}) async =>
      await accountRepository.getAccountHistory(id: id);
}
