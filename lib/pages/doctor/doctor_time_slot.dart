import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dmt/utils/ApiHelper.dart';
import 'package:dmt/pages/pdf/ViewPdf.dart';
import 'package:dmt/pages/pdf/ViewImage.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:dmt/pages/util/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class DoctorTimeSlot extends StatefulWidget {
  final String doctorName = "bkjb",
      doctorImage = "ljilj",
      doctorType = "click to see document",
      experience = "khgkb";

  @override
  _DoctorTimeSlotState createState() => _DoctorTimeSlotState();
}

class _DoctorTimeSlotState extends State<DoctorTimeSlot> {
  late DateTime _selectedDate;
  String selectedTime = '';
  late String selectedDate;
  late String monthString;
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(Duration(days: 0));

  var dataList = [];
  var dataList1 = [
    {
      'name': 'Pickup Doc',
      "category": "jpg",
      'image': 'assets/icons/pdficon.png',
      "document_path": [
        "files/eCfEkc422LBG2qpx63SX4nf0COkhiTEI9XBDv7Sb.png",
        "files/NMcgGYCDZNLOZEhn7CPfIN4tU5gfvJTDgwggpLX1.jpg",
        "files/xPAOa40qgXk8vOtMmHKy2mUWcNV0zEiQL65OaDsK.pdf"
      ],
      'exp': '8',
      'rating': '4.9',
      'review': '135'
    }
  ];

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    getUploadedDocuments();
  }

  void _resetSelectedDate() {
    DateTime now = new DateTime.now();
    _selectedDate = new DateTime(now.year, now.month, now.day);

    // _selectedDate = DateTime.now();
    // _selectedDate = date
    // var date = DateFormat('dd/MM/yyyy').format(args.value.startDate)
    // getUploadedDocuments();
  }

  Future getUploadedDocuments() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    print(' :::::::::::::::::::: --- ' + formattedDate);

    var sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    Map map = await ApiBaseHelper()
        .post("documentondate", {"date": formattedDate, "token": '$token'});
    if (map["status"] == true) {
      setState(() {
        dataList = map['documents'];
      });
      print('NEW Request :::::::::::::::::::: --- ' + dataList.toString());
    } else {
      setState(() {
        dataList = [];
      });
      Fluttertoast.showToast(
          msg:
              "No recent documents on selected data uploaded on $formattedDate",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: whiteColor,
                elevation: 1.0,
                automaticallyImplyLeading: false,
                title: Text(
                  "Uploaded Documents",
                  style: appBarTitleTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 1.0,
            child: Container(
              color: whiteColor,
              padding: EdgeInsets.only(top: fixPadding * 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select Date to see documents"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0,
                        vertical: fixPadding * 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.date_range, size: 26.0, color: greyColor),
                        GestureDetector(
                          onTap: () {
                            onSelectionDate(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 6, left: 5),
                            child: Text(
                              "${_selectedDate.toLocal()}".split(' ')[0],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightSpace,
                ],
              ),
            ),
          ),
          Expanded(
            child: doclist(),
          ),
        ],
      ),
    );
  }

  Future<void> onSelectionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2019, 01, 01),
        lastDate: lastDate);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      getUploadedDocuments();
    }
  }

  doclist() {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: dataList.length,
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = dataList[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //ViewPdf
          children: [
            Container(
              padding: EdgeInsets.all(fixPadding * 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['category']}',
                        style: blackNormalBoldTextStyle,
                      ),
                      SizedBox(height: 7.0),
                      Text(
                        widget.doctorType,
                        style: greyNormalTextStyle,
                      ),
                      SizedBox(height: 7.0),
                      SizedBox(height: 7.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // children: (('${item['document_path']}').split(',')).map((v) {
                        // children: [2,3,4,55,6].map((v) {
                        children:
                            '${item['document_path']}'.split(',').map((v) {
                          return GestureDetector(
                              onTap: () {
                                // var basePath = 'http://dm.ajeetwork.xyz/storage/app/public/';
                                var basePath = ServiceUrl.img_path;
                                var path = v
                                    .replaceAll('[', '')
                                    .replaceAll(']', '')
                                    .toString();
                                basePath =
                                    basePath + path.replaceAll('%20', '');

                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 600),
                                        type: PageTransitionType.fade,
                                        child: path.contains('.pdf')
                                            ? ViewPdf(
                                                pdfurl: basePath.replaceAll(
                                                    '%20', ''))
                                            : ViewImage(
                                                pdfurl: basePath.replaceAll(
                                                    '%20', ''))));
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      blurRadius: 1.0,
                                      spreadRadius: 1.0,
                                      color: (Colors.grey[300])!,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/icons/pdficon.png'),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ));
                        }).toList(),
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
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(milliseconds: 600),
                              type: PageTransitionType.fade,
                              child: DoctorTimeSlot(
                                  // doctorImage: item['image'],
                                  // doctorName: item['name'],
                                  // doctorType: widget.doctorType,
                                  // experience: item['exp'],
                                  ),
                            ),
                          );
                        },
                        child: Container(),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(),
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
