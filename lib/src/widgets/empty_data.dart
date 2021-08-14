import 'package:flutter/material.dart';
import 'package:flutter_testapp/src/utils/responsive.dart';
import 'package:flutter_testapp/src/widgets/text_widget.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Responsive.of(context).hp(5)),
      child: Center(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height:  Responsive.of(context).hp(10),
                  child: Icon(Icons.hourglass_empty_outlined,)
                ),
                SizedBox(height: 10,),
                TextWidget(
                  text: "No hay Equipos disponibles",
                  fontSize: Responsive.of(context).dp(2),
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
        ),
      ),
  );
  }
}