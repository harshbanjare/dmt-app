import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final activeAppoinmentList = [
    {
      'doctorName': 'Loren & Turbo',
      'date': '15 Oct 2020',
      'time': '10:00 AM',
      'doctorType': 'Package Delivery',
    },
    {
      'doctorName': 'Relinece Fresh Vegi Delivery',
      'date': '18 Oct 2020',
      'time': '12:30 PM',
      'doctorType': 'Package Delivery',
    },
    {
      'doctorName': 'Vikas General Store',
      'date': '22 Oct 2020',
      'time': '6:00 PM',
      'doctorType': 'Package Delivery',
    }
  ];

  final pastAppoinmentList = [
    {
      'doctorName': 'Loren & Turbo',
      'date': '15 Oct 2020',
      'time': '10:00 AM',
      'doctorType': 'Package Delivery',
    },
    {
      'doctorName': 'Relinece Fresh Vegi Delivery',
      'date': '18 Oct 2020',
      'time': '12:30 PM',
      'doctorType': 'Package Delivery',
    },
    {
      'doctorName': 'Vikas General Store',
      'date': '22 Oct 2020',
      'time': '6:00 PM',
      'doctorType': 'Package Delivery',
    },
    {
      'doctorName': 'Loren & Turbo',
      'date': '15 Oct 2020',
      'time': '10:00 AM',
      'doctorType': 'Package Delivery',
    },
    {
      'doctorName': 'Relinece Fresh Vegi Delivery',
      'date': '18 Oct 2020',
      'time': '12:30 PM',
      'doctorType': 'Package Delivery',
    },
    {
      'doctorName': 'Vikas General Store',
      'date': '22 Oct 2020',
      'time': '6:00 PM',
      'doctorType': 'Package Delivery',
    }
  ];

  final cancelledAppoinmentList = [
    {
      'doctorName': 'Loren & Turbo',
      'date': '15 Oct 2020',
      'time': '10:00 AM',
      'doctorType': 'Package Delivery',
    },
  ];

  deleteAppointmentDialog(index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Are you sure you want to cancel this appointment?",
                      style: blackNormalTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'No',
                              style: primaryColorButtonTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              activeAppoinmentList.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Yes',
                              style: whiteColorButtonTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.0,
          automaticallyImplyLeading: false,
          title: Text(
            'Orders Details',
            style: appBarTitleTextStyle,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: tabItem('Active', activeAppoinmentList.length),
              ),
              Tab(
                child: tabItem('Completed', pastAppoinmentList.length),
              ),
              Tab(
                child: tabItem('Cancelled', cancelledAppoinmentList.length),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            activeAppointment(),
            pastAppointment(),
            cancelledAppointment(),
          ],
        ),
      ),
    );
  }

  tabItem(text, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: blackSmallTextStyle,
        ),
        const SizedBox(width: 4.0),
        Container(
          width: 20.0,
          height: 20.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: whiteColor,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  activeAppointment() {
    return (activeAppoinmentList.isEmpty)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: greyColor,
                  size: 70.0,
                ),
                heightSpace,
                Text(
                  'No Active Appointments',
                  style: greyNormalTextStyle,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: activeAppoinmentList.length,
            itemBuilder: (context, index) {
              final item = activeAppoinmentList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: Colors.green),
                            color: Colors.green[50],
                          ),
                          child: Text(
                            item['date']!,
                            textAlign: TextAlign.center,
                            style: greenColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item['time']!,
                                    style: blackHeadingTextStyle,
                                  ),
                                  InkWell(
                                    onTap: () => deleteAppointmentDialog(index),
                                    child: const Icon(
                                      Icons.close,
                                      size: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                'Dr. ${item['doctorName']}',
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                '${item['doctorType']}',
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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

  pastAppointment() {
    return (pastAppoinmentList.isEmpty)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: greyColor,
                  size: 70.0,
                ),
                heightSpace,
                Text(
                  'No Past Appointments',
                  style: greyNormalTextStyle,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: pastAppoinmentList.length,
            itemBuilder: (context, index) {
              final item = pastAppoinmentList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: primaryColor),
                            color: primaryColor.withOpacity(0.15),
                          ),
                          child: Text(
                            item['date']!,
                            textAlign: TextAlign.center,
                            style: primaryColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['time']!,
                                style: blackHeadingTextStyle,
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                'Dr. ${item['doctorName']}',
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                '${item['doctorType']}',
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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

  cancelledAppointment() {
    return (cancelledAppoinmentList.isEmpty)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: greyColor,
                  size: 70.0,
                ),
                heightSpace,
                Text(
                  'No Cancelled Appointments',
                  style: greyNormalTextStyle,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: cancelledAppoinmentList.length,
            itemBuilder: (context, index) {
              final item = cancelledAppoinmentList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: Colors.red),
                            color: Colors.red[50],
                          ),
                          child: Text(
                            item['date']!,
                            textAlign: TextAlign.center,
                            style: redColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['time']!,
                                style: blackHeadingTextStyle,
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                'Dr. ${item['doctorName']}',
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                '${item['doctorType']}',
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
  }
}
