import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.manageExternalStorage,
      //add more permission to request here.
    ].request();

    if (Platform.isAndroid) {
      if (status[Permission.manageExternalStorage]!.isGranted) {
        Directory? directory = await getExternalStorageDirectory();
        String newPath = "";
        print(directory);
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/DMTransport";
        directory = Directory(newPath);
        String url = "https://dmtransport.ca/app/storage/docs/${widget.url}";
        String fileName = widget.url;

        String savePath = "${directory.path}/$fileName";
        print(savePath);

        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        if (await directory.exists()) {
          await dio.download(
            url,
            savePath,
            onReceiveProgress: (recivedBytes, totalBytes) {
              setState(() {
                progress = recivedBytes / totalBytes;
              });

              print(progress);
            },
            deleteOnError: true,
          ).then((_) {
            Navigator.pop(context);
          });
        }
      }
    } else {
      // await ImageGallerySaver.saveFile(saveFile.path,
      //       isReturnPathOfIOS: true);
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
