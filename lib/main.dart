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

    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dm transport driver App',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   primaryColor: primaryColor,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   fontFamily: 'Noto Sans',
      //   textSelectionTheme: TextSelectionThemeData(
      //     cursorColor: primaryColor,
      //   ),
      //   highlightColor: Colors.transparent,
      //   splashColor: Colors.transparent,
      // ),
      home: SplashScreen(),

      // debugShowCheckedModeBanner: false,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('es'),
      //   const Locale('en'),
      // ],
      // builder: (context, child) {
      //   return ScrollConfiguration(
      //     behavior: MyBehavior(),
      //     child: MyApp(),
      //   );
      // },
      // home: SplashScreen(),
    );
  }
}
