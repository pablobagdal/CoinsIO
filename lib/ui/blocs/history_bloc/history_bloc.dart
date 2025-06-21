import 'package:coinio_app/data/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  // TODO implement usage of usecases instead of repos and params
  final TransactionRepository transactionRepository;

  DateTime? startDate;
  DateTime? endDate;
  bool? isIncome;
  HistorySort _sort = HistorySort.dateDesc;

  HistoryBloc({required this.transactionRepository}) : super(HistoryLoading()) {
    on<LoadHistory>(_onLoadHistory);
    on<ChangePeriod>(_onChangePeriod);
    on<ChangeSort>(_onChangeSort);
  }

  Future<void> _onLoadHistory(
    LoadHistory event,
    Emitter<HistoryState> emit,
  ) async {
    isIncome = event.isIncome;
    DateTime dateFrom = DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
      DateTime.now().day,
      0,
      0,
      0,
    );

    DateTime dateTo = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      23,
      59,
      59,
    );
    _sort = HistorySort.dateDesc;
    await _loadFullHistory(emit);
  }

  Future<void> _onChangePeriod(
    ChangePeriod event,
    Emitter<HistoryState> emit,
  ) async {
    startDate = event.startDate;
    endDate = event.endDate;

    // swap
    if (endDate!.isBefore(startDate!)) {
      // TODO remove !
      final tmp = startDate!;
      // TODO remove !
      startDate = endDate;
      endDate = tmp;
    }

    isIncome = event.isIncome;
    await _loadFullHistory(emit);
  }

  Future<void> _onChangeSort(
    ChangeSort event,
    Emitter<HistoryState> emit,
  ) async {
    _sort = event.sort;
    await _loadFullHistory(emit);
  }

  Future<void> _loadFullHistory(Emitter<HistoryState> emit) async {
    emit(HistoryLoading());

    final transactions = await transactionRepository.getTransactionsByPeriod(
      startDate: startDate,
      endDate: endDate,
      id: 1, // TODO
    );

    var filteredTransactions =
        transactions.where((t) => t.category.isIncome == isIncome).toList();

    // sort
    switch (_sort) {
      case HistorySort.dateDesc:
        filteredTransactions.sort(
          (a, b) => b.transactionDate.compareTo(a.transactionDate),
        );
        break;
      case HistorySort.dateAsc:
        filteredTransactions.sort(
          (a, b) => a.transactionDate.compareTo(b.transactionDate),
        );
        break;
      case HistorySort.amountDesc:
        filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case HistorySort.amountAsc:
        filteredTransactions.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }

    final _total = filteredTransactions.fold<double>(
      0,
      (sum, t) => sum + double.parse(t.amount),
    );

    emit(
      HistoryLoaded(
        transactions: filteredTransactions,
        total: _total,
        sort: _sort,
        startDate: startDate!,
        endDate: endDate!,
        // TODO remove !
      ),
    );
  }
}
