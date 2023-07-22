import 'dart:io';
import 'package:dmt/pages/screens.dart';
import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_new/service/socket_service.dart';
import 'chat_new/views/chat/chat_page.dart';
import 'chat_new/views/chat/user_list_view.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  late DateTime currentBackPressTime;

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70.0,
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getBottomBarItemTile(0, Icons.home),
              getBottomBarItemTile(1, Icons.date_range),
              getBottomBarItemTile(2, Icons.message),
              getBottomBarItemTile(3, Icons.person),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        child: (currentIndex == 0)
            ? Home()
            : (currentIndex == 1)
                ? DoctorTimeSlot()
                : (currentIndex == 2)
                    ? ChatList()
                    : Profile(),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            // var prefs = await SharedPreferences.getInstance();
            // prefs.setString('token', "");
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  getBottomBarItemTile(int index, icon) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      focusColor: primaryColor,
      onTap: () {
        proceedToChat();
        changeIndex(index);
      },
      child: Container(
        height: 50.0,
        width: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color:
              (currentIndex == index) ? Colors.grey[100] : Colors.transparent,
        ),
        child: Icon(icon,
            size: 30.0,
            color: (currentIndex == index) ? primaryColor : greyColor),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  proceedToChat() async {
    var prefs = await SharedPreferences.getInstance();
    String? nameFull = prefs.getString('name');
    SocketService.setUserName(nameFull!);
    SocketService.connectAndListen();
  }
}
