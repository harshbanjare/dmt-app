import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:dmt/pages/pdf/local_Pdf_view.dart';
import 'package:page_transition/page_transition.dart';

class UploadPdfGalleryPage extends StatefulWidget {
  final String doctorType;
  final String pdfurl;

  const UploadPdfGalleryPage(
      {Key? key, required this.doctorType, required this.pdfurl})
      : super(key: key);

  @override
  UploadPdfGalleryPageState createState() => UploadPdfGalleryPageState();
}

class UploadPdfGalleryPageState extends State<UploadPdfGalleryPage> {
  bool _loadingPath = false;
  final bool _multiPick = false;
  String? _directoryPath;
  final String _extension = 'pdf';
  String? _fileName;
  List<PlatformFile>? _paths;
  final FileType _pickingType = FileType.custom;

  var doctorList = [
    {
      'name': 'Upload Pickup Doc',
      'image': 'assets/icons/pdficon.png',
      'type': 'pickup',
      'exp': '8',
      'rating': '4.9',
      'review': '135'
    },
    {
      'name': 'Upload Delivery Proof',
      'image': 'assets/icons/pdficon.png',
      'type': 'delivery',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Upload Trip Envelop',
      'image': 'assets/icons/pdficon.png',
      'type': 'trip',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Driver Expense Receipt',
      'image': 'assets/icons/pdficon.png',
      'type': 'expense',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Paper Logs',
      'image': 'assets/icons/pdficon.png',
      'type': 'paper',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Load Image',
      'image': 'assets/icons/pdficon.png',
      'type': 'load',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
        ),
        body: ListView.builder(
          itemCount: doctorList.length,
          itemBuilder: (context, index) {
            var item = doctorList[index];
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
                                const SizedBox(height: 7.0),
                                Text(
                                  widget.doctorType,
                                  style: greyNormalTextStyle,
                                ),
                                const SizedBox(height: 7.0),
                                // Text(
                                //   '${item['exp']} Years Experience',
                                //   style: primaryColorNormalTextStyle,
                                // ),
                                const SizedBox(height: 7.0),
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
                              // Upload PDF
                              var type = item["type"].toString();
                              var doctorType = widget.doctorType.toString();
                              if (doctorType == "Upload PDF") {
                                var filePath = widget.pdfurl.toString();
                                _viewFileExplorer(type, filePath);
                              } else {
                                _openFileExplorer(type);
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

  void _openFileExplorer(type) async {
    print("Type " + type);

    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        // allowMultiple: _multiPick,
        allowedExtensions: (_extension.isNotEmpty ?? false)
            ? _extension.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation$e");
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      // print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      String filePath = _paths!.single.path!;
      print("filePath >>> $filePath");
      _viewFileExplorer(type, filePath);
    });
  }

  void _viewFileExplorer(uploadType, filePath) async {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 600),
        type: PageTransitionType.fade,
        child: LocalPdfViewPage(pdfurl: filePath, type: uploadType),
      ),
    );
  }
}
