
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
        title: const Text('View Document'),
        actions: const <Widget>[],
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
