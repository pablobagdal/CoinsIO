part of 'router.dart';

_transactionsGoRoute({required bool isIncome}) => GoRoute(
  path: '/expenses',
  builder: (final context, final state) => TransactionsPage(isIncome: isIncome),
  routes: [
    GoRoute(
      path: 'history',
      builder:
          (final context, final state) =>
              TransactionsHistoryPage(isIncome: isIncome),
      routes: [
        GoRoute(
          path: 'analysis',
          builder:
              (final context, final state) => AnalysisPage(isIncome: isIncome),
        ),
      ],
    ),
  ],
);
