abstract class AccountEvent {}

class ChangeAccount extends AccountEvent {}

class UpdateAccountCurrency extends AccountEvent {
  final String newCurrency;

  UpdateAccountCurrency({required this.newCurrency});
}

class UpdateAccountName extends AccountEvent {
  final String newName;

  UpdateAccountName({required this.newName});
}
