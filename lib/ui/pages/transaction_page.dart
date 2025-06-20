// import 'dart:convert';
// import 'package:coinio_app/domain/models/transaction/transaction.dart';
// import 'package:coinio_app/ui/blocs/transaction_bloc/transaction_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dashboard')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Welcome to your Finance Tracker!',
//                 style: Theme.of(context).textTheme.headlineSmall,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Use the navigation below to manage your expenses and incomes.',
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 40),
//               BlocBuilder<TransactionBloc, TransactionState>(
//                 builder: (context, state) {
//                   if (state is TransactionLoading &&
//                       !(state is TransactionLoaded)) {
//                     // Only show spinner if no data has been loaded yet
//                     return const CircularProgressIndicator();
//                   } else if (state is TransactionLoaded) {
//                     final totalExpenses = state.transactions
//                         .where((t) => t.type == TransactionType.expense)
//                         .fold<double>(0.0, (sum, item) => sum + item.amount);
//                     final totalIncomes = state.transactions
//                         .where((t) => t.type == TransactionType.income)
//                         .fold<double>(0.0, (sum, item) => sum + item.amount);
//                     final netBalance = totalIncomes - totalExpenses;

//                     return Column(
//                       children: [
//                         Card(
//                           elevation: 4,
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.arrow_circle_down,
//                                   color: TransactionType.income.color,
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   'Total Incomes:',
//                                   style:
//                                       Theme.of(context).textTheme.titleMedium,
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   '\$${totalIncomes.toStringAsFixed(2)}',
//                                   style: Theme.of(
//                                     context,
//                                   ).textTheme.titleLarge?.copyWith(
//                                     color: TransactionType.income.color,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Card(
//                           elevation: 4,
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.arrow_circle_up,
//                                   color: TransactionType.expense.color,
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   'Total Expenses:',
//                                   style:
//                                       Theme.of(context).textTheme.titleMedium,
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   '\$${totalExpenses.toStringAsFixed(2)}',
//                                   style: Theme.of(
//                                     context,
//                                   ).textTheme.titleLarge?.copyWith(
//                                     color: TransactionType.expense.color,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Card(
//                           elevation: 4,
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.account_balance_wallet,
//                                   color: Colors.blueGrey,
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   'Net Balance:',
//                                   style:
//                                       Theme.of(context).textTheme.titleMedium,
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   '\$${netBalance.toStringAsFixed(2)}',
//                                   style: Theme.of(
//                                     context,
//                                   ).textTheme.titleLarge?.copyWith(
//                                     color:
//                                         netBalance >= 0
//                                             ? Colors.green.shade800
//                                             : Colors.red.shade800,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else if (state is TransactionError) {
//                     return Text('Error: ${state.message}');
//                   }
//                   return const Text('Loading financial overview...');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class AddTransactionDialog extends StatefulWidget {
// //   final TransactionType type;

// //   const AddTransactionDialog({super.key, required this.type});

// //   @override
// //   State<AddTransactionDialog> createState() => _AddTransactionDialogState();
// // }

// // class _AddTransactionDialogState extends State<AddTransactionDialog> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _amountController = TextEditingController();
// //   final TextEditingController _descriptionController = TextEditingController();
// //   DateTime _selectedDate = DateTime.now();

// //   @override
// //   void dispose() {
// //     _amountController.dispose();
// //     _descriptionController.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _selectDate(BuildContext context) async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate,
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime(2101),
// //     );
// //     if (picked != null && picked != _selectedDate) {
// //       setState(() {
// //         _selectedDate = picked;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: Text('Add New ${widget.type.name}'),
// //       content: Form(
// //         key: _formKey,
// //         child: SingleChildScrollView(
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: <Widget>[
// //               TextFormField(
// //                 controller: _amountController,
// //                 keyboardType: const TextInputType.numberWithOptions(
// //                   decimal: true,
// //                 ),
// //                 decoration: InputDecoration(
// //                   labelText: 'Amount',
// //                   hintText: 'e.g., 50.00',
// //                   prefixText: '\$',
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 validator: (String? value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter an amount';
// //                   }
// //                   if (double.tryParse(value) == null) {
// //                     return 'Please enter a valid number';
// //                   }
// //                   if (double.parse(value) <= 0) {
// //                     return 'Amount must be greater than zero';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _descriptionController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Description',
// //                   hintText: 'e.g., Groceries, Salary',
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 validator: (String? value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter a description';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 16),
// //               ListTile(
// //                 title: Text(
// //                   'Date: ${_selectedDate.toLocal().toIso8601String().split('T')[0]}',
// //                 ),
// //                 trailing: const Icon(Icons.calendar_today),
// //                 onTap: () => _selectDate(context),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       actions: <Widget>[
// //         TextButton(
// //           child: const Text('Cancel'),
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //         ),
// //         ElevatedButton(
// //           style: ElevatedButton.styleFrom(backgroundColor: widget.type.color),
// //           onPressed: () {
// //             if (_formKey.currentState!.validate()) {
// //               final Transaction newTransaction = Transaction(
// //                 id: generateUniqueId(),
// //                 amount: double.parse(_amountController.text),
// //                 description: _descriptionController.text,
// //                 date: _selectedDate,
// //                 type: widget.type,
// //               );
// //               Navigator.of(context).pop(newTransaction);
// //             }
// //           },
// //           child: Text('Add ${widget.type.name}'),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class CategoriesPage extends StatelessWidget {
// //   const CategoriesPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Categories')),
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               Icon(Icons.category, size: 80, color: Colors.grey[400]),
// //               const SizedBox(height: 20),
// //               Text(
// //                 'Manage your transaction categories here.',
// //                 style: Theme.of(
// //                   context,
// //                 ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 10),
// //               Text(
// //                 'This page is under development.',
// //                 style: Theme.of(
// //                   context,
// //                 ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class SettingsPage extends StatelessWidget {
// //   const SettingsPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Settings')),
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               Icon(Icons.settings, size: 80, color: Colors.grey[400]),
// //               const SizedBox(height: 20),
// //               Text(
// //                 'Adjust application settings and preferences.',
// //                 style: Theme.of(
// //                   context,
// //                 ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 10),
// //               Text(
// //                 'This page is under development.',
// //                 style: Theme.of(
// //                   context,
// //                 ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
