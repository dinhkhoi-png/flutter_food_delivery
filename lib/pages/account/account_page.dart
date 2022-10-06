import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/routes/route_helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';import '../../widget/account_widget.dart';
import '../../widget/app_icon.dart';

import 'package:get/get.dart';
import '../../widget/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text:"Profile" , size: Dimensions.font26,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20,),
        child: Column(
          children: [
            AppIcon(icon: Icons.person,backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height30+Dimensions.height45,
              size: Dimensions.height15*10,),
            SizedBox(height: Dimensions.height20,),
            /**
             * Profile
             * 1.Name
             * 2.phone
             * 3.email
             * 4.address
             * 5.message
             */
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(appIcon: AppIcon(icon: Icons.person,backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize:Dimensions.height50/2,
                      size: Dimensions.height50,),
                      bigText: BigText(text:"Khoi",size: Dimensions.font20,),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    AccountWidget(appIcon: AppIcon(icon: Icons.phone,
                      backgroundColor: Colors.orangeAccent,
                      iconColor: Colors.white,
                      iconSize:Dimensions.height50/2,
                      size: Dimensions.height50,),
                      bigText: BigText(text:"(+84) 932 786 567",size: Dimensions.font20,),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    AccountWidget(appIcon: AppIcon(icon: Icons.email,
                      backgroundColor: Colors.orangeAccent,
                      iconColor: Colors.white,
                      iconSize:Dimensions.height50/2,
                      size: Dimensions.height50,),
                      bigText: BigText(text:"emaildemo@gmail.com",size: Dimensions.font20,),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    AccountWidget(appIcon: AppIcon(icon: Icons.location_on,
                      backgroundColor: Colors.orangeAccent,
                      iconColor: Colors.white,
                      iconSize:Dimensions.height50/2,
                      size: Dimensions.height50,),
                      bigText: BigText(text:"Ho Chi Minh City",size: Dimensions.font20,),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    AccountWidget(appIcon: AppIcon(icon: Icons.message,
                      backgroundColor: Colors.redAccent,
                      iconColor: Colors.white,
                      iconSize:Dimensions.height50/2,
                      size: Dimensions.height50,),
                      bigText: BigText(text:"Message",size: Dimensions.font20,),
                    ),
                    SizedBox(height: Dimensions.height20,),
                    GestureDetector(
                      onTap: (){
                        if(Get.find<AuthController>().userLoggedIn()){
                          Get.find<AuthController>().clearShareData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          Get.offNamed(RouteHelper.getSignInPage());
                        }else{
                          print("You logout  !");
                        }


                      },
                      child: AccountWidget(
                        appIcon: AppIcon(icon: Icons.logout,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize:Dimensions.height50/2,
                          size: Dimensions.height50,),
                        bigText: BigText(text:"Logout",size: Dimensions.font20,),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,)
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
