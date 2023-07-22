import 'package:flutter/material.dart';


Future<void> showAlertDialog(BuildContext context, String textToShow,
    {String? title}) async {
  Widget text = SimpleDialogOption(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(textToShow),
    ),
  );

  // set up the SimpleDialog
  final dialog = AlertDialog(
    title: title != null ? Text(title) : null,
    content: text,
    contentPadding: const EdgeInsets.all(0),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('OK'),
      ),
    ],
  );

  // show the dialog
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}




