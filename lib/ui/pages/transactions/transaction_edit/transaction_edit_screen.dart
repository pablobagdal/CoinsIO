import 'dart:math';

import 'package:coinio_app/core/utils/type_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class TransactionEditScreen extends StatefulWidget {
  final String? transactionId;
  final bool isIncome;

  const TransactionEditScreen({
    super.key,
    this.transactionId,
    required this.isIncome,
  });

  @override
  State<TransactionEditScreen> createState() => _TransactionEditScreenState();
}

class _TransactionEditScreenState extends State<TransactionEditScreen> {
  DateTime selectedDateTime = DateTime.now();
  late final TextEditingController sumController;
  late final TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    sumController = TextEditingController();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    sumController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final isEditing = widget.transactionId != null;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.close),
          ),
          centerTitle: true,
          title: Text(widget.isIncome ? 'Мои доходы' : 'Мои расходы'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              ListTile(
                leading: const Text(
                  'Счет',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Сбербанк',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Text(
                  'Статья',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ремонт',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Text(
                  'Сумма',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: SizedBox(
                  width: 300,
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    textAlign: TextAlign.right,
                    controller: sumController,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                    ),
                  ),
                ),
                onTap: () {},
              ),

              const Divider(),
              ListTile(
                leading: const Text(
                  'Дата',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dateFormat(selectedDateTime),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.calendar_today, size: 18),
                  ],
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDateTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != selectedDateTime) {
                    setState(() {
                      selectedDateTime = selectedDateTime.copyWith(
                        year: picked.year,
                        month: picked.month,
                        day: picked.day,
                      );
                    });
                  }
                },
              ),

              const Divider(),
              ListTile(
                leading: const Text(
                  'Время',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      timeFormat(selectedDateTime),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                  );
                  if (picked != null &&
                      picked != TimeOfDay.fromDateTime(selectedDateTime)) {
                    setState(() {
                      selectedDateTime = selectedDateTime.copyWith(
                        hour: picked.hour,
                        minute: picked.minute,
                      );
                    });
                  }
                },
              ),
              const Divider(),
              // section for comment
              ListTile(
                leading: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: commentController,
                    minLines: 1,
                    maxLines: null,
                    maxLength: 300,
                    decoration: InputDecoration(
                      hintText: 'Комментарий',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),

                onTap: () {},
              ),
              const Divider(),
              const Spacer(),
              if (isEditing) ...[
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 224, 105, 97),
                      ),
                    ),
                    onPressed: () => context.pop(),
                    child: const Text(
                      'Удалить',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
