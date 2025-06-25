import 'package:coinio_app/domain/usecases/transactions/get_transaction_usecase.dart';
import 'package:coinio_app/domain/usecases/transactions/get_transactions_by_period_usecase.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_event.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionUsecase getTransactionUseCase;
  final GetTransactionsByPeriodUsecase getTransactionsByPeriodUsecase;

  TransactionBloc({
    required this.getTransactionUseCase,
    required this.getTransactionsByPeriodUsecase,
  }) : super(TransactionInitial()) {
    on<LoadTransactionsByPeriod>((event, emit) async {
      emit(TransactionsLoading());

      try {
        final transactions = await getTransactionsByPeriodUsecase.call(
          event.startDate,
          event.endDate,
          id: event.id,
        );

        emit(TransactionsLoaded(transactions: transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<LoadTransaction>(_onLoadTransaction);
  }

  Future<void> _onLoadTransaction(
    LoadTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    // TODO loadTransaction emit
  }

  //   Future<void> _onLoadTransactionsByPeriod(
  //     LoadTransactionsByPeriod event,
  //     Emitter<TransactionState> emit,
  //   ) async {
  //     (event, emit) async {
  //       emit(TransactionsLoading());
  //       try {
  //         // final now = DateTime.now();

  //         // final startOfDay = event.startDate;
  //         // final startOfDay = DateTime(now.year, now.month, now.day);

  //         // final endOfDay = event.endDate;
  //         // final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

  //         final transactions = await GetTransactionsByPeriodUsecase.call(
  //           event.startDate,
  //           event.endDate,
  //           id: event.id,
  //         );

  //         emit(TransactionsLoaded(transactions: transactions));
  //       } catch (e) {
  //         emit(TransactionError(e.toString()));
  //       }
  //     };
  //   }
}
