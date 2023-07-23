import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 1.0,
        title: Text(
          'About Us',
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0,
            ),
            child: Text(
              'Welcome to the DM Transport, we are a complete supply chain network who are fired & geared up to provide you with the customised logistics solutions per your requirements.DM Transport is making a headway in providing innovative freight solutions and taking utmost care when it comes to transportation of your goods. As we understand that while moving your goods there is quite a lot of sentimental value stringed to it. So we deal with the logistic needs very efficiently. We have a wide network to provide our clients with flawless logistic services across North America and along with assuring the most competitive pricing. Our services cover an array of requirements like temperature controlled transfers, flatbed trucking services, less-than-truckload (LTL) and truckload (TL) shipping needs. Our team who has accrued the freight industry knowledge over the years is dedicated to delivering you the most efficient and professional freight services.',
              style: blackNormalTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0,
            ),
            // child: Text(
            //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            //   style: blackNormalTextStyle,
            //   textAlign: TextAlign.justify,
            // ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0,
            ),
            // child: Text(
            //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            //   style: blackNormalTextStyle,
            //   textAlign: TextAlign.justify,
            // ),
          ),
        ],
      ),
    );
  }
}
