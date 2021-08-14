import 'package:flutter/material.dart';
import 'package:flutter_testapp/src/utils/responsive.dart';
import 'package:flutter_testapp/src/widgets/text_widget.dart';

class TestDialog {
  BuildContext buildContext;

  static TestDialog of(BuildContext context) => TestDialog(buildContext: context);

  TestDialog({required this.buildContext});

  void infoDialog({required String title, required String description, required Function() func}){
    showDialog(
      context: buildContext,
      builder: (ctx){
        return AlertDialog(
          title: Icon(Icons.info_outline, color: Theme.of(ctx).accentColor),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  text: title,
                  color: Theme.of(buildContext).primaryColor,
                  fontSize: Responsive.of(buildContext).dp(2),
                  fontWeight: FontWeight.bold,
                ),
                TextWidget(
                  text: description,
                  color: Theme.of(buildContext).primaryColor,
                  fontSize: Responsive.of(buildContext).dp(2),
                  fontWeight: FontWeight.normal,
                ),
                MaterialButton(onPressed: func, textColor: Colors.blue, child: Text("OK"),)
              ],
            ),
          ),
        );
      }
    );
  }


}