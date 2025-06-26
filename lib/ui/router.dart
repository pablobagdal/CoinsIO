import 'package:coinio_app/core/fonts/my_icons.dart';
import 'package:coinio_app/ui/pages/accounts_page.dart';
import 'package:coinio_app/ui/pages/categories_page.dart';
import 'package:coinio_app/ui/pages/settings_page.dart';
import 'package:coinio_app/ui/pages/transactions/transactions_history_page.dart';
import 'package:coinio_app/ui/pages/transactions/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/expenses',
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (final context, final state, final shell) => Scaffold(
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
                const NavigationDestination(
                  icon: Icon(MyIcons.incomes),
                  label: 'Доходы',
                ),
                const NavigationDestination(
                  icon: Icon(MyIcons.account),
                  label: 'Счета',
                ),
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
          ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/expenses',
              builder:
                  (final context, final state) =>
                      const TransactionsPage(isIncome: false),
              routes: [
                GoRoute(
                  path: 'history',
                  builder:
                      (final context, final state) =>
                          const TransactionsHistoryPage(isIncome: false),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/incomes',
              builder:
                  (final context, final state) =>
                      const TransactionsPage(isIncome: true),
              routes: [
                GoRoute(
                  path: 'history',
                  builder:
                      (final context, final state) =>
                          const TransactionsHistoryPage(isIncome: true),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/accounts',
              builder: (final context, final state) => const AccountsPage(),
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
