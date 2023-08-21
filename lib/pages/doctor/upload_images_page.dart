import 'package:image_picker/image_picker.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class UploadImages extends StatefulWidget {
  final String ImagesType;
  const UploadImages({Key? key, required this.ImagesType}) : super(key: key);

  @override
  _ImagesListState createState() => _ImagesListState();
}

class _ImagesListState extends State<UploadImages> {
  late PickedFile _imageFile;
  final String uploadUrl = 'https://api.imgur.com/3/upload';

  Future<String?> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<void> retriveLostData() async {
    // final LostData response = await _picker.getLostData();
    // if (response.isEmpty) {
    //   return;
    // }
    // if (response.file != null) {
    //   setState(() {
    //     _imageFile = response.file!;
    //   });
    // } else {
    //   print('Retrieve error ' + response.exception!.code);
    // }
  }

  void _pickImage() async {
    // try {
    //   final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    //   setState(() {
    //     _imageFile = pickedFile!;
    //   });
    // } catch (e) {
    //   print("Image picker error " + e.toString());
    // }
  }

  final doctorList = [
    {
      'name': 'Upload Pickup Image',
      'image': 'assets/icons/image_upload_icon.png',
      'exp': '8',
      'rating': '4.9',
      'review': '135'
    },
    {
      'name': 'Upload Delivery Proof Image',
      'image': 'assets/icons/image_upload_icon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Upload Trip Envelop Image',
      'image': 'assets/icons/image_upload_icon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Driver Expence Reciept Image',
      'image': 'assets/icons/image_upload_icon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Paper Logs Image',
      'image': 'assets/icons/image_upload_icon.png',
      'exp': '10',
      'rating': '4.7',
      'review': '235'
    },
    {
      'name': 'Load Images',
      'image': 'assets/icons/image_upload_icon.png',
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
      tag: widget.ImagesType,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          titleSpacing: 0.0,
          elevation: 0.0,
          title: Text(
            widget.ImagesType,
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
                                const SizedBox(height: 7.0),
                                Text(
                                  widget.ImagesType,
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
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: const Duration(milliseconds: 600),
                                  type: PageTransitionType.fade,
                                  child: const DoctorTimeSlot(
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
                            onTap: () {
                              _pickImage();
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         duration: Duration(milliseconds: 600),
                              //         type: PageTransitionType.fade,
                              //         child: Camscanner())
                              // );
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
                                'Upload Now',
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
