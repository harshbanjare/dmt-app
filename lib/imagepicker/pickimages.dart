import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/profile/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'image_comment.dart';

class PickImagePage extends StatefulWidget {
  @override
  _PickImagePageState createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  /// Variables
  File? imageFile;
  final ButtonStyle style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    alignment: Alignment.center,
    textStyle: const TextStyle(
      // fontSize: 16,
      color: Colors.black,
    ),
  );

  List<File> selectedImages = []; // List of selected image
  final picker = ImagePicker(); // Instance of Image picker

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Image"),
      ),
      body: Container(
        child: ListView(
          children: [
            heightSpace,
            profile_box(),
            Expanded(
              child: SizedBox(
                width: 300.0,
                height: 400.0,
                child: selectedImages.isEmpty
                    ? const Center(child: Text('Sorry nothing selected!!'))
                    : GridView.builder(
                        itemCount: selectedImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: kIsWeb
                                  ? Image.network(selectedImages[index].path)
                                  : Image.file(selectedImages[index]));
                        },
                      ),
              ),
            ),
            !selectedImages.isEmpty
                ? ElevatedButton(
                    style: style,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: const Duration(milliseconds: 800),
                          type: PageTransitionType.fade,
                          child: ImageCommentPage(
                              imageFiles: selectedImages, type: 'load'),
                        ),
                      );
                    },
                    child: const Text('Ready to Upload'),
                  )
                : const SizedBox(),
            heightSpace,
            // profile_box2(),
            heightSpace,
            heightSpace,
            heightSpace,
          ],
        ),
      ),
    );
  }

  profile_box() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: Profile()));
      },
      child: Container(
        margin: EdgeInsets.all(fixPadding * 2.0),
        padding: EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widthSpace,
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                image: const DecorationImage(
                  image: AssetImage('assets/user/gallery.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: style,
                onPressed: () async {
                  // _getFromGallery();
                  _getMultiImages();
                  // await picker.pickMultiImage();
                },
                child: const Text(
                  'PICK FROM GALLERY',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  profile_box2() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: Profile()));
      },
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    // PickedFile? pickedFile = await ImagePicker().pickImage(
    // PickedFile? pickedFile = await ImagePicker().getImage(
    //     source: ImageSource.gallery,
    //     // maxWidth: 1800,
    //     // maxHeight: 1800,
    //     imageQuality: 70);
    // if (pickedFile != null) {
    //   setState(() {
    //     imageFile = File(pickedFile.path);
    //   });
    // }
  }

  Future _getMultiImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  /// Get from Camera
  _getFromCamera() async {
    // PickedFile? pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.camera,
    //   maxWidth: 1800,
    //   maxHeight: 1800,
    // );
    // if (pickedFile != null) {
    //   setState(() {
    //     imageFile = File(pickedFile.path);
    //   });
    // }
  }
}
