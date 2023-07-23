import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

final PdfViewerController _pdfViewerController=PdfViewerController();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Syncfusion Flutter PDF Viewer'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.white,
          ),
          onPressed: () {
            _pdfViewerController.jumpToPage(3);
            print( _pdfViewerController.scrollOffset.dy);
            print( _pdfViewerController.scrollOffset.dx);
          },
        ),
      ],
    ),
    body: SfPdfViewer.network(
      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      controller: _pdfViewerController,
    ),
  );
}