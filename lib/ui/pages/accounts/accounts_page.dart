import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/data/repositories/mock_account_repository.dart';
import 'package:coinio_app/domain/usecases/accounts/get_account_usecase.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_bloc.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_event.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_state.dart';
import 'package:coinio_app/ui/pages/accounts/show_currency_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoiler_widget/spoiler_widget.dart';
import 'package:shake/shake.dart';
import 'dart:io' show Platform;

Map<String, String> currencySigns = {'RUB': '₽', 'USD': '\$', 'EUR': '€'};

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final context) => AccountBloc(
          getAccountUsecase: GetAccountUsecase(
            accountRepository: MockAccountRepository(),
          ),
        ),
    child: _AccountPageView(),
  );
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
          if (state is AccountError) {
            return const Text('Ваш счёт');
          }

          if (state is AccountLoading) {
            return Text(state.account.name);
          }

          if (state is AccountLoaded) {
            return Text(state.account.name);
          }

          return const Text('Error name');
        },
      ),
      actions: [
        BlocBuilder<AccountBloc, AccountState>(
          builder: (final context, final state) {
            if (state is AccountLoading || state is AccountLoaded) {
              return IconButton(
                onPressed: () {
                  final bloc = context.read<AccountBloc>();
                  // context.go('/accounts/balance');
                  _showEditDialog(context, bloc);
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
    body: Column(
      children: [
        BlocBuilder<AccountBloc, AccountState>(
          builder:
              (final context, final state) => _accountBalanceRow(
                context,
                balance: state.account.balance,
                currency: state.account.currency,
              ),
        ),
        const Divider(height: 1),
        BlocBuilder<AccountBloc, AccountState>(
          builder:
              (final context, final state) => _accountCurrencyRow(
                context,
                currency: state.account.currency,
              ),
        ),
        const Divider(height: 1),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // TODO: переход к созданию чего-то
      },
      child: const Icon(Icons.add),
    ),
  );

  Future<void> _showEditDialog(
    final BuildContext context,
    final AccountBloc bloc,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: bloc.state.account.name,
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
                    bloc.add(UpdateAccountName(newName: newName));
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
    required final String currency,
  }) {
    final currency = context.read<AccountBloc>().state.account.currency;
    final sign = currencySigns[currency] ?? 'шт';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: AppColors.greenlight1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(spacing: 16.0, children: [Text('Валюта')]),
          Row(
            spacing: 16.0,
            children: [
              Text(sign),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  // _openCurrencyBottomSheet(context);
                  final selected = await showCurrencyPicker(context);
                  if (selected != null) {
                    context.read<AccountBloc>().add(
                      UpdateAccountCurrency(
                        newCurrency: selected,
                        account: context.read<AccountBloc>().state.account,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
