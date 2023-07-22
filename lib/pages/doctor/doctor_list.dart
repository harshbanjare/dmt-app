import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'final_comment.dart';

class DoctorList extends StatefulWidget {
  final String doctorType;

  const DoctorList({Key? key, required this.doctorType}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final doctorList = [
    {
      'name': 'Upload Pickup Doc',
      'image': 'assets/icons/pdficon.png',
      'exp': '8',
      'rating': '4.9',
      'review': '135'
    },
    {
      'name': 'Upload Delivery Proof',
      'image': 'assets/icons/pdficon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Upload Trip Envelop',
      'image': 'assets/icons/pdficon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Driver Expence Reciept',
      'image': 'assets/icons/pdficon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Paper Logs',
      'image': 'assets/icons/pdficon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Load Image',
      'image': 'assets/icons/pdficon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var preferredSize = "65";
    return Hero(
      tag: widget.doctorType,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          titleSpacing: 0.0,
          elevation: 0.0,
          title: Text(
            widget.doctorType,
            style: appBarTitleTextStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // bottom: PreferredSize(
          //   preferredSize: PreferredSize(),
          //   child: Container(
          //     color: whiteColor,
          //     height: 65.0,
          //     padding: EdgeInsets.only(
          //       left: fixPadding * 2.0,
          //       right: fixPadding * 2.0,
          //       top: fixPadding,
          //     ),
          //     alignment: Alignment.center,
          //   ),
          // ),
        ),
        body: ListView.builder(
          itemCount: doctorList.length,
          itemBuilder: (context, index) {
            final item = doctorList[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  color: Colors.grey[300]!,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(item['image'].toString()),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          widthSpace,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${item['name']}',
                                  style: blackNormalBoldTextStyle,
                                ),
                                SizedBox(height: 7.0),
                                Text(
                                  widget.doctorType,
                                  style: greyNormalTextStyle,
                                ),
                                SizedBox(height: 7.0),
                                // Text(
                                //   '${item['exp']} Years Experience',
                                //   style: primaryColorNormalTextStyle,
                                // ),
                                SizedBox(height: 7.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    widthSpace,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      heightSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (doctorList == 0) {
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     duration: Duration(milliseconds: 600),
                                //     type: PageTransitionType.fade,
                                //     child: DoctorTimeSlot(
                                //     ),
                                //   ),
                                // );
                              }
                            },
                            child: Container(),
                          ),
                          InkWell(
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 600),
                                        type: PageTransitionType.fade,
                                        child: CamFinalCommentPage()));
                              } else if (index == 1) {
                                Fluttertoast.showToast(
                                    msg: "Doctor List 2",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (index == 2) {
                                Fluttertoast.showToast(
                                    msg: "Doctor List 3",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (index == 3) {
                                Fluttertoast.showToast(
                                    msg: "Doctor List 4",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (index == 4) {
                                Fluttertoast.showToast(
                                    msg: "Doctor List 5",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (index == 5) {
                                Fluttertoast.showToast(
                                    msg: "Doctor List 6",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Container(
                              width: (width - fixPadding * 6 + 1.4) / 2.0,
                              padding: EdgeInsets.all(fixPadding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(width: 0.7, color: primaryColor),
                              ),
                              child: Text(
                                'Upload',
                                style: primaryColorsmallBoldTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  divider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      height: 0.8,
      color: greyColor.withOpacity(0.3),
    );
  }
}
