import 'dart:io';
import 'dart:math';
import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dmt/pages/screens.dart';
import 'package:dmt/utils/ApiHelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCommentPage extends StatelessWidget {
  File imageFile = new File("");
  String type = '';
  bool isLoading = false;

  ImageCommentPage(File? imageFile, String type) {
    if (imageFile != null) {
      this.imageFile = imageFile;
      this.type = type;
    }
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  final TextEditingController textController = TextEditingController();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(color: Colors.white),
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
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                  ),
                ),
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        'Any Comment',
                        style: loginBigTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Any note for document',
                        style: whiteSmallLoginTextStyle,
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    ),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        ),
                        child: TextField(
                          style: inputLoginTextStyle,
                          //  obscureText: true,
                          controller: textController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            hintText: 'Note',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          uploadImage(context);

                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         duration: Duration(milliseconds: 600),
                          //         type: PageTransitionType.fade,
                          //         child: BottomBar()));
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
                            'Submit',
                            style: inputLoginTextStyle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              onWillPop: () async {
                bool backStatus = onWillPop();
                if (backStatus) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }
                return false;
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getTempPath() async {
    var dir = await getExternalStorageDirectory();
    await new Directory('${dir!.path}/CompressPdfs').create(recursive: true);
    String randomString = getRandomString(10);
    String pdfFileName = '$randomString.pdf';
    return '${dir.path}/CompressPdfs/$pdfFileName';
  }

  // Future<String?> openFilePicker() async {
  //   String outputPath = await getTempPath();
  //   try {
  //     await PdfCompressor.compressPdfFile(
  //         imageFile.path, outputPath, CompressQuality.HIGH);
  //         // imageFile.path, outputPath, CompressQuality.MEDIUM);
  //     return outputPath;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future uploadImage(context) async {
    print(' :::::::::::$type::::::::: --- ' + imageFile.path);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }));

    String path = "";
    // if (imageFile.path.contains('.pdf')) {
    //   String? result = await openFilePicker();
    //   if (result == null) {
    //     Fluttertoast.showToast(
    //         msg: "Please try again",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.CENTER,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.red,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //     Navigator.pop(context);
    //     return;
    //   } else {
    //     path = result;
    //   }
    // } else {
    path = imageFile.path;
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =
        (prefs.getString('token') != null ? prefs.getString('token') : "");

    Map map = await ApiBaseHelper().multiPart(
        "uploaddocument",
        {
          'category': type,
          'comment': textController.text.toString(),
          "token": '$token'
        },
        // {'category': "load", 'comment': textController.text.toString(), "token": '$token'},
        path,
        // imageFile.path,
        "files[]");

    if (map["status"] == true) {
      Fluttertoast.showToast(
          msg: "Uploaded Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: BottomBar()));
    } else {
      Fluttertoast.showToast(
          msg: "Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }
  }

  onWillPop() {
    return true;
  }
}
