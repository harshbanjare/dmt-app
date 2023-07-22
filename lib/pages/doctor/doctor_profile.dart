import 'package:dmt/constant/constant.dart';
import 'package:dmt/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dmt/pages/screens.dart';

class DoctorProfile extends StatefulWidget {
  final String doctorImage, doctorName, doctorType, experience;

  const DoctorProfile(
      {required this.doctorImage,
      required this.doctorName,
      required this.doctorType,
      required this.experience});
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  // late Set<Marker> markers;

  final ratingList = [
    {
      'name': 'Ersel',
      'image': 'assets/user/user_1.jpg',
      'rating': 5,
      'review': 'Really good doctor.',
      'time': 'August 2020'
    },
    {
      'name': 'Jane',
      'image': 'assets/user/user_2.jpg',
      'rating': 5,
      'review': 'Great doctor i have ever seen.',
      'time': 'August 2020'
    },
    {
      'name': 'Apollonia',
      'image': 'assets/user/user_3.jpg',
      'rating': 5,
      'review': 'Excellent.',
      'time': 'July 2020'
    },
    {
      'name': 'Beatriz',
      'image': 'assets/user/user_4.jpg',
      'rating': 5,
      'review': 'Really nice!',
      'time': 'June 2020'
    },
    {
      'name': 'Linnea',
      'image': 'assets/user/user_5.jpg',
      'rating': 5,
      'review': 'Nice experience.',
      'time': 'May 2020'
    },
    {
      'name': 'Ronan',
      'image': 'assets/user/user_6.jpg',
      'rating': 5,
      'review': 'Fantastic.',
      'time': 'April 2020'
    },
    {
      'name': 'Brayden',
      'image': 'assets/user/user_7.jpg',
      'rating': 5,
      'review': 'Very experienced. doctor',
      'time': 'Fabruary 2020'
    },
    {
      'name': 'Hugo',
      'image': 'assets/user/user_8.jpg',
      'rating': 5,
      'review': 'Good.',
      'time': 'January 2020'
    }
  ];

  @override
  void initState() {
    super.initState();
    // markers = Set.from([]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: (height * 0.36),
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: (width - fixPadding * 11.0) / 2.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorName,
                        style: whiteColorHeadingTextStyle,
                      ),
                      heightSpace,
                      Text(
                        widget.doctorType,
                        style: whiteColorSmallTextStyle,
                      ),
                      heightSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.lime, size: 20.0),
                          SizedBox(width: 5.0),
                          Text(
                            '4.5 Rating',
                            style: whiteColorNormalTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Hero(
                  tag: widget.doctorImage,
                  child: Image.asset(
                    widget.doctorImage,
                    width: (width) / 2.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 1.0,
            builder: (BuildContext context, myscrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                child: Container(
                  color: whiteColor,
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: ListView(
                    controller: myscrollController,
                    children: [
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        style: greyNormalTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                      heightSpace,
                      heightSpace,
                      experience(),
                      heightSpace,
                      heightSpace,
                      availability(),
                      heightSpace,
                      heightSpace,
                      location(),
                      heightSpace,
                      heightSpace,
                      review(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  experience() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Text(
          '${widget.experience} Years',
          style: greyNormalTextStyle,
        ),
      ],
    );
  }

  availability() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Text(
          '8:00 AM - 10:30 PM',
          style: greyNormalTextStyle,
        ),
      ],
    );
  }

  location() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          height: 250.0,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 1.0,
                spreadRadius: 1.0,
                color: (Colors.grey[300])!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  review() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        ColumnBuilder(
          textDirection: TextDirection.ltr,
          itemCount: 3,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          itemBuilder: (context, index) {
            final item = ratingList[index];
            return Container(
              margin: (index == 0)
                  ? EdgeInsets.symmetric(horizontal: 2.0)
                  : EdgeInsets.only(
                      top: fixPadding * 2.0, right: 2.0, left: 2.0),
              padding: EdgeInsets.all(fixPadding * 2.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    color: (Colors.grey[300])!,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          image: DecorationImage(
                            image: AssetImage(item['image'].toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'].toString(),
                              style: blackNormalBoldTextStyle,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              item['time'].toString(),
                              style: greySmallTextStyle,
                            ),
                            SizedBox(height: 5.0),
                            ratingBar(item['rating']),
                          ],
                        ),
                      ),
                    ],
                  ),
                  heightSpace,
                  Text(
                    item['review'].toString(),
                    style: blackNormalTextStyle,
                  ),
                ],
              ),
            );
          },
        ),
        heightSpace,
        heightSpace,
        InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 600),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: Review(
                      reviewList: ratingList,
                    )));
          },
          child: Container(
            padding: EdgeInsets.all(fixPadding * 1.5),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1.0, color: primaryColor),
            ),
            child: Text(
              'Show all reviews',
              style: primaryColorsmallBoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  ratingBar(number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1 Star
        Icon(
          (number == 1 ||
                  number == 2 ||
                  number == 3 ||
                  number == 4 ||
                  number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 2 Star
        Icon(
          (number == 2 || number == 3 || number == 4 || number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 3 Star
        Icon(
          (number == 3 || number == 4 || number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 4 Star
        Icon(
          (number == 4 || number == 5) ? Icons.star : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 5 Star
        Icon(
          (number == 5) ? Icons.star : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),
      ],
    );
  }
}
