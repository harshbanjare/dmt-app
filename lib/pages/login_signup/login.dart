import 'dart:convert';
import 'dart:io';

import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/login/api/api_service.dart';
import 'package:dmt/pages/login/model/login_model.dart';
import 'package:dmt/pages/login_signup/password.dart';

// import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:dmt/pages/util/ApiUrl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmt/utils/ApiHelper.dart';
import '../bottom_bar.dart';

List listRoute = [];
late SharedPreferences prefs;
late final String? osUserID;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.status;
    data['token'] = this.token;
    return data;
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late DateTime currentBackPressTime;
  String phoneNumber = '';
  late String phoneIsoCode;
  final TextEditingController phonecontroller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  Future<LoginModel>? _futureAlbum;
  final pwdcontroller = TextEditingController();
  final mobileontroller = TextEditingController();
  String country = "IN";

  @override
  void initState() {
    super.initState();
    getosUserID();
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
      decoration: BoxDecoration(
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
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
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
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        'Welcome back',
                        style: loginBigTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Login in your account',
                        style: whiteSmallLoginTextStyle,
                      ),
                    ),
                    SizedBox(height: 70.0),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: InternationalPhoneNumberInput(
                          textStyle: inputLoginTextStyle,
                          autoValidateMode: AutovalidateMode.disabled,
                          countries: ["IN", "US", "CA"],
                          selectorTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          initialValue: number,
                          // validator: (input) =>input!.isEmpty && input!.length<10
                          //     ? "Enter a valid mobile"
                          //     : null,
                          maxLength: 11,
                          inputBorder: InputBorder.none,
                          inputDecoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10.0, bottom: 15),
                            hintText: 'Phone Number',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),

                          textFieldController: phonecontroller,
                          // selectorType: PhoneInputSelectorType.DIALOG,
                          onInputChanged: (PhoneNumber value) {
                            setState(() {
                              country = value.isoCode.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          style: inputLoginTextStyle,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            hintText: 'Password',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),
                          controller: pwdcontroller,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          // Fluttertoast.showToast(
                          //     msg: "Hello"+phonecontroller.text+" "+pwdcontroller.text,
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.CENTER,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.red,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0
                          // );
                          //trim all black space
                          String mobile = phonecontroller.text.toString();
                          mobile = mobile.replaceAll(' ', '');

                          sendLoginRequest(
                              context,
                              mobile,
                              pwdcontroller.text.toString(),
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
                              stops: [0.1, 0.5, 0.9],
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
                    SizedBox(height: 10.0),
                    // Text(
                    //   'We\'ll send OTP for Verification',
                    //   textAlign: TextAlign.center,
                    //   style: whiteSmallLoginTextStyle,
                    // ),
                    SizedBox(height: 30.0),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Padding(
                    //     padding: EdgeInsets.all(20.0),
                    //     child: Container(
                    //       padding: EdgeInsets.all(15.0),
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(30.0),
                    //         color: Color(0xFF3B5998),
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           Image.asset(
                    //             'assets/facebook.png',
                    //             height: 25.0,
                    //             fit: BoxFit.fitHeight,
                    //           ),
                    //           SizedBox(width: 10.0),
                    //           Text(
                    //             'Log in with Facebook',
                    //             style: whiteSmallLoginTextStyle,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Padding(
                    //     padding: EdgeInsets.all(20.0),
                    //     child: Container(
                    //       padding: EdgeInsets.all(15.0),
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(30.0),
                    //         color: Colors.white,
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           Image.asset(
                    //             'assets/google.png',
                    //             height: 25.0,
                    //             fit: BoxFit.fitHeight,
                    //           ),
                    //           SizedBox(width: 10.0),
                    //           Text(
                    //             'Log in with Google',
                    //             style: blackSmallLoginTextStyle,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
      savelogintoken((map['token']).toString());
      saveCountry(country);
      Fluttertoast.showToast(
          msg: "Login Successful " + osUserID,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: BottomBar()));
      _futureAlbum = LoginModel.fromJson(map as Map<String, dynamic>)
          as Future<LoginModel>?;
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

  Future<dynamic> sendLoginRequestOld(String mobile, String pwd) async {
    final response = await http.post(
      Uri.parse(ServiceUrl.loginApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'password': pwd,
      }),
    );

    if (response.statusCode == 200) {
      dynamic loginData = LoginModel.fromJson(jsonDecode(response.body));
      savelogintoken(loginData.token);
      Fluttertoast.showToast(
          msg: "Login Successful ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: BottomBar()));

      _futureAlbum =
          LoginModel.fromJson(jsonDecode(response.body)) as Future<LoginModel>?;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // throw Exception('Please try again.'+response.body);
      Fluttertoast.showToast(
          msg: "Invalid user credentials, Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // return LoginModel.fromJson(jsonDecode(response.body));
      // return ;
      //throw Exception('Please try again.'+response.body);
    }
  }

  void getosUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      osUserID = prefs.getString("osUserID");
      print("onesignal_playerId2" + osUserID.toString());
    });
  }
}

savelogintoken(String token) async {
  prefs = await SharedPreferences.getInstance();
  print(token);
  prefs.setString('token', token);
}

// getosUserID() async {
//   prefs = await SharedPreferences.getInstance();
//   osUserID=prefs.getString('osUserID');
//   print("onesignal_playerId2"+osUserID.toString());
// }

saveCountry(String country) async {
  prefs = await SharedPreferences.getInstance();
  prefs.setString('country', country);
}
