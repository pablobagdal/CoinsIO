import 'package:coinio_app/domain/usecases/get_transaction_use_case.dart';
import 'package:coinio_app/domain/usecases/get_transactions_by_period_use_case.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_event.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionUseCase getTransactionUseCase;
  final GetTransactionsByPeriodUseCase getTransactionsByPeriodUseCase;

  TransactionBloc({
    required this.getTransactionUseCase,
    required this.getTransactionsByPeriodUseCase,
  }) : super(InitialState()) {
    on<LoadTransactionsByPeriod>((event, emit) async {
      emit(TransactionsLoading());
      try {
        final now = DateTime.now();

        // final startOfDay = event.startDate;
        final startOfDay = DateTime(now.year, now.month, now.day);

        final endOfDay = event.endDate;
        // final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

        final transactions = await getTransactionsByPeriodUseCase.call(
          startOfDay,
          endOfDay,
        );

        emit(TransactionsLoaded(transactions: transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<LoadTransaction>((event, emit) {
      // TODO loadTransaction emit
    });
  }
}
