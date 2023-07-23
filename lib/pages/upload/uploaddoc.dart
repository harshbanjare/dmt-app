import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/screens.dart';
import 'package:dmt/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Uploaddoc extends StatefulWidget {
  const Uploaddoc({super.key});

  @override
  _UploaddocState createState() => _UploaddocState();
}

class _UploaddocState extends State<Home> {
  String city = 'Delhi,India';

  final doctorTypeList = [
    {'type': 'Upload Documents', 'image': 'assets/icons/uploaddocicon.png'},
    // {'type': 'Monthly Orders', 'image': 'assets/icons/patient.png'},
    // {'type': 'Gynecologist', 'image': 'assets/icons/woman.png'},
    // {'type': 'Pediatrician', 'image': 'assets/icons/pediatrician.png'},
    // {'type': 'Physiotherapist', 'image': 'assets/icons/physiotherapist.png'},
    // {'type': 'Nutritionist', 'image': 'assets/icons/nutritionist.png'},
    // {'type': 'Spine and Pain Specialist', 'image': 'assets/icons/pain.png'},
    // {'type': 'Dentist', 'image': 'assets/icons/dentist.png'}
  ];

  final labList = [
    {
      'name': 'PickUp PDF',
      'image': 'assets/icons/pdficon.png',
      'address': '455 1st Avenue, Gandhi Nagar, NY 10016, Delhi',
      'lat': 40.7392475,
      'lang': -73.9795667
    },
    {
      'name': 'Proof of Delivery PDF',
      'image': 'assets/icons/pdficon.png',
      'address': '455 1st Avenue, Gandhi Nagar, NY 10016, Delhi',
      'lat': 40.7392475,
      'lang': -73.9795667
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'Upload Documents',
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: Container(
            color: whiteColor,
            height: 65.0,
            padding: EdgeInsets.only(
              left: fixPadding * 2.0,
              right: fixPadding * 2.0,
              top: fixPadding,
              bottom: fixPadding,
            ),
            alignment: Alignment.center,
            child: Container(
              height: 55.0,
              padding: EdgeInsets.all(fixPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8.0),
                border:
                    Border.all(width: 1.0, color: greyColor.withOpacity(0.6)),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          // Search Start
          // search(),
          // Search End

          profile_box(),
          //profile box ended
          // Banner Start
          // banner(),
          // Banner End
          heightSpace,
          heightSpace,
          // Find doctor by speciality Start
          doctorBySpeciality(),
          // Find doctor by speciality End
          heightSpace,
          heightSpace,
          // Lab tests & health checkup start
          healthCheckup(),
          // Lab tests & health checkup end
        ],
      ),
    );
  }

  profile_box() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: 400),
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: const Profile()));
      },
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
                      Text(
                        'Rajesh Kumar',
                        style: whiteColorHeadingTextStyle,
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'HR-26A-45822',
                        style: whiteColorSmallTextStyle,
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [],
                  ),
                ],
              ),
            ),
            Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                image: const DecorationImage(
                  image: AssetImage('assets/user/user_7.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
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
            color: Colors.grey[400]!,
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
            'Order Summary',
            style: blackHeadingTextStyle,
          ),
        ),
        SizedBox(
          height: 190.0,
          child: ListView.builder(
            itemCount: doctorTypeList.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = doctorTypeList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: const Duration(milliseconds: 800),
                      type: PageTransitionType.fade,
                      child: const Uploaddoc(),
                    ),
                  );
                },
                child: Container(
                  width: 180.0,
                  padding: EdgeInsets.all(fixPadding),
                  alignment: Alignment.center,
                  margin: (index == doctorTypeList.length - 1)
                      ? EdgeInsets.all(fixPadding * 2.0)
                      : EdgeInsets.only(
                          left: fixPadding * 2.0,
                          top: fixPadding * 2.0,
                          bottom: fixPadding * 2.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(width: 0.3, color: lightPrimaryColor),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.grey[300]!,
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
              );
            },
          ),
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
                      child: const Speciality()));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              // children: [
              //   Text(
              //     'View All',
              //     style: primaryColorNormalBoldTextStyle,
              //   ),
              //   SizedBox(width: 5.0),
              //   Icon(
              //     Icons.arrow_forward_ios,
              //     size: 16.0,
              //     color: blackColor,
              //   ),
              // ],
            ),
          ),
        ),
      ],
    );
  }

  healthCheckup() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: scaffoldBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recently Uploaded Documents',
            style: blackHeadingTextStyle,
          ),
          ColumnBuilder(
            itemCount: labList.length,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            itemBuilder: (context, index) {
              final item = labList[index];
              return InkWell(
                onTap: () {
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => WebViewContainer("https://docs.google.com/viewer?url=https://www.clickdimensions.com/links/TestPDFfile.pdf", "Document")), (route) => false);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: fixPadding * 2.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: whiteColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: (Colors.grey[300])!,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150.0,
                        width: width / 3.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(10.0)),
                          image: DecorationImage(
                            image: AssetImage(item['image'].toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(fixPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              Text(
                                item['name'].toString(),
                                style: blackNormalBoldTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              // Text(
                              //   item['address'],
                              //   style: greySmallBoldTextStyle,
                              // ),
                              // heightSpace,
                              // Container(
                              //   padding: EdgeInsets.all(fixPadding),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(8.0),
                              //     border: Border.all(
                              //         width: 0.7, color: primaryColor),
                              //   ),
                              //   child: Text(
                              //     'Pending',
                              //     style: primaryColorsmallBoldTextStyle,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 165.0,
                        width: 30.0,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18.0,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            textDirection: TextDirection.ltr,
          ),
          heightSpace,
          heightSpace,
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: const Duration(milliseconds: 600),
                      type: PageTransitionType.rightToLeft,
                      child: const LabList()));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   'View All',
                //   style: primaryColorNormalBoldTextStyle,
                // ),
                // SizedBox(width: 5.0),
                // Icon(
                //   Icons.arrow_forward_ios,
                //   size: 16.0,
                //   color: blackColor,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Select City Start Here
  void _selectCityBottomSheet() {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Choose City',
                            textAlign: TextAlign.center,
                            style: blackHeadingTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Delhi';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: const EdgeInsets.all(10.0),
                            child: const Text('Gurgoan'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Noida';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: const EdgeInsets.all(10.0),
                            child: const Text('Banglore'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Hisar';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: const EdgeInsets.all(10.0),
                            child: const Text('Jaipur'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
// Bottom Sheet for Select City Ends Here
}
