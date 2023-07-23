import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
        title: const Text('View PDf Document'),
        actions: const <Widget>[],
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: SfPdfViewer.network(
              //'https://dm.ajeetwork.xyz/storage/app/public/files/xPAOa40qgXk8vOtMmHKy2mUWcNV0zEiQL65OaDsK.pdf',
              pdfurl,
              key: _pdfViewerKey,
              canShowPaginationDialog: false)),
    );
  }
}
