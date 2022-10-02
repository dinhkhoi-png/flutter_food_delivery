import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double height;
  double size;

  SmallText({Key? key,this.color = const Color(0xFFccc7c5),
    this.height = 1.2, required this.text,this.size=0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      style: TextStyle(
          fontFamily: "Nunito",
          fontSize: size==0?Dimensions.font14:size  ,
          height: height
      ),
    );
  }
}
