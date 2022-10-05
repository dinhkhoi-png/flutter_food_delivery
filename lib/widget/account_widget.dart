import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import '../utils/dimensions.dart';

import 'app_icon.dart';
import 'big_text.dart';
class AccountWidget extends StatelessWidget {

  AppIcon appIcon;
  BigText bigText;

  AccountWidget({Key? key , required this.appIcon , required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20,

          top: Dimensions.width20,
          bottom: Dimensions.width15),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.height20,),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: const Offset(0,2),
              color: Colors.grey.withOpacity(0.2),
            )
          ]
      ),
    );
  }
}
