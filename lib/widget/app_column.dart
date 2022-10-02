import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/widget/small_text.dart';


import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';
class AppColumn extends StatelessWidget {
  final String text;
  AppColumn({Key? key ,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text , size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(Icons.star , color: AppColors.mainColor,);
              }),

            ),
            SizedBox(width: 6),
            SmallText(text: "5.0"),
            SizedBox(width: 6),
            SmallText(text: "1278"),
            SizedBox(width: 6),
            SmallText(text:"Comment"),
          ],
        ),
        SizedBox(height: Dimensions.height10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1
            ),
            SizedBox(width: Dimensions.width10,),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7 km",
                iconColor: AppColors.mainColor
            ),
            SizedBox(width: Dimensions.width10,),
            IconAndTextWidget(
                icon: Icons.watch_later_outlined,
                text: "32 min",
                iconColor: AppColors.iconColor2
            ),
          ],
        )
      ],
    );

  }
}
