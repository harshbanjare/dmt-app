

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OneSignalService {
  static OneSignal? _instance;

  OneSignalSService() {
    getInstance();
    _instance!.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    _instance!.setAppId("d8bce1e1-1921-4eb5-a892-5a90f76591e0");
// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    _instance!.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    _instance!.setNotificationWillShowInForegroundHandler(
            (OSNotificationReceivedEvent event) {
// Will be called whenever a notification is received in foreground
// Display Notification, pass null param for not displaying the notification
          event.complete(event.notification);
        });
    _instance!
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
// Will be called whenever a notification is opened/button pressed.
    });
    _instance!.setPermissionObserver((OSPermissionStateChanges changes) {
// Will be called whenever the permission changes
// (ie. user taps Allow on the permission prompt in iOS)
    });
  }
  static OneSignal? getInstance() {
    _instance ??= OneSignal.shared;
    return _instance;
  }
  Future<void> getUserTokenId() async {
    var deviceState = await _instance!.getDeviceState();
    if (deviceState != null || deviceState?.userId != null) {
      String tokenId = deviceState!.userId!;
      print("TOKEN ID: $tokenId");
      saveODUserID(tokenId);
    }
  }
  void handleSendNotification(
      {required String tokenId,
        required String title,
        required String desc}) async {
    var notification = OSCreateNotification(
        playerIds: [tokenId], content: desc, heading: title);
    await _instance!.postNotification(notification);
  }
  // Write DATA
  static Future<bool> saveODUserID(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("osUserID", value);
  }

}