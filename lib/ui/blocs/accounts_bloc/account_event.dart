abstract class AccountEvent {}

class ChangeAccount extends AccountEvent {}

class UpdateAccountCurrency extends AccountEvent {}

class UpdateAccountName extends AccountEvent {
  final String newName;

  UpdateAccountName({required this.newName});
}
