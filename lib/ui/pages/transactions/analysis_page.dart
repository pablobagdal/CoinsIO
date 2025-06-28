import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnalysisPage extends StatelessWidget {
  final bool isIncome;
  // final DateTime startDate;
  // final DateTime endDate;
  const AnalysisPage({
    super.key,
    required this.isIncome,
    // required this.startDate,
    // required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<TransactionsHistoryBloc>();
    return Scaffold(
      appBar: AppBar(title: Text('Анализ')),
      body: _AnalysisPageView(),
    );
  }
}

class _AnalysisPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('123'));
  }
}
