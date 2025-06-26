import 'package:coinio_app/core/themes/app_theme.dart';
import 'package:coinio_app/ui/router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // AppDependencies dependencies;
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp.router(
    title: 'Coins IO',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.system,
    routerConfig: router,
    // home: MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (final context) => NavigationBloc()),
    //     BlocProvider(
    //       create:
    //           (final context) => TransactionBloc(
    //             getTransactionUseCase: dependencies.getTransactionUseCase,
    //             getTransactionsByPeriodUsecase:
    //                 dependencies.getTransactionsByPeriodUsecase,
    //           )..add(
    //             LoadTransactionsByPeriod(
    //               startDate: DateTime.now().subtract(const Duration(days: 30)),
    //               endDate: DateTime.now(),
    //               id: 1,
    //             ),
    //           ),
    //     ),
    //   ],
    //   child: const MyScreens(),
    // ),
  );
}
