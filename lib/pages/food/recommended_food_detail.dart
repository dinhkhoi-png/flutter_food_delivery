import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widget/app_icon.dart';
import 'package:flutter_food_delivery/widget/big_text.dart';
import 'package:flutter_food_delivery/widget/expandable_text_widget.dart';
class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(

                child: Center(child: BigText(text: "Chinese Side",size: Dimensions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),
                  )
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("assets/image/food0.png",width:double.maxFinite ,
              fit: BoxFit.cover,),

            ),
          ),
          SliverToBoxAdapter(
            //margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            child: Column(

              children: [
                Container(
                  child: ExpandableTextWidget(text: "Phở Dù giá rẻ nhưng ngon số 1. Danh sách các món ăn Việt Nam sẽ không được hoàn thiện mà không có phở. Bạn gần như có thể đi dạo khắp các thành phố lớn ở Việt Nam và bắt gặp cảnh những đám đông đang xì xụp vây quanh một hàng phở nóng sốt, thậm chí ngồi ngay trên vỉa hè. Món ăn ngon lành này gồm các nguyên liệu rất đơn giản như: nước dùng, mì gạo tươi, rắc các loại thảo mộc và thịt gà hoặc thịt bò."),
                   margin: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width20),
                    ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width45+Dimensions.width10,
              right: Dimensions.width45+Dimensions.width10,
              bottom: Dimensions.height10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(iconSize:Dimensions.iconSize24,iconColor: Colors.white ,backgroundColor: AppColors.mainColor,icon: Icons.remove,),
                BigText(text: "12\$"+ " X " +" 0 ",color: AppColors.mainColor,size: Dimensions.font26,),
                AppIcon(icon: Icons.add,iconSize: Dimensions.iconSize24,iconColor: Colors.white ,backgroundColor: AppColors.mainColor,)
              ],
            ),
          ),
          Container(
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
                  child: Icon(Icons.favorite,
                  color: AppColors.mainColor,
                ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                  child: BigText(text:"Add to cart",),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
