import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:dmt/camscanner/utils.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'final_comment.dart';

class UploadCamDoc extends StatefulWidget {
  final String doctorType;

  const UploadCamDoc({Key? key, required this.doctorType}) : super(key: key);

  @override
  _UploadsCamDocListState createState() => _UploadsCamDocListState();
}

class _UploadsCamDocListState extends State<UploadCamDoc> {
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(milliseconds: 600),
                                      type: PageTransitionType.fade,
                                      child: CamFinalCommentPage()));
                            },
                            child: Container(
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.push(
                      //           context,
                      //           PageTransition(
                      //             duration: Duration(milliseconds: 600),
                      //             type: PageTransitionType.fade,
                      //             child: DoctorTimeSlot(
                      //               // doctorImage: item['image'],
                      //               // doctorName: item['name'],
                      //               // doctorType: widget.doctorType,
                      //               // experience: item['exp'],
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       child: Container(
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             PageTransition(
                      //                 duration: Duration(milliseconds: 600),
                      //                 type: PageTransitionType.fade,
                      //                 child: FinalCommentPage())
                      //         );
                      //       },
                      //       child: Container(
                      //         width: (width - fixPadding * 6 + 1.4) / 2.0,
                      //         padding: EdgeInsets.all(fixPadding),
                      //         alignment: Alignment.center,
                      //         decoration: BoxDecoration(
                      //           image: DecorationImage(
                      //               image: AssetImage('assets/icons/pdf_icon.png'), fit: BoxFit.cover),
                      //
                      //     ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
