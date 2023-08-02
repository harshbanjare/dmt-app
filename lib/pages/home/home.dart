import 'dart:async';
import 'dart:io';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/imagepicker/pickimages.dart';
import 'package:dmt/pages/Models/driver_data_model.dart';
import 'package:dmt/pages/doctor/upload_pdf_from_phone.dart';
import 'package:dmt/pages/screens.dart';
import 'package:dmt/pages/util/ApiUrl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configapi.dart';

late Future<DriverData> futureAlbum;
String profileImg = "http://dm.ajeetwork.xyz/storage/app/public/";
String? token;

Future<String> getDemoStorageBaseDirectory() async {
  Directory storageDirectory;
  if (Platform.isAndroid) {
    storageDirectory = (await getExternalStorageDirectory())!;
  } else if (Platform.isIOS) {
    storageDirectory = await getApplicationDocumentsDirectory();
  } else {
    throw ('Unsupported platform');
  }

  return '${storageDirectory.path}/my-custom-storage';
}

_sendingMails() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'custom@dmtransport.ca',
    query: 'subject=Any Query&body=Hello Sir', //add subject and body here
  );
  if (!await launchUrl(params)) throw 'Could not launch $params';
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String city = 'Canada';

  // String city = 'Delhi,India';

  late Future<DriverData> futureAlbum;

  final doctorTypeList = [
    {'type': 'Scan Documents', 'image': 'assets/icons/scan_icon.png'},
    {'type': 'Load Images', 'image': 'assets/icons/image_upload_icon.png'},
    {'type': 'Upload PDF', 'image': 'assets/icons/pdf_icon.png'},
    {'type': 'Email Us', 'image': 'assets/icons/email_icon.png'},
    {'type': 'Call Us', 'image': 'assets/icons/phone_icon.png'},
    {'type': 'Help', 'image': 'assets/icons/help_icon.png'},
  ];

  @override
  void initState() {
    getCountry();
    super.initState();
  }

  void getCountry() async {
    prefs = await SharedPreferences.getInstance();
    var city = prefs.getString("country");
    setState(() {
      if (city == "IN") {
        city = "India";
      } else if (city == "CA") {
        city = "Canada";
      } else {
        city = "USA";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    futureAlbum = fetchDriverData();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: blackColor,
                size: 18.0,
              ),
              const SizedBox(width: 5.0),
              Text(
                city,
                style: appBarLocationTextStyle,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          profileBox(),
          heightSpace,
          heightSpace,
          doctorBySpeciality(),
          heightSpace,
          heightSpace
        ],
      ),
    );
  }

  profileBox() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(fixPadding * 2.0),
        padding: EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blueAccent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widthSpace,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<DriverData>(
                          future: futureAlbum,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data != null
                                    ? snapshot.data!.name
                                    : '',
                                style: whiteColorHeadingTextStyle,
                                maxLines: 1,
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                '',
                                style: whiteColorHeadingTextStyle,
                                maxLines: 1,
                              );
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }),
                      const SizedBox(height: 5.0),
                      FutureBuilder<DriverData>(
                          future: futureAlbum,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              profileImg = ServiceUrl.img_path +
                                  (snapshot.data != null
                                      ? snapshot.data!.profile_pic
                                      : '');
                              return Text(
                                (snapshot.data != null
                                    ? snapshot.data!.mobile
                                    : ''),
                                style: whiteColorHeadingTextStyle,
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                '',
                                // (snapshot.error != null?'${snapshot.error}':''),
                                style: whiteColorHeadingTextStyle,
                              );
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [],
                  ),
                ],
              ),
            ),
            FutureBuilder<DriverData>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    profileImg = ServiceUrl.img_path +
                        (snapshot.data != null
                            ? snapshot.data!.profile_pic
                            : '');

                    return Container(
                      width: 60.0,
                      height: 60.0,
                      // margin: EdgeInsets.only(top:50),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 0.2, color: greyColor),
                        image: DecorationImage(
                          image: NetworkImage(profileImg),
                          //profilePic
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      width: 60.0,
                      height: 60.0,
                      // margin: EdgeInsets.only(top:50),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 0.2, color: greyColor),
                        image: const DecorationImage(
                          image: NetworkImage("profileImg"),
                          //profilePic
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }

  banner() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: width,
      height: height / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: const DecorationImage(
          image: AssetImage('assets/banner.jpg'),
          fit: BoxFit.fill,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1.0,
            spreadRadius: 1.0,
            color: (Colors.grey[400])!,
          ),
        ],
      ),
    );
  }

  doctorBySpeciality() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            'Select Options',
            style: blackHeadingTextStyle,
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 30.0,
          mainAxisSpacing: 30.0,
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: doctorTypeList
              .map((item) => InkWell(
                    onTap: () {
                      if (doctorTypeList.indexOf(item) == 0) {
                        _cameraToImage(context);
                      } else if (doctorTypeList.indexOf(item) ==
                          1) // Image From Gallery
                      {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 800),
                            type: PageTransitionType.fade,
                            child: const PickImagePage(),
                          ),
                        );
                      } else if (doctorTypeList.indexOf(item) ==
                          2) // PDF From Gallery
                      {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 800),
                            type: PageTransitionType.fade,
                            child: const UploadPdfGalleryPage(
                              pdfurl: "",
                              doctorType: 'Upload PDF From Your Device',
                            ),
                          ),
                        );
                      } else if (doctorTypeList.indexOf(item) == 3) {
                        _sendingMails();
                      } else if (doctorTypeList.indexOf(item) == 4) {
                        launchUrl(Uri.parse("tel:+18448203434"));
                      } else if (doctorTypeList.indexOf(item) == 5) {
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: 'info@dmtransport.ca',
                          query:
                              'subject=Any Query&body=Hello Sir', //add subject and body here
                        );
                        launchUrl(params);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15.0),
                        border:
                            Border.all(width: 0.3, color: lightPrimaryColor),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                            color: (Colors.grey[300])!,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            item['image']!,
                            width: 70.0,
                            height: 70.0,
                            fit: BoxFit.cover,
                          ),
                          heightSpace,
                          Text(
                            item['type']!,
                            style: blackNormalBoldTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  type: PageTransitionType.fade,
                  child: const Speciality(),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ],
    );
  }

  void _cameraToImage(BuildContext context) {
    var androidLabelsConfigs = {
      ScannerLabelsConfig.ANDROID_SAVE_BUTTON_LABEL: "Save It",
      ScannerLabelsConfig.ANDROID_ROTATE_LEFT_LABEL: "Turn it left",
      ScannerLabelsConfig.ANDROID_ROTATE_RIGHT_LABEL: "Turn it right",
      ScannerLabelsConfig.ANDROID_ORIGINAL_LABEL: "Original",
      ScannerLabelsConfig.ANDROID_BMW_LABEL: "Clear",
      ScannerLabelsConfig.PDF_GALLERY_EMPTY_TITLE: "Scan Documents",
      ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Crop & Next",
      ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Scan Documents",
      ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE: "Scan Documents"
    };
    DocumentScannerFlutter.launchForPdf(
      context,
      labelsConfig: androidLabelsConfigs,
      source: ScannerFileSource.CAMERA,
    ).then((doc) {
      if (doc == null) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UploadPdfGalleryPage(
            doctorType: "Upload PDF",
            pdfurl: doc.path,
          ),
        ),
      );
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
