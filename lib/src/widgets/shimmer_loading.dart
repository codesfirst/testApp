import 'package:flutter/material.dart';
import 'package:flutter_testapp/src/utils/colors.dart';
import 'package:flutter_testapp/src/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class SimmerLoading extends StatelessWidget {
  final double height;
  final Axis axis;
  final int itemCount;
  final bool shrinkWrap;
  final Color? highlightColor;
  final Color? baseColor;

  const SimmerLoading({Key? key, 
    required  this.height, 
    this.highlightColor,
    this.baseColor,
    this.axis = Axis.vertical, 
    this.itemCount = 5, 
    this.shrinkWrap = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
          shrinkWrap: shrinkWrap,
          itemBuilder: (BuildContext context, int index){
            return Shimmer.fromColors(
              highlightColor: highlightColor != null ? highlightColor! : TestColor.fromHex(TestColor.CelesteLight),
              baseColor: baseColor !=null ? baseColor! : TestColor.fromHex(TestColor.CelesteDark),
              child: Column(
                children: [
                  Container(
                    height: height,
                    padding: EdgeInsets.symmetric(horizontal: Responsive.of(context).dp(1.5), vertical: Responsive.of(context).dp(1)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Responsive.of(context).dp(1)),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: Responsive.of(context).dp(2),),
                ],
              )
            );
          },
          scrollDirection: axis,
          itemCount: itemCount,
        ),
      );
  }
}