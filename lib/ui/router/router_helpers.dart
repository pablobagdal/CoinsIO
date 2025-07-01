part of 'router.dart';

_transactionEditGoRoute({required final bool isIncome}) => GoRoute(
  path: 'transaction-edit',
  builder: (final context, final state) {
    final transactionId = state.uri.queryParameters['id'];
    return TransactionEditScreen(
      transactionId: transactionId,
      isIncome: isIncome,
    );
  },
);

_transactionsGoRoute({required final bool isIncome}) => GoRoute(
  path: isIncome ? '/incomes' : '/expenses',
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
        // route to edit from history page
        _transactionEditGoRoute(isIncome: isIncome),
      ],
    ),
    // route to edit from income/expense page
    _transactionEditGoRoute(isIncome: isIncome),
  ],
);
