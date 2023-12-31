import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ShowConfirmDilogbox(BuildContext context, String title, String content) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Confirmation"),
            content: Text(content),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text("Yes"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No"),
              )
            ],
          ));
}
