import 'package:flutter/material.dart';

enum TransactionsHistorySort { dateDesc, dateAsc, amountDesc, amountAsc }

class TransactionsHistorySortDropDown extends StatelessWidget {
  final TransactionsHistorySort value;
  final ValueChanged<TransactionsHistorySort?> onChanged;
  const TransactionsHistorySortDropDown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(final BuildContext context) => DropdownButtonHideUnderline(
    child: DropdownButton<TransactionsHistorySort>(
      value: value,

      isDense: true,
      items: const [
        DropdownMenuItem(
          value: TransactionsHistorySort.dateDesc,
          child: Text('По дате (сначала новые)'),
        ),
        DropdownMenuItem(
          value: TransactionsHistorySort.dateAsc,
          child: Text('По дате (сначала старые)'),
        ),
        DropdownMenuItem(
          value: TransactionsHistorySort.amountDesc,
          child: Text('По сумме (сначала большие)'),
        ),
        DropdownMenuItem(
          value: TransactionsHistorySort.amountAsc,
          child: Text('По сумме (сначала меньшие)'),
        ),
      ],
      onChanged: onChanged,
    ),
  );
}
