import 'package:get_it/get_it.dart';

import 'package:coinio_app/data/datasources/local/local_data_source/app_database.dart';

import 'package:coinio_app/domain/repositories/account_repository.dart';
import 'package:coinio_app/data/repositories/account_repository_impl.dart';
import 'package:coinio_app/domain/usecases/account_usecases/account_usecases.dart';

import 'package:coinio_app/domain/repositories/category_repository.dart';
import 'package:coinio_app/data/repositories/category_repository_impl.dart';
import 'package:coinio_app/domain/usecases/category_usecases/category_usecases.dart';

import 'package:coinio_app/domain/repositories/transaction_repository.dart';
import 'package:coinio_app/data/repositories/transaction_repository_impl.dart';
import 'package:coinio_app/domain/usecases/transaction_usecases/transaction_usecases.dart';

import 'package:coinio_app/data/repositories/mock_repositories/mock_account_repository.dart';
import 'package:coinio_app/data/repositories/mock_repositories/mock_category_repository.dart';
import 'package:coinio_app/data/repositories/mock_repositories/mock_transaction_repository.dart';

/// DI
final getIt = GetIt.instance;

/// Setup dependencies for the app
void setupDependencies() {
  final db = AppDatabase();

  getIt.registerSingleton<AppDatabase>(db);
  // Account
  getIt.registerSingleton<AccountRepository>(AccountRepositoryImpl(db: db));

  getIt.registerFactory(() => GetAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => GetAccountsUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => UpdateAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => AddAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => DeleteAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(
    () => GetAccountHistoryUsecase(accountRepository: getIt()),
  );
  // Category
  getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl(db: db));

  getIt.registerFactory(
    () => GetCategoriesUsecase(categoryRepository: getIt()),
  );
  getIt.registerFactory(
    () => GetCategoryByIdUsecase(categoryRepository: getIt()),
  );
  getIt.registerFactory(
    () => GetCategoriesByTypeUsecase(categoryRepository: getIt()),
  );
  // Transaction
  getIt.registerSingleton<TransactionRepository>(
    TransactionRepositoryImpl(db: db),
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
}

/// Setup mock dependencies for testing
void setupMockDependencies() {
  // Account
  getIt.registerSingleton<AccountRepository>(MockAccountRepository());

  getIt.registerFactory(() => GetAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => GetAccountsUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => UpdateAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => AddAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(() => DeleteAccountUsecase(accountRepository: getIt()));
  getIt.registerFactory(
    () => GetAccountHistoryUsecase(accountRepository: getIt()),
  );
  // Category
  getIt.registerSingleton<CategoryRepository>(MockCategoryRepository());

  getIt.registerFactory(
    () => GetCategoriesUsecase(categoryRepository: getIt()),
  );
  getIt.registerFactory(
    () => GetCategoryByIdUsecase(categoryRepository: getIt()),
  );
  getIt.registerFactory(
    () => GetCategoriesByTypeUsecase(categoryRepository: getIt()),
  );
  // Transaction
  getIt.registerSingleton<TransactionRepository>(MockTransactionRepository());
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
}
