import 'package:coinio_app/domain/models/transaction_response/transaction_response.dart';
import 'package:coinio_app/ui/blocs/history_bloc/history_event.dart';

abstract class HistoryState {
  const HistoryState();
}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<TransactionResponse> transactions;
  final double total;
  final HistorySort sort;
  final DateTime startDate;
  final DateTime endDate;

  const HistoryLoaded({
    required this.transactions,
    required this.total,
    required this.sort,
    required this.startDate,
    required this.endDate,
  });
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
}
