import 'dart:io';

import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dmt/pages/comment/localpdfcomment.dart';
import 'package:dmt/pages/doctor/doctor_list.dart';
import 'package:dmt/pages/doctor/final_comment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:dmt/utils/ApiHelper.dart';
import 'package:dmt/pages/screens.dart';
import 'package:dmt/pages/util/ApiUrl.dart';

class ViewImage extends StatefulWidget {
  final String pdfurl;

// In the constructor, require a pdfurl
  const ViewImage({Key? key, required this.pdfurl}) : super(key: key);

  @override
  _LocalPdfViewPageState createState() => _LocalPdfViewPageState(pdfurl);
}

class _LocalPdfViewPageState extends State<ViewImage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final String pdfurl;

  _LocalPdfViewPageState(this.pdfurl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Document'),
        actions: <Widget>[],
      ),
      // body: PdfView(path: pdfurl)
      body: Container(
        width: MediaQuery.of(context).size.width,
        //height: 46.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            // image: AssetImage('assets/icon.png'),
            image: NetworkImage(pdfurl.replaceAll(' ', '')),
            //profilePic
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      // body: Image.network(
      //     pdfurl
      // );
    );
  }
}
