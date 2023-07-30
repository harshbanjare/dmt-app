import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    await OneSignal.shared.setAppId("d8bce1e1-1921-4eb5-a892-5a90f76591e0");
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dm transport driver App',
      builder: EasyLoading.init(),
      home: const SplashScreen(),
    );
  }
}
