// main.dart
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
import 'package:dmt/imagepicker/image_comment.dart';

class LocalPdfViewPage extends StatefulWidget {
  final String pdfurl;
  final String type;

// In the constructor, require a pdfurl
  const LocalPdfViewPage({Key? key, required this.pdfurl, required this.type})
      : super(key: key);

  @override
  _LocalPdfViewPageState createState() => _LocalPdfViewPageState(pdfurl);
}

class _LocalPdfViewPageState extends State<LocalPdfViewPage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final String pdfurl;
  _LocalPdfViewPageState(this.pdfurl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PDF View'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.upload_file,
                color: Colors.white,
              ),
              onPressed: () {
                uploadPdf(context);
              },
            ),
          ],
        ),
        body: PdfView(path: pdfurl)
        // body: SfPdfViewer.network(
        //   widget.pdfurl,
        //   controller: _pdfViewerController,
        // ),
        );
  }

  Future uploadPdf(context) async {
    var type = widget.type.toString();
    print(' :::::::::::::::::::: --- ' + pdfurl);
    Navigator.push(
        context,
        PageTransition(
            duration: Duration(milliseconds: 600),
            type: PageTransitionType.fade,
            child: ImageCommentPage(new File(pdfurl), type)));
  }
}
