import 'package:coinio_app/core/themes/app_theme.dart';
import 'package:coinio_app/data/datasource/local/local_data_source/app_database.dart';
import 'package:coinio_app/data/repositories/account_repository_impl.dart';
import 'package:coinio_app/domain/usecases/account_usecases/account_usecases.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_bloc.dart';
import 'package:coinio_app/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // AppDependencies dependencies;
  final AppDatabase db;
  const MyApp({required this.db, super.key});

  @override
  Widget build(final BuildContext context) {
    // keep all usecases here until use some DI (get_it, etc.)
    final accountRepository = AccountRepositoryImpl(db: db);

    final getAccountUsecase = GetAccountUsecase(
      accountRepository: accountRepository,
    );
    final getAccountsUsecase = GetAccountsUsecase(
      accountRepository: accountRepository,
    );
    final getAccountHistoryUsecase = GetAccountHistoryUsecase(
      accountRepository: accountRepository,
    );
    final updateAccountUsecase = UpdateAccountUsecase(
      accountRepository: accountRepository,
    );
    final addAccountUsecase = AddAccountUsecase(
      accountRepository: accountRepository,
    );
    final deleteAccountUsecase = DeleteAccountUsecase(
      accountRepository: accountRepository,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AccountBloc(getAccountUsecase: null)),
      ],
      child: MaterialApp.router(
        title: 'Coins IO',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: router,
      ),
    );
  }
}
