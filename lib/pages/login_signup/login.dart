import 'dart:io';
import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmt/utils/ApiHelper.dart';
import '../bottom_bar.dart';

List listRoute = [];
late SharedPreferences prefs;

class LoginModel {
  final bool status;
  final String token;

  const LoginModel({required this.status, required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = status;
    data['token'] = token;
    return data;
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  late DateTime currentBackPressTime;
  String phoneNumber = '';
  late String phoneIsoCode;
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  Future<LoginModel>? _futureAlbum;
  final _pwdController = TextEditingController();
  final _phoneController = TextEditingController();
  String country = "IN";
  late final String? osUserID;

  @override
  void initState() {
    super.initState();
    getOneSignalUserID();
    EasyLoading.dismiss();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/truck.jpeg'), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: WillPopScope(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        'Welcome back',
                        style: loginBigTextStyle,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Login in your account',
                        style: whiteSmallLoginTextStyle,
                      ),
                    ),
                    const SizedBox(height: 70.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: InternationalPhoneNumberInput(
                          textStyle: inputLoginTextStyle,
                          autoValidateMode: AutovalidateMode.disabled,
                          countries: const ["IN", "US", "CA"],

                          selectorTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          initialValue: number,
                          maxLength: (country == "IN") ? 11 : 10,
                          inputBorder: InputBorder.none,
                          inputDecoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 10.0, bottom: 15),
                            hintText: 'Phone Number',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),

                          textFieldController: _phoneController,
                          // selectorType: PhoneInputSelectorType.DIALOG,
                          onInputChanged: (PhoneNumber value) {
                            setState(() {
                              country = value.isoCode.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          style: inputLoginTextStyle,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            hintText: 'Password',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),
                          controller: _pwdController,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          String mobile = _phoneController.text.toString();
                          mobile = mobile.replaceAll(' ', '');

                          sendLoginRequest(
                              context,
                              mobile,
                              _pwdController.text.toString(),
                              country,
                              osUserID.toString());
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.1, 0.5, 0.9],
                              colors: [
                                Colors.blue[300]!.withOpacity(0.8),
                                Colors.blue[500]!.withOpacity(0.8),
                                Colors.blue[800]!.withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: inputLoginTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onWillPop: () async {
                bool backStatus = onWillPop();
                if (backStatus) {
                  exit(0);
                }
                return false;
              },
            ),
          ),
        ],
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
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

  FutureBuilder<LoginModel> buildFutureBuilder() {
    return FutureBuilder<LoginModel>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.token);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future sendLoginRequest(context, String mobile, String pwd, String country,
      String osUserID) async {
    // Map map = await ApiBaseHelper()
    Map map = await ApiBaseHelper().post(
        "login", {'mobile': mobile, 'password': pwd, 'player_id': osUserID});
    // if (map["status"] == true) {
    if (map["status"] == true) {
      // print((map['token']).toString());
      // _futureAlbum = LoginModel.fromJson(map as Map<String, dynamic>) as Future<LoginModel>;
      // print(_futureAlbum);
      //  return
      // LoginModel loginModel = LoginModel.fromJson(map) as Future<LoginModel>?;
      //  _futureAlbum = LoginModel.fromJson(map) as Future<LoginModel>?;
      saveLoginToken((map['token']).toString());
      saveCountry(country);
      Fluttertoast.showToast(
          msg: "Login Successful $osUserID",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context,
          PageTransition(
              duration: const Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: const BottomBar()));
      _futureAlbum = Future<LoginModel>.value(
          LoginModel.fromJson(map as Map<String, dynamic>));
    } else {
      Fluttertoast.showToast(
          msg: "Invalid user credentials, Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void getOneSignalUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      osUserID = prefs.getString("osUserID");
      print("onesignal_playerId2$osUserID");
    });
  }
}

saveLoginToken(String token) async {
  prefs = await SharedPreferences.getInstance();
  print(token);
  prefs.setString('token', token);
}

saveCountry(String country) async {
  prefs = await SharedPreferences.getInstance();
  prefs.setString('country', country);
}
