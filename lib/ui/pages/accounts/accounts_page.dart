import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/core/utils/di.dart';
import 'package:coinio_app/domain/models/account/account.dart';

import 'package:coinio_app/domain/usecases/account_usecases/account_usecases.dart';

import 'package:coinio_app/ui/blocs/account_bloc/account_bloc.dart';
import 'package:coinio_app/ui/blocs/account_bloc/account_event.dart';
import 'package:coinio_app/ui/blocs/account_bloc/account_state.dart';
import 'package:coinio_app/ui/pages/accounts/balance_graphic.dart';

import 'package:coinio_app/ui/pages/accounts/show_currency_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoiler_widget/spoiler_widget.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:io' show Platform;

Map<String, String> currencySigns = {'RUB': '₽', 'USD': '\$', 'EUR': '€'};

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(final BuildContext context) => _AccountPageView();
}

class _AccountPageView extends StatefulWidget {
  @override
  State<_AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<_AccountPageView> {
  bool _textVisible = false;
  ShakeDetector? _detector;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb && Platform.isAndroid) {
      _detector = ShakeDetector.autoStart(
        onPhoneShake: (ShakeEvent event) {
          setState(() {
            _textVisible = !_textVisible;
          });
        },
        minimumShakeCount: 2,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        shakeThresholdGravity: 2.7,
      );
    }
  }

  @override
  void dispose() {
    if (!kIsWeb && Platform.isAndroid) {
      _detector?.stopListening();
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: BlocBuilder<AccountBloc, AccountState>(
        builder: (final context, final state) {
          if (state is AccountLoaded) {
            return Text(state.account.name);
          } else {
            return const Text('Error name');
          }
        },
      ),
      actions: [
        BlocBuilder<AccountBloc, AccountState>(
          builder: (final context, final state) {
            if (state is AccountLoaded) {
              return IconButton(
                onPressed: () {
                  final bloc = context.read<AccountBloc>();
                  // context.go('/accounts/balance');
                  _showEditDialog(context, bloc: bloc, account: state.account);
                },
                icon: const Icon(Icons.mode_edit_outlined),
              );
            } else {
              return const Icon(Icons.edit_outlined);
            }
          },
        ),
      ],
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AccountBloc, AccountState>(
              builder: (final context, final state) {
                if (state is AccountLoaded) {
                  return _accountBalanceRow(
                    context,
                    balance: state.account.balance,
                    currency: state.account.currency,
                  );
                } else {
                  return _accountBalanceRow(
                    context,
                    balance: 'Нет данных',
                    currency: 'Нет данных',
                  );
                }
              },
            ),
            const Divider(height: 1),
            BlocBuilder<AccountBloc, AccountState>(
              builder: (final context, final state) {
                if (state is AccountLoaded) {
                  return _accountCurrencyRow(context, account: state.account);
                }
                return _accountCurrencyRow(context);
              },
            ),
            const Divider(height: 1),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // TODO: переход к созданию чего-то
      },
      child: const Icon(Icons.add),
    ),
  );

  Future<void> _showEditDialog(
    final BuildContext context, {
    required final Account account,
    required final AccountBloc bloc,
  }) async {
    final TextEditingController controller = TextEditingController(
      text: account.name,
    );

    await showDialog(
      context: context,
      builder:
          (final context) => AlertDialog(
            title: const Text('Изменить название счёта'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Введите новое название',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () {
                  final newName = controller.text.trim();
                  if (newName.isNotEmpty) {
                    // Сохраняем новое название (например, через Bloc/Provider)
                    // context.read<AccountBloc>().add(
                    //   UpdateAccountName(newName: newName),
                    // );
                    bloc.add(
                      UpdateAccount(account: account.copyWith(name: newName)),
                    );
                    Navigator.pop(context, newName); // Возвращаем новое имя
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
    );
  }

  Widget _accountBalanceRow(
    final BuildContext context, {
    required final String balance,
    required final String currency,
  }) => Container(
    padding: const EdgeInsets.all(16.0),
    decoration: const BoxDecoration(color: AppColors.greenlight1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          spacing: 16.0,
          children: [
            CircleAvatar(child: Text('💰', style: TextStyle(fontSize: 28))),
            Text('Баланс'),
          ],
        ),
        Row(
          spacing: 16.0,
          children: [
            SpoilerText(
              text: '$balance ${currencySigns[currency]}',
              config: TextSpoilerConfig(
                isEnabled: _textVisible,
                enableFadeAnimation: true,
                enableGestureReveal: true,
                textStyle: const TextStyle(fontSize: 16, color: Colors.black),
                particleColor: Colors.grey,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );

  Widget _accountCurrencyRow(
    final BuildContext context, {
    final Account? account,
  }) {
    // final currency = context.read<AccountBloc>().state.account.currency;
    final sign = account == null ? 'шт' : currencySigns[account.currency]!;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(color: AppColors.greenlight1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Валюта'),
              Row(
                children: [
                  Text(sign),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () async {
                      final selected = await showCurrencyPicker(context);
                      if (selected != null && account != null) {
                        context.read<AccountBloc>().add(
                          UpdateAccount(
                            account: account.copyWith(currency: selected),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 350,
          child: BalanceChart(
            dailyBalances: dailyBalances,
            monthlyBalances: monthlyBalances,
            initialIsDailyView: true,
          ),
        ),
      ],
    );
  }
}

// Примерные данные для демонстрации
final Map<DateTime, double> dailyBalances = {
  DateTime(2024, 12, 1): 1500.0,
  DateTime(2024, 12, 2): -800.0,
  DateTime(2024, 12, 3): 2200.0,
  DateTime(2024, 12, 4): -1200.0,
  DateTime(2024, 12, 5): 900.0,
  DateTime(2024, 12, 6): 1800.0,
  DateTime(2024, 12, 7): -600.0,
  DateTime(2024, 12, 8): 1100.0,
  DateTime(2024, 12, 9): -1500.0,
  DateTime(2024, 12, 10): 2000.0,
  DateTime(2024, 12, 11): 700.0,
  DateTime(2024, 12, 12): -900.0,
  DateTime(2024, 12, 13): 1300.0,
  DateTime(2024, 12, 14): -400.0,
  DateTime(2024, 12, 15): 1600.0,
  DateTime(2024, 12, 16): 800.0,
  DateTime(2024, 12, 17): -1100.0,
  DateTime(2024, 12, 18): 1900.0,
  DateTime(2024, 12, 19): -700.0,
  DateTime(2024, 12, 20): 1400.0,
  DateTime(2024, 12, 21): 1000.0,
  DateTime(2024, 12, 22): -800.0,
  DateTime(2024, 12, 23): 2100.0,
  DateTime(2024, 12, 24): -1300.0,
  DateTime(2024, 12, 25): 1700.0,
  DateTime(2024, 12, 26): 600.0,
  DateTime(2024, 12, 27): -1000.0,
  DateTime(2024, 12, 28): 1200.0,
  DateTime(2024, 12, 29): -500.0,
  DateTime(2024, 12, 30): 1800.0,
};

final Map<DateTime, double> monthlyBalances = {
  DateTime(2024, 7, 31): 15000.0,
  DateTime(2024, 8, 31): -8000.0,
  DateTime(2024, 9, 30): 22000.0,
  DateTime(2024, 10, 31): -12000.0,
  DateTime(2024, 11, 30): 18000.0,
  DateTime(2024, 12, 30): 25000.0,
};
