import 'package:flutter/material.dart';

enum SortMode {
  dateAsc('Сначала старые'),
  dateDesc('Сначала новые'),
  amountAsc('Сначала дешёвые'),
  amountDesc('Сначала дорогие');

  final String label;
  const SortMode(this.label);
}

class SortModeDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
