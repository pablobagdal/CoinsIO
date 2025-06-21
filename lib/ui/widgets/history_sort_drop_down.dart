import 'package:coinio_app/ui/blocs/history_bloc/history_event.dart';
import 'package:flutter/material.dart';

class HistorySortDropDown extends StatelessWidget {
  final HistorySort value;
  final ValueChanged<HistorySort?> onChanged;
  const HistorySortDropDown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<HistorySort>(
        value: value,

        isDense: true,
        items: const [
          DropdownMenuItem(
            value: HistorySort.dateDesc,
            child: Text('По дате (сначала новые)'),
          ),
          DropdownMenuItem(
            value: HistorySort.dateAsc,
            child: Text('По дате (сначала старые)'),
          ),
          DropdownMenuItem(
            value: HistorySort.amountDesc,
            child: Text('По сумме (сначала большие)'),
          ),
          DropdownMenuItem(
            value: HistorySort.amountAsc,
            child: Text('По сумме (сначала меньшие)'),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
