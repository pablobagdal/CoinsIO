import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/data/repositories/mock_account_repository.dart';
import 'package:coinio_app/domain/usecases/accounts/get_account_usecase.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_bloc.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_event.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

class _AccountPageView extends StatelessWidget {
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
                  // context.go('/accounts/balance');
                  _showEditDialog(context, state.account.name);
                },
                icon: const Icon(Icons.mode_edit_outlined),
              );
            } else {
              return Icon(Icons.edit_outlined);
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
                balance: state.account.balance,
                currency: state.account.currency,
              ),
        ),
        const Divider(height: 1),
        BlocBuilder<AccountBloc, AccountState>(
          builder:
              (final context, final state) =>
                  _accountCurrencyRow(currency: state.account.currency),
        ),
        const Divider(height: 1),
        _accountGraphicView(context),
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
    final String currentName,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: currentName,
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
                    context.read<AccountBloc>().add(
                      UpdateAccountName(newName: newName),
                    );
                    Navigator.pop(context, newName); // Возвращаем новое имя
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
    ).then((final newName) {
      if (newName != null) {
        // Обновляем данные (например, через Bloc)
        print('Новое название: $newName');
      }
    });
  }

  Widget _accountBalanceRow({
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
            Text('$balance $currency'),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );
  Widget _accountCurrencyRow({required final String currency}) => Container(
    padding: const EdgeInsets.all(16.0),
    decoration: const BoxDecoration(color: AppColors.greenlight1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(spacing: 16.0, children: [Text('Валюта')]),
        Row(
          spacing: 16.0,
          children: [
            const Text('RUB'),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );

  Widget _accountGraphicView(final BuildContext context) => Center(
    child: Image.asset(
      'assets/temp_graphic.png',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.5,
    ),
  );
}
