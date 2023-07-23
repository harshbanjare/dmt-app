import 'package:flutter/material.dart';
import '../../model/chat.dart';
import '../../service/socket_service.dart';
import '../../utils/constants.dart';
import 'message_view.dart';
import 'chat_text_input.dart';
import 'user_list_view.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text(appName)),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserListView(),
            _ChatBody(),
            SizedBox(height: 6),
            ChatTextInput(),
          ],
        ),
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chats = <Chat>[];
    ScrollController scrollController = ScrollController();

    ///scrolls to the bottom of page
    void _scrollDown() {
      try {
        Future.delayed(
            const Duration(milliseconds: 300),
            () => scrollController
                .jumpTo(scrollController.position.maxScrollExtent));
      } on Exception catch (_) {}
    }

    return Expanded(
      child: StreamBuilder(
        stream: SocketService.getResponse,
        builder: (BuildContext context, AsyncSnapshot<Chat> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            chats.add(snapshot.data!);
          }
          _scrollDown();
          return ListView.builder(
            controller: scrollController,
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) =>
                MessageView(chat: chats[index]),
          );
        },
      ),
    );
  }
}
