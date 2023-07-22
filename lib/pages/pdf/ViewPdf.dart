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
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dmt/pages/util/ApiUrl.dart';

class ViewPdf extends StatefulWidget {
  final String pdfurl;

// In the constructor, require a pdfurl
  const ViewPdf({Key? key, required this.pdfurl}) : super(key: key);

  @override
  _LocalPdfViewPageState createState() => _LocalPdfViewPageState(pdfurl);
}

class _LocalPdfViewPageState extends State<ViewPdf> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final String pdfurl;

  _LocalPdfViewPageState(this.pdfurl);

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      // WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View PDf Document'),
        actions: <Widget>[],
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: SfPdfViewer.network(
              //'https://dm.ajeetwork.xyz/storage/app/public/files/xPAOa40qgXk8vOtMmHKy2mUWcNV0zEiQL65OaDsK.pdf',
              pdfurl,
              key: _pdfViewerKey,
              canShowPaginationDialog: false)),
    );
  }
}
