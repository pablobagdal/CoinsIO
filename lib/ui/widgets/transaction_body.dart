// import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_bloc.dart';
// import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class TransactionsBody extends StatefulWidget {
//   const TransactionsBody({super.key});

//   @override
//   State<TransactionsBody> createState() => _TransactionsBodyState();
// }

// class _TransactionsBodyState extends State<TransactionsBody> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TransactionBloc, TransactionState>(
//       builder: (context, state) {
//         if (state is TransactionError) {
//           return Center(child: Text('Ошибка: ${state.message}'));
//         } else if (state is TransactionsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is TransactionInitial) {
//           return const Center(child: Text('Загрузка...'));
//         } else if (state is TransactionsLoaded) {
//           final transactions = state.transactions;
//           if (transactions.isEmpty) {
//             return const Center(child: Text('Нет транзакций за сегодня'));
//           }
//           return Expanded(
//             child: ListView.builder(
//               itemCount: transactions.length,
//               itemBuilder: (context, index) {
//                 final tx = transactions[index];
//                 return Container(
//                   decoration: const BoxDecoration(
//                     border: Border(bottom: BorderSide(width: 0.5)),
//                   ),
//                   child: ListTile(
//                     onTap: () {},
//                     leading: const Icon(Icons.abc),
//                     title: Text('Название ${tx.categoryId}'),
//                     trailing: Row(
//                       mainAxisSize:
//                           MainAxisSize
//                               .min, // чтобы Row не занимал всё пространство
//                       children: [
//                         Text('${tx.amount} P'),
//                         const SizedBox(width: 8),
//                         IconButton(
//                           icon: const Icon(Icons.arrow_forward_ios),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                     subtitle: Text(tx.comment ?? 'Описание транзакции'),
//                   ),
//                 );
//               },
//             ),
//           );
//         } else {
//           return const Center(child: Text('Неизвестное состояние'));
//         }
//       },
//     );
//   }
// }
