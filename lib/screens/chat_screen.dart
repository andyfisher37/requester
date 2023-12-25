import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Чат',
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
                      Text('Очистить чат')
                    ],
                  ),
                )
              ],
              onChanged: (value) {
                // ChatService().clear();
              },
            ),
          ),
          // Stack(
          //   children: [
          //     IconButton(
          //       onPressed: () {
          //         // Navigator.of(context).push(
          //         //   MaterialPageRoute(builder: (context) {
          //         //     return NotificationPage();
          //         //   }),
          //         // );
          //       },
          //       icon: const Icon(Icons.notifications),
          //     ),
          //     Positioned(
          //       top: 5,
          //       right: 5,
          //       child: CircleAvatar(
          //         maxRadius: 10,
          //         backgroundColor: Colors.red.shade800,
          //         child: Text(
          //           '', //'${Provider.of<ChatNotificationService>(context).itemsCount}',
          //           style: const TextStyle(fontSize: 12),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Placeholder(),
              Placeholder(),
              Placeholder(),
              Placeholder(),
            ],
          ),
        ),
      ),
    );
  }
}
