import 'package:coinio_app/core/fonts/my_icons.dart';
import 'package:coinio_app/ui/pages/accounts/account_change_balance.dart';
import 'package:coinio_app/ui/pages/accounts/accounts_page.dart';
import 'package:coinio_app/ui/pages/categories/categories_page.dart';
import 'package:coinio_app/ui/pages/settings_page.dart';
import 'package:coinio_app/ui/pages/transactions/transaction_edit/transaction_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:coinio_app/ui/pages/transactions/analysis_page.dart';
import 'package:coinio_app/ui/pages/transactions/transactions_history_page.dart';
import 'package:coinio_app/ui/pages/transactions/transactions_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/expenses',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: _scaffoldWithNavBar,
      branches: [
        StatefulShellBranch(routes: [_transactionsGoRoute(isIncome: false)]),
        StatefulShellBranch(routes: [_transactionsGoRoute(isIncome: true)]),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/accounts',
              builder: (final context, final state) => const AccountsPage(),
              routes: [
                GoRoute(
                  path: 'balance',
                  builder:
                      (final context, final state) =>
                          const AccountChangeBalance(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/items',
              builder: (final context, final state) => const CategoriesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (final context, final state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// method to create NavBar for whole app
Widget _scaffoldWithNavBar(
  final BuildContext context,
  final GoRouterState state,
  final StatefulNavigationShell shell,
) {
  final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
  return Scaffold(
    body: shell,
    bottomNavigationBar:
        isKeyboardOpen
            ? null
            : NavigationBar(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: (final index) {
                if (index == shell.currentIndex) {
                  shell.goBranch(index, initialLocation: true);
                } else {
                  shell.goBranch(index);
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(MyIcons.spendings),
                  label: 'Расходы',
                ),
                NavigationDestination(
                  icon: Icon(MyIcons.incomes),
                  label: 'Доходы',
                ),
                NavigationDestination(
                  icon: Icon(MyIcons.account),
                  label: 'Счета',
                ),
                NavigationDestination(
                  icon: Icon(MyIcons.category),
                  label: 'Статьи',
                ),
                NavigationDestination(
                  icon: Icon(MyIcons.settings),
                  label: 'Настройки',
                ),
              ],
            ),
  );
}

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
