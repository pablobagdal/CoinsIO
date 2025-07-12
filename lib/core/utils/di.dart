import 'package:coinio_app/core/network/api_client.dart';
import 'package:coinio_app/data/datasources/local/account_local_data_source.dart';
import 'package:coinio_app/data/datasources/local/category_local_data_source.dart';
import 'package:coinio_app/data/datasources/local/transaction_local_data_source.dart';
import 'package:coinio_app/data/datasources/remote/account_remote_data_source.dart';
import 'package:coinio_app/data/datasources/remote/category_remote_data_source.dart';
import 'package:coinio_app/data/datasources/remote/transaction_remote_data_source.dart';
import 'package:coinio_app/ui/blocs/account_bloc/account_bloc.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_bloc.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:coinio_app/data/datasources/local/db/app_database.dart';

import 'package:coinio_app/domain/repositories/account_repository.dart';
import 'package:coinio_app/data/repositories/account_repository_impl.dart';
import 'package:coinio_app/domain/usecases/account_usecases/account_usecases.dart';

import 'package:coinio_app/domain/repositories/category_repository.dart';
import 'package:coinio_app/data/repositories/category_repository_impl.dart';
import 'package:coinio_app/domain/usecases/category_usecases/category_usecases.dart';

import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/data/repositories/transaction_repository_impl.dart';
import 'package:coinio_app/domain/usecases/transaction_usecases/transaction_usecases.dart';

/// DI
final getIt = GetIt.instance;

/// Setup dependencies for the app
Future<void> setupDependencies() async {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<AppDatabase>(AppDatabase());

  getIt.registerSingleton<ApiClient>(ApiClient(dio: getIt()));

  // Account
  getIt.registerSingleton<AccountLocalDataSource>(
    AccountLocalDataSource(db: getIt()),
  );
  getIt.registerSingleton<AccountRemoteDataSource>(
    AccountRemoteDataSource(apiClient: getIt()),
  );
  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(localDataSource: getIt(), remoteDataSource: getIt()),
  );

  getIt.registerFactory(() => GetAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => GetAccountsUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => UpdateAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => AddAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => DeleteAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(
    () => GetAccountHistoryUsecase(accountRepository: getIt()),
  );
  getIt.registerFactory<AccountBloc>(
    () => AccountBloc(
      getAccountUsecase: getIt(),
      getAccountsUsecase: getIt(),
      updateAccountUsecase: getIt(),
    ),
  );

  // Category
  getIt.registerSingleton<CategoryLocalDataSource>(
    CategoryLocalDataSource(db: getIt()),
  );
  getIt.registerSingleton<CategoryRemoteDataSource>(
    CategoryRemoteDataSource(apiClient: getIt()),
  );
  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(remoteDataSource: getIt(), localDataSource: getIt()),
  );

  getIt.registerFactory(
    () => GetCategoriesUsecase(categoryRepository: getIt()),
  );
  getIt.registerFactory(
    () => GetCategoryByIdUsecase(categoryRepository: getIt()),
  );
  getIt.registerFactory(
    () => GetCategoriesByTypeUsecase(categoryRepository: getIt()),
  );
  getIt.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getCategoriesUsecase: getIt(),
      getCategoryByIdUsecase: getIt(),
      getCategoriesByTypeUsecase: getIt(),
    ),
  );

  // Transaction
  getIt.registerSingleton<TransactionLocalDataSource>(
    TransactionLocalDataSource(db: getIt()),
  );
  getIt.registerSingleton<TransactionRemoteDataSource>(
    TransactionRemoteDataSource(apiClient: getIt()),
  );
  getIt.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
    ),
  );
  getIt.registerFactory(
    () => GetTransactionUsecase(transactionRepository: getIt()),
  );
  getIt.registerFactory(
    () => GetTransactionsByPeriodUsecase(transactionRepository: getIt()),
  );
  getIt.registerFactory(
    () => AddTransactionUsecase(transactionRepository: getIt()),
  );
  getIt.registerFactory(
    () => UpdateTransactionUsecase(transactionRepository: getIt()),
  );
  getIt.registerFactory(
    () => DeleteTransactionUsecase(transactionRepository: getIt()),
  );

  // getIt.registerFactory<TransactionBloc>(
  //   () => TransactionBloc(
  //     getTransactionUsecase: getIt(),
  //     getTransactionsByPeriodUsecase: getIt(),
  //     addTransactionUsecase: getIt(),
  //     deleteTransactionUsecase: getIt(),
  //     updateTransactionUsecase: getIt(),
  //     isIncome: null,
  //     startDate: null,
  //     endDate: null,
  //   ),
  // );
}
