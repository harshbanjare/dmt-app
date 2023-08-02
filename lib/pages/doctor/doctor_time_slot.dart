import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dmt/utils/ApiHelper.dart';
import 'package:dmt/pages/pdf/ViewPdf.dart';
import 'package:dmt/pages/pdf/ViewImage.dart';
import 'package:intl/intl.dart';
import 'package:dmt/pages/util/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

Future<List<dynamic>> getUploadedDocuments(
  DateTime dateTime,
  String token,
) async {
  debugPrint(dateTime.toString());
  debugPrint(token);
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  Map map = await ApiBaseHelper()
      .post("documentondate", {"date": formattedDate, "token": token});
  if (map["status"] == true) {
    return map['documents'];
  } else {
    return [];
  }
}

class DoctorTimeSlot extends StatefulWidget {
  final String doctorName = "bkjb",
      doctorImage = "ljilj",
      doctorType = "click to see document",
      experience = "khgkb";

  const DoctorTimeSlot({super.key});

  @override
  DoctorTimeSlotState createState() => DoctorTimeSlotState();
}

class DoctorTimeSlotState extends State<DoctorTimeSlot> {
  DateTime _selectedDate = DateTime.now();
  String selectedTime = '';
  late String selectedDate;
  late String monthString;
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 0));

  var selectedDateDocuments = [];
  var documentsYesterday = [];

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

  String token = "";

  Future<void> onSelectionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2019, 01, 01),
      lastDate: lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      getUploadedDocuments(_selectedDate, token).then(
        (value) => setState(() {
          selectedDateDocuments = value;
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      setState(() {
        token = sharedPreferences.getString('token') ?? "";
      });
    });
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: whiteColor,
            padding: EdgeInsets.only(top: fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Date to see documents"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: fixPadding * 2.0, vertical: fixPadding * 1.0),
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
                          margin: const EdgeInsets.only(top: 6, left: 5),
                          child: Text(
                            "${_selectedDate.toLocal()}".split(' ')[0],
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DocumentList(
                    documents: selectedDateDocuments,
                    doctorType: widget.doctorType,
                  ),
                  (token != "")
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DocumentsOnDate(
                                label: "Today",
                                date: DateTime.now(),
                                token: token,
                                doctorType: widget.doctorType,
                              ),
                              DocumentsOnDate(
                                label: "Yesterday",
                                date: DateTime.now()
                                    .subtract(const Duration(days: 1)),
                                token: token,
                                doctorType: widget.doctorType,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentsOnDate extends StatefulWidget {
  const DocumentsOnDate(
      {super.key,
      required this.label,
      required this.date,
      required this.token,
      required this.doctorType});

  final String label;
  final DateTime date;
  final String token;
  final String doctorType;

  @override
  State<DocumentsOnDate> createState() => _DocumentsOnDateState();
}

class _DocumentsOnDateState extends State<DocumentsOnDate> {
  var documents = [];

  @override
  void initState() {
    getUploadedDocuments(widget.date, widget.token)
        .then((value) => documents = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          (documents.isEmpty)
              ? Text("No documents found for ${widget.label}")
              : DocumentList(
                  documents: documents, doctorType: widget.doctorType)
        ],
      ),
    );
  }
}

class DocumentList extends StatelessWidget {
  const DocumentList(
      {super.key, required this.documents, required this.doctorType});

  final List<dynamic> documents;
  final String doctorType;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = documents[index];
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
                      const SizedBox(height: 7.0),
                      Text(
                        doctorType,
                        style: greyNormalTextStyle,
                      ),
                      const SizedBox(height: 7.0),
                      const SizedBox(height: 7.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                            '${item['document_path']}'.split(',').map((v) {
                          return GestureDetector(
                              onTap: () {
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
                                    duration: const Duration(milliseconds: 600),
                                    type: PageTransitionType.fade,
                                    child: path.contains('.pdf')
                                        ? ViewPdf(
                                            pdfurl:
                                                basePath.replaceAll('%20', ''),
                                          )
                                        : ViewImage(
                                            pdfurl:
                                                basePath.replaceAll('%20', ''),
                                          ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      blurRadius: 1.0,
                                      spreadRadius: 1.0,
                                      color: (Colors.grey[300])!,
                                    ),
                                  ],
                                  image: const DecorationImage(
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
                              duration: const Duration(milliseconds: 600),
                              type: PageTransitionType.fade,
                              child: const DoctorTimeSlot(),
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
            const Divider(),
          ],
        );
      },
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      height: 0.8,
      color: greyColor.withOpacity(0.3),
    );
  }
}
