import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoadingData extends StatelessWidget {
  final String textLoading;
  const LoadingData({Key? key, this.textLoading = "Cargando..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Dialog(
        child: Container(
          margin: EdgeInsets.all(8.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 6.0,),
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),
                  SizedBox(width: 26.0,),
                  Text(
                    textLoading,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}