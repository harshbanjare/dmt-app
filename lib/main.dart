import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dmt/appBehaviour/my_behaviour.dart';
import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'constant/constant.dart';
import 'onesignal/onesignal_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    await OneSignal.shared.setAppId("d8bce1e1-1921-4eb5-a892-5a90f76591e0");

    //Remove this method to stop OneSignal Debugging
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    // OneSignal.shared.setAppId("d8bce1e1-1921-4eb5-a892-5a90f76591e0");
    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   print("Accepted permission: $accepted");
    // });

    EasyLoading.init();

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dm transport driver App',
      home: SplashScreen(),
    );
  }
}
