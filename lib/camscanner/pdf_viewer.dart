// main.dart
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dmt/pages/doctor/doctor_list.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// void main() {
//   runApp(PdfView(pdfurl!));
// }
//  String? pdfurl='https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';

// class PdfView extends StatelessWidget {
//
//
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Remove the debug banner
//         debugShowCheckedModeBanner: false,
//         title: 'Pdf Viewer',
//         theme: ThemeData(
//           primarySwatch: Colors.indigo,
//         ),
//         home: PdfViewPage(pdfurl!));
//   }
// }

class PdfViewPage extends StatefulWidget {
  final String pdfurl;

// In the constructor, require a pdfurl
  const PdfViewPage({Key? key, required this.pdfurl}) : super(key: key);

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

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
              // _pdfViewerController.jumpToPage(3);
              // print( _pdfViewerController.scrollOffset.dy);
              // print( _pdfViewerController.scrollOffset.dx);
              // print(widget.pdfurl);

              Fluttertoast.showToast(
                  msg: "Working" + widget.pdfurl,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              print(widget.pdfurl);
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: DoctorList(
                    doctorType: 'Upload PDF',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfurl,
        controller: _pdfViewerController,
      ),
    );
  }
}
