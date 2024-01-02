import 'package:flutter/material.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Архив',
            style: TextStyle(fontFamily: 'Lobster'),
          ),
          centerTitle: true,
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        SizedBox(width: 10),
                        Text('Выход')
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(
                          Icons.cleaning_services_outlined,
                          color: Theme.of(context).appBarTheme.foregroundColor,
                        ),
                        SizedBox(width: 10),
                        Text('Очистить всё')
                      ],
                    ),
                  )
                ],
                onChanged: (value) {
                  // ArvhiveClear();
                },
              ),
            ),
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...getArchiveList(),
            ],
          ),
        ),
      ),
    );
  }

// Создаем список виджетов архивных заявок
  List<Widget> getArchiveList() {
    List<Widget> list = [];
    for (var i = 0; i < 50; i++) {
      list.add(
        // Добавляем элементы смахивания и удаляемости
        Dismissible(
          background: Container(
            color: Colors.green,
            child: Text('Восстановить...'),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Text('Удалить...'),
          ),
          key: ValueKey<int>(i),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${i + 1}) Архивная заявка...'),
          ),
        ),
      );
    }
    return list;
  }
}
