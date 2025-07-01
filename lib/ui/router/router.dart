import 'package:coinio_app/core/fonts/my_icons.dart';
import 'package:coinio_app/main.dart';
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

part 'router_helpers.dart';

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
) => Scaffold(
  body: shell,
  bottomNavigationBar: NavigationBar(
    selectedIndex: shell.currentIndex,
    onDestinationSelected: (final index) {
      if (index == shell.currentIndex) {
        shell.goBranch(index, initialLocation: true);
      } else {
        shell.goBranch(index);
      }
    },
    destinations: [
      const NavigationDestination(
        icon: Icon(MyIcons.spendings),
        label: 'Расходы',
      ),
      const NavigationDestination(icon: Icon(MyIcons.incomes), label: 'Доходы'),
      const NavigationDestination(icon: Icon(MyIcons.account), label: 'Счета'),
      const NavigationDestination(
        icon: Icon(MyIcons.category),
        label: 'Статьи',
      ),
      const NavigationDestination(
        icon: Icon(MyIcons.settings),
        label: 'Настройки',
      ),
    ],
  ),
);
