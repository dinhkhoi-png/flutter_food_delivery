import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widget/app_icon.dart';
import 'package:flutter_food_delivery/widget/big_text.dart';
import 'package:get/get.dart';
class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();

    Map<String, int> cartItemsPerOrder = Map();
    for(int i=0 ; i < getCartHistoryList.length ; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!,(value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }
    List<int> cartItemsOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=> e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }
    List<int> itemsPerOrder =  cartItemsOrderTimeToList();

    var listCouter = 0;


    return Scaffold(

    body: Column(
        children: [
          Container(
            height: Dimensions.height20*5,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColors.mainColor,),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 500,
              margin: EdgeInsets.only(
                top: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20
              ),
              child: ListView(
                children: [
                  Text("hi there"),
                  Text("hi there"),
                  Text("hi there"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
