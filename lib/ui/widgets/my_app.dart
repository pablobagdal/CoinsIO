import 'package:coinio_app/core/themes/app_theme.dart';
import 'package:coinio_app/main.dart';
import 'package:coinio_app/ui/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_event.dart';
import 'package:coinio_app/ui/widgets/my_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  AppDependencies dependencies;
  MyApp({super.key, required this.dependencies});

  @override
  Widget build(final BuildContext context) => MaterialApp(
    title: 'Coins IO',
    debugShowCheckedModeBanner: false,
    home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (final context) => NavigationBloc()),
        BlocProvider(
          create:
              (final context) => TransactionBloc(
                getTransactionUseCase: dependencies.getTransactionUseCase,
                getTransactionsByPeriodUsecase:
                    dependencies.getTransactionsByPeriodUsecase,
              )..add(
                LoadTransactionsByPeriod(
                  startDate: DateTime.now().subtract(const Duration(days: 30)),
                  endDate: DateTime.now(),
                  id: 1,
                ),
              ),
        ),
        // BlocProvider(
        //   create:
        //       (context) => TransactionsHistoryBloc(
        //         transactionRepository: dependencies.transactionRepository,
        //       ),
        // ),
      ],
      child: const MyScreens(),
    ),
    theme: AppTheme.light,
  );
}
