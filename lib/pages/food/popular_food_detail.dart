import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widget/app_icon.dart';
import 'package:flutter_food_delivery/widget/expandable_text_widget.dart';

import '../../utils/colors.dart';
import '../../widget/app_column.dart';
import '../../widget/big_text.dart';
import '../../widget/icon_and_text_widget.dart';
import '../../widget/small_text.dart';
class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
              right: 0,
              child: Container(
              width: double.maxFinite,
                height: Dimensions.popularFoodImg,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/image/food0.png"
                    )
                  )
                ),
          )),
          Positioned(
            left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                AppIcon(icon: Icons.arrow_back_ios),
              AppIcon(icon: Icons.shopping_cart_outlined,),
            ],
          )),
          Positioned(
            left: 0,
              right: 0,
              bottom: 0,
              top:Dimensions.popularFoodImg-20,
              child: Container(

                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    ),

                    color: Colors.white
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: "Chinese Side",),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduct"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: "Phở Dù giá rẻ nhưng ngon số 1. "
                            "Danh sách các món ăn Việt Nam sẽ không được hoàn thiện mà không "
                            "có phở. Bạn gần như có thể đi dạo khắp các thành phố lớn ở Việt Nam "
                            "và bắt gặp cảnh những đám đông đang xì xụp vây quanh một hàng phở nóng sốt, "
                            "thậm chí ngồi ngay trên vỉa hè. Món ăn ngon lành này gồm các nguyên liệu rất "
                            "đơn giản như: nước dùng, mì gạo tươi, rắc các loại thảo mộc và thịt gà hoặc thịt bò.",)))

                  ],
                ),

          ))
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeight,
        padding: EdgeInsets.only(top: Dimensions.height30,bottom:Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20 ),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20*2),
            topRight: Radius.circular(Dimensions.radius20*2),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.remove,color: AppColors.signColor,),
                  SizedBox(width: Dimensions.width10,),
                  BigText(text: "0"),
                  SizedBox(width: Dimensions.width10,),
                  Icon(Icons.add,color: AppColors.signColor,),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

              child: BigText(text: "10 \$ | Add to cart",),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
