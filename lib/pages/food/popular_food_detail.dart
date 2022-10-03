import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widget/app_icon.dart';
import 'package:flutter_food_delivery/widget/expandable_text_widget.dart';

import '../../utils/colors.dart';
import '../../widget/app_column.dart';
import '../../widget/big_text.dart';
import '../../widget/icon_and_text_widget.dart';
import '../../widget/small_text.dart';
import 'package:get/get.dart';

import '../home/main_food_page.dart';
class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    //print("pageId"+pageId.toString());
    //print("product"+product.name.toString());
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
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
                    image:NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
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
                GestureDetector(
                    onTap:(){
                      Get.to(()=>MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)
                ),
                GetBuilder<PopularProductController>(
                    builder: (controller){
                      return Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined,),
                          Get.find<PopularProductController>().totalItems >=1?
                          Positioned(
                              right:0,
                              top: 0,
                              child: GestureDetector(
                                onTap:(){
                                  Get.to(()=>CartPage());
                      },
                                  child: AppIcon(icon: Icons.circle,size: 20, iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,))):
                            Container(),
                          Get.find<PopularProductController>().totalItems >=1?
                          Positioned(
                              right:3.5,
                              top: 3.5,
                              child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),size: Dimensions.font12,color: Colors.white,),
                          ):
                          Container()
                        ],
                      );
                    })
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
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduct"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!,)))

                  ],
                ),

          ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct){
          return Container(
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
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(Icons.remove,color: AppColors.signColor,)),
                      SizedBox(width: Dimensions.width10,),
                      BigText(text: popularProduct.inCarItems.toString()),
                      SizedBox(width: Dimensions.width10,),
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add,color: AppColors.signColor,)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                        child: BigText(text: "\$ ${product.price!} | Add to cart",),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
