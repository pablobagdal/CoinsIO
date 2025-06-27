import 'package:coinio_app/core/themes/colors.dart';
import 'package:coinio_app/data/repositories/mock_account_repository.dart';
import 'package:coinio_app/domain/usecases/accounts/get_account_usecase.dart';
import 'package:coinio_app/ui/blocs/accounts_bloc/account_bloc.dart';
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
        IconButton(
          onPressed: () {
            context.go('/accounts/balance');
          },
          icon: const Icon(Icons.mode_edit_outlined),
        ),
      ],
    ),
    body: Column(
      children: [
        _accountBalanceRow(),
        Divider(height: 1),
        _accountCurrencyRow(),
        Divider(height: 1),
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

  Widget _accountBalanceRow() => Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: AppColors.greenlight1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 16.0,
          children: [
            CircleAvatar(child: Text('💰', style: TextStyle(fontSize: 28))),
            Text('Баланс'),
          ],
        ),
        Row(
          spacing: 16.0,
          children: [
            Text('123 123'),
            IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
          ],
        ),
      ],
    ),
  );
  Widget _accountCurrencyRow() => Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: AppColors.greenlight1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(spacing: 16.0, children: [Text('Валюта')]),
        Row(
          spacing: 16.0,
          children: [
            Text('RUB'),
            IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
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
