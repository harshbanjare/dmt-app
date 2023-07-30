import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmt/utils/ApiHelper.dart';
import 'Models/driver_data_model.dart';

Future<DriverData> fetchDriverData() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  print('config_token ${token!}');
  print('config_token $token');

  Map<String, dynamic> map =
      await ApiBaseHelper().post("user", {"token": token});

  if (map["status"] != null && !map["status"]) {
    return const DriverData(
      id: -1,
      name: "",
      mobile: "",
      email: "",
      user_type: "",
      profile_pic: "",
      sdk_key: "",
    );
  }

  var data = DriverData.fromJson(map);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', data.name.toString());
  prefs.setString('image', data.profile_pic.toString());

  return data;
}
