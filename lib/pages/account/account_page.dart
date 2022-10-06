import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_loader.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
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
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("User had login");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text:"Profile" , size: Dimensions.font26,
          ),
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
        (userController.isLoading?Container(
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
                        bigText: BigText(text:userController.userModel!.name,size: Dimensions.font20,),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(appIcon: AppIcon(icon: Icons.phone,
                        backgroundColor: Colors.orangeAccent,
                        iconColor: Colors.white,
                        iconSize:Dimensions.height50/2,
                        size: Dimensions.height50,),
                        bigText: BigText(text:userController.userModel!.phone,size: Dimensions.font20,),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(appIcon: AppIcon(icon: Icons.email,
                        backgroundColor: Colors.orangeAccent,
                        iconColor: Colors.white,
                        iconSize:Dimensions.height50/2,
                        size: Dimensions.height50,),
                        bigText: BigText(text:userController.userModel!.email,size: Dimensions.font20,),
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
        ):CustomLoader())
            :Container(
            child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                       width: double.maxFinite,
                        height: Dimensions.height20*8,
                        margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/image/signintocontinue.png"

                            )
                          )
                        ),
            ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.height20*5,
                        margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: Center(child: BigText(text: "Sign In" ,color: Colors.white,size: Dimensions.font26,)),
                      ),
                    )
                  ],
                )));
      })
    );
  }
}
