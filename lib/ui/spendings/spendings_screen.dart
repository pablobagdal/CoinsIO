import 'package:flutter/material.dart';

class SpendingsScreen extends StatelessWidget {
  const SpendingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расходы сегодня'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
        ],
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Всего'), Text('436 558 P')],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder:
                  (context, index) => Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5)),
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.abc),
                      title: Text('Название транзакции $index'),
                      trailing: Row(
                        mainAxisSize:
                            MainAxisSize
                                .min, // чтобы Row не занимал всё пространство
                        children: [
                          Text('123 456.78 P'),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      subtitle: const Text('Описание транзакции'),
                      // isThreeLine: true,
                    ),
                  ),
              itemCount: 20,
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(
              //   parent: BouncingScrollPhysics(),
              // ),
              // padding: const EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
