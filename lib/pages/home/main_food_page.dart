import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/widget/big_text.dart';
import 'package:flutter_food_delivery/widget/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/dimensions.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void>_loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    //print("current height" + MediaQuery.of(context).size.height.toString());
    return RefreshIndicator(child: Column(
      children: [
        Container(

          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "HO CHI MINH",
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: "quan 1",
                          color: AppColors.mainBlackColor,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.mainBlackColor,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: Dimensions.height45,
                  width: Dimensions.height45,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height15),
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
      ],
    ), onRefresh: _loadResource);

  }
}
