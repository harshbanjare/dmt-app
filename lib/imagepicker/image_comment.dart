import 'dart:io';
import 'dart:math';
import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dmt/pages/screens.dart';
import 'package:dmt/utils/ApiHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCommentPage extends StatelessWidget {
  ImageCommentPage({super.key, required this.imageFiles, required this.type});

  final List<File> imageFiles;
  final String type;
  bool isLoading = false;

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  final TextEditingController textController = TextEditingController();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
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
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                  ),
                ),
                body: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        'Any Comment',
                        style: loginBigTextStyle,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Any note for document',
                        style: whiteSmallLoginTextStyle,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    ),
                    const SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0.0)),
                        ),
                        child: TextField(
                          style: inputLoginTextStyle,
                          //  obscureText: true,
                          controller: textController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            hintText: 'Note',
                            hintStyle: inputLoginTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () async {
                          List<bool> uploadSuccess = [];

                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const Scaffold(
                              body: Center(child: CircularProgressIndicator()),
                            );
                          }));

                          for (File file in imageFiles) {
                            uploadSuccess.add(await uploadImage(context, file));
                          }

                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              body: Center(
                                child: SafeArea(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...List.generate(
                                      uploadSuccess.length,
                                      (ind) => true || uploadSuccess[0]
                                          ? Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                "Image ${ind + 1} Upload Success",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                "Image ${ind + 1} Upload Failed",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                    ),
                                    ElevatedButton(
                                      child: const Text("Continue"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              duration: const Duration(
                                                milliseconds: 600,
                                              ),
                                              type: PageTransitionType.fade,
                                              child: const BottomBar()),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                              ),
                            );
                          }));
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
                            'Submit',
                            style: inputLoginTextStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              onWillPop: () async {
                bool backStatus = onWillPop();
                if (backStatus) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                }
                return false;
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> uploadImage(context, File image) async {
    debugPrint(' :::::::::::$type::::::::: --- ${image.path}');

    String path = image.path;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('token') ?? "");

    Map map = await ApiBaseHelper().multiPart(
      "uploaddocument",
      {
        'category': type,
        'comment': textController.text.toString(),
        "token": token
      },
      path,
      "files[]",
    );

    return map["status"];
  }

  onWillPop() {
    return true;
  }
}
