import 'package:flutter/material.dart';
import 'package:dmt/pages/chat/chat_list.dart';
import 'package:dmt/pages/chat_new/model/chat.dart';

import '../../../chat/chat.dart';
import '../../service/socket_service.dart';
import '../../utils/constants.dart';
import '../chat/chat_page.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var name = '';

    proceed() {
      if (name.length < 3) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please Input at least 3 characters!')));
      } else {
        SocketService.setUserName(name);
        SocketService.connectAndListen();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ChatList(),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text(appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: size.width * 0.6,
              child: TextField(
                textAlign: TextAlign.center,
                autofocus: true,
                onChanged: (s) {
                  name = s;
                },
                onSubmitted: (s) => proceed(),
                decoration: const InputDecoration(
                    hintText: 'Enter Your Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: () => proceed(), child: const Text('Proceed')),
            SizedBox(height: size.height * 0.3),
            const Text(
              'Made with Flutter and Node.js',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
