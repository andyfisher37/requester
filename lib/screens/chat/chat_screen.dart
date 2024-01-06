import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:requester/controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ctrl = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    // Загружаем предыдущие сообщения...
    ctrl.loadMessagesFromFile('assets/chat/messages.json');

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
                ctrl.messages.clear();
                ctrl.update();
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
      body: SafeArea(
        child: GetBuilder<ChatController>(
          builder: (_) => Chat(
            theme: Get.isDarkMode
                ? const DarkChatTheme()
                : const DefaultChatTheme(),
            messages: ctrl.messages,
            onAttachmentPressed: ctrl.handleAttachmentPressed,
            onMessageTap: ctrl.handleMessageTap,
            onPreviewDataFetched: ctrl.handlePreviewDataFetched,
            onSendPressed: ctrl.handleSendPressed,
            showUserAvatars: true,
            showUserNames: true,
            user: ctrl.user,
          ),
        ),
      ),
    );
  }
}
