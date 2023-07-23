import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:dmt/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:dmt/pages/chat/DownloadingDialog.dart';
import 'package:dmt/pages/chat/api/chat_api_service.dart';
import 'package:dmt/pages/chat/model/ChatBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String conversionType;

  const ChatScreen({Key? key, required this.name, required this.conversionType})
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Timer timer;
  final msgController = TextEditingController();

  late ScrollController _scrollController;
  var chatApiService = ChatApiService();
  var messageChatList = <Messages>[];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _getMessages();
    _callGetMessageApiPeriodically();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    msgController.dispose();
    timer.cancel();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(const Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  var file;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 1.0,
        title: Text(
          widget.name,
          style: appBarTitleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 70.0,
            ),
            child: messageChatList.isNotEmpty
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    controller: _scrollController,
                    child: Column(children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: messageChatList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = messageChatList[index];
                          final isSenderAdminOrMaintainer =
                              (item.senderId == '1' || item.senderId == '2');
                          final isRead = item.read == 1;
                          final DateTime givenTime =
                              DateTime.parse(item.createdAt!).toLocal();
                          final DateTime currentTime = DateTime.now();
                          final DateFormat formatter =
                              (currentTime.day == givenTime.day &&
                                      currentTime.month == givenTime.month &&
                                      currentTime.year == givenTime.year)
                                  ? DateFormat('hh:mm aa')
                                  : DateFormat(
                                      'dd-MMM-yyyy hh:mm aa',
                                    );
                          final String formattedTime =
                              formatter.format(givenTime);
                          if (index == 0) {
                            _scrollToBottom();
                          }
                          return SizedBox(
                            width: width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: isSenderAdminOrMaintainer
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding: isSenderAdminOrMaintainer
                                          ? const EdgeInsets.only(right: 100.0)
                                          : const EdgeInsets.only(left: 100.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            isSenderAdminOrMaintainer
                                                ? CrossAxisAlignment.start
                                                : CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(fixPadding),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: fixPadding),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  isSenderAdminOrMaintainer
                                                      ? const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5.0),
                                                        )
                                                      : const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0.0),
                                                        ),
                                              color: isSenderAdminOrMaintainer
                                                  ? Colors.grey[300]
                                                  : primaryColor,
                                            ),
                                            child: item.doc != null &&
                                                    item.doc != ""
                                                ? item.doc?.split(".")[1] ==
                                                        "pdf"
                                                    ? InkWell(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //       builder:
                                                          //           (context) =>
                                                          //               OpenPDF(
                                                          //                 file: item
                                                          //                         .doc ??
                                                          //                     '',
                                                          //               )),
                                                          // );
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                DownloadingDialog(
                                                                    url:
                                                                        item.doc ??
                                                                            ""),
                                                          );
                                                        },
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                item.doc ?? '',
                                                                style: isSenderAdminOrMaintainer
                                                                    ? blackNormalTextStyle
                                                                    : whiteColorNormalTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                item.body ?? '',
                                                                style: isSenderAdminOrMaintainer
                                                                    ? blackNormalTextStyle
                                                                    : whiteColorNormalTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                DownloadingDialog(
                                                                    url:
                                                                        item.doc ??
                                                                            ""),
                                                          );
                                                        },
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Image.network(
                                                                "https://dmtransport.ca/app/storage/docs/${item.doc}",
                                                                height: 250,
                                                                width: 250,
                                                              ),
                                                              Text(
                                                                item.body ?? '',
                                                                style: isSenderAdminOrMaintainer
                                                                    ? blackNormalTextStyle
                                                                    : whiteColorNormalTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                : Text(
                                                    item.body ?? '',
                                                    style: isSenderAdminOrMaintainer
                                                        ? blackNormalTextStyle
                                                        : whiteColorNormalTextStyle,
                                                  ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  isSenderAdminOrMaintainer
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                isSenderAdminOrMaintainer
                                                    ? Container()
                                                    : Icon(
                                                        isRead
                                                            ? Icons.done_all
                                                            : Icons.check,
                                                        color:
                                                            Colors.blueAccent,
                                                        size: 14.0,
                                                      ),
                                                const SizedBox(
                                                  width: 7.0,
                                                ),
                                                Text(
                                                  formattedTime,
                                                  style: greySmallTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ]))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: greyColor,
                          size: 70.0,
                        ),
                        heightSpace,
                        Text(
                          'No Messages',
                          style: greyNormalTextStyle,
                        ),
                      ],
                    ),
                  ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              file != null ? Text(file.name) : const SizedBox(),
              Container(
                width: width,
                height: 70.0,
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
                        );
                        if (result == null) return;
                        setState(() {
                          file = result.files.single;
                        });
                        print("FILLEEEEEEE");
                        print(file);
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: greyColor.withOpacity(0.40),
                        ),
                        child: Icon(
                          Icons.attachment_sharp,
                          color: primaryColor,
                          size: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Image.file(),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: primaryColor,
                        ),
                        child: TextField(
                          controller: msgController,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                          ),
                          cursorColor: whiteColor,
                          decoration: InputDecoration(
                            hintText: 'Type a Message',
                            hintStyle: whiteColorSmallTextStyle,
                            contentPadding: const EdgeInsets.only(left: 10.0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () async {
                        if (msgController.text != '' || file != null) {
                          var prefs = await SharedPreferences.getInstance();
                          var token = (prefs.getString('token') ?? "");

                          if (file == null) {
                            chatApiService.sendMessage({
                              "message": msgController.text.toString(),
                              "token": token ?? '',
                              "coversation_type": widget.conversionType,
                            });
                          } else {
                            print("object");
                            chatApiService.sendMessage({
                              "message": msgController.text != ''
                                  ? msgController.text.toString()
                                  : ".",
                              "token": token ?? '',
                              "coversation_type": widget.conversionType,
                              "doc": file.path
                            });
                          }

                          // messageChatList
                          setState(() {
                            msgController.text = '';
                            file = null;
                            _scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          });
                        }
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: greyColor.withOpacity(0.40),
                        ),
                        child: Icon(
                          Icons.send,
                          color: primaryColor,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _getMessages() async {
    var prefs = await SharedPreferences.getInstance();
    var token =
        (prefs.getString('token') ?? "");
    var chatBean = await chatApiService.getMessages(
        {"token": token ?? '', "coversation_type": widget.conversionType});
    setState(() {
      messageChatList.clear();
      for (int i = chatBean.messages!.length - 1; i >= 0; i--) {
        var message = chatBean.messages![i];
        messageChatList.add(message);
      }
    });
  }

  void _callGetMessageApiPeriodically() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _getMessages();
    });
  }
}
