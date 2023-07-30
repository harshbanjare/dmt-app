import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dmt/constant/constant.dart';
import 'package:dmt/pages/profile/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'image_comment.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key});

  @override
  PickImagePageState createState() => PickImagePageState();
}

class PickImagePageState extends State<PickImagePage> {
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

  void _pickFromGallery() {
    picker
        .pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    )
        .then((pickedFiles) {
      setState(
        () {
          if (pickedFiles.isNotEmpty) {
            for (var i = 0; i < pickedFiles.length; i++) {
              selectedImages.add(File(pickedFiles[i].path));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nothing is selected')));
          }
        },
      );
    });
  }

  void _pickFromCamera() {
    picker.pickImage(source: ImageSource.camera).then((pickedFile) {
      setState(
        () {
          if (pickedFile != null) {
            selectedImages.add(File(pickedFile.path));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nothing is selected')));
          }
        },
      );
    });
  }

  profileBox() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 400),
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: const Profile(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/user/gallery.png',
              width: 150.0,
              height: 150.0,
            ),
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    style: style,
                    onPressed: _pickFromGallery,
                    child: const Text(
                      'Pick from gallery',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: _pickFromCamera,
                    child: const Text(
                      'Pick from camera',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Image"),
      ),
      body: ListView(
        children: [
          heightSpace,
          profileBox(),
          SizedBox(
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
          selectedImages.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
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
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
