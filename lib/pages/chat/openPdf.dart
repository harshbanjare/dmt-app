import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import 'package:flutter/material.dart';

class OpenPDF extends StatefulWidget {
  const OpenPDF({Key? key, required this.file}) : super(key: key);
  final String file;

  @override
  State<OpenPDF> createState() => _OpenPDFState();
}

class _OpenPDFState extends State<OpenPDF> {
  bool _isLoading = true;
  late PDFDocument document;

  loadDocument() async {
    document = await PDFDocument.fromURL(
        // "https://dmtransport.in/storage/docs/e56659fefb776e64aaa7a8fa92ec6ffa.pdf"
        "https://dmtransport.in/storage/docs/${widget.file}");

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                )),
    ));
  }
}
