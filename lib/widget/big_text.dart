import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow; //tràn văn bản
  BigText({Key? key,this.color = const Color(0xFF332d2b), required this.text,this.size=0,
    this.overflow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          fontFamily: "Nunito",
          fontSize: size==0?Dimensions.font20:size,
          color: color , fontWeight: FontWeight.w400),
    );
  }
}
