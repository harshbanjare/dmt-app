import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/LoginPageNew.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  // Obtain shared preferences.
  late SharedPreferences prefs;
  late String _token;

  String? osUserID;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    initOneSignal(context);
  }

  Future<void> initOneSignal(BuildContext context) async {
    /// Set App Id.
    await OneSignal.shared.setAppId("d8bce1e1-1921-4eb5-a892-5a90f76591e0");

    /// So, that it can be used to send Notifications to users later.̥
    await Future.delayed(
        Duration(seconds: 10)); // Add a delay to allow registration to complete

    EasyLoading.showProgress(0.3, status: 'Waiting for onesignal...');

    final status = await OneSignal.shared.getDeviceState();
    // final String? osUserID = status?.userId;

    initOneSignal2(context);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );
  }

  Future<void> initOneSignal2(BuildContext context) async {
    /// Set App Id.
    // await OneSignal.shared.setAppId("d8bce1e1-1921-4eb5-a892-5a90f76591e0");
    await Future.delayed(
        Duration(seconds: 5)); // Add a delay to allow registration to complete

    /// Get the Onesignal userId and update that into the firebase.
    /// So, that it can be used to send Notifications to users later.̥
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    // Store it into shared prefs, So that later we can use it.
    saveODUserID(osUserID);

    print("player_id" + osUserID.toString());
    // Fluttertoast.showToast(
    //     msg: osUserID.toString() ?? "",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );
  }

  // Write DATA
  static Future<bool> saveODUserID(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("osUserID", value);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getLoginToken();
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    image: AssetImage('assets/icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLoginToken() async {
    prefs = await SharedPreferences.getInstance();
    var token =
        (prefs.getString('token') != null ? prefs.getString('token') : "");
    print('login_token ' + token!);
    Timer(
        Duration(seconds: 17),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    token.length > 10 ? BottomBar() : Login())));
  }
}
