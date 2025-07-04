import 'package:coinio_app/core/themes/app_theme.dart';
import 'package:coinio_app/core/utils/di.dart';
import 'package:coinio_app/data/datasource/local/local_data_source/app_database.dart';
import 'package:coinio_app/domain/usecases/account_usecases/account_usecases.dart';
import 'package:coinio_app/domain/usecases/category_usecases/category_usecases.dart';
import 'package:coinio_app/ui/blocs/account_bloc/account_bloc.dart';
import 'package:coinio_app/ui/blocs/category_bloc/category_bloc.dart';
import 'package:coinio_app/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // AppDependencies dependencies;
  final AppDatabase db;
  const MyApp({required this.db, super.key});

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create:
            (_) => AccountBloc(
              getAccountUsecase: getIt<GetAccountUsecase>(),
              getAccountsUsecase: getIt<GetAccountsUsecase>(),
              updateAccountUsecase: getIt<UpdateAccountUsecase>(),
            ),
      ),
      BlocProvider(
        create:
            (_) => CategoryBloc(
              getCategoriesUsecase: getIt<GetCategoriesUsecase>(),
              getCategoryByIdUsecase: getIt<GetCategoryByIdUsecase>(),
              getCategoryByTypeUsecase: getIt<GetCategoryByTypeUsecase>(),
            ),
      ),
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
