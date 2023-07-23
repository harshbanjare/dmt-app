import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmt/utils/ApiHelper.dart';
import 'Models/driver_data_model.dart';

// String? token;

Future<DriverData> fetchDriverData() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  print('config_token ${token!}');
  print('config_token $token');

  Map<String, dynamic> map =
      await ApiBaseHelper().post("user", {"token": token});

  ///print('response $map');

  // final response = await http.get(Uri.parse(ServiceUrl.userDetail),
  //  final response = await http.post(Uri.parse(ServiceUrl.userDetail),
  //      body: {
  //        "token": '$token'
  //      }, headers: {
  //    'Content-Type': 'application/json',
  //    'Accept': 'application/json'
  // //   'Authorization': 'Bearer $token',
  //  });
  print('response ');
  // print('response $response');
  // if (response.statusCode == 200) {
  //   print(response.body);
  if (map != null) {
    var data = DriverData.fromJson(map);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', data.name.toString());
    prefs.setString('image', data.profile_pic.toString());
    // prefs.setString('profile', map.toString());
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
