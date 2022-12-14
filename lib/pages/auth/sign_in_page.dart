import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_loader.dart';
import 'package:flutter_food_delivery/pages/auth/sign_up_page.dart';
import 'package:flutter_food_delivery/routes/route_helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../widget/app_text_field.dart';
import '../../widget/big_text.dart';
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      //var authController = Get.find<AuthController>();

      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

     if (phone.isEmpty){
        showCustomSnackBar("Type in your email",title: "Email");
      // }else if (!GetUtils.isEmail(email)){
      //   showCustomSnackBar("Type in a valib email address",title: "Valid Email Address");
      }else if (password.isEmpty){
        showCustomSnackBar("Type in your password" , title: "password");
      }else if (password.length<6){
        showCustomSnackBar("Password can not be less than six chareters", title: "Password");
      }else{


        authController.login(phone,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());

          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
      return  !authController.isLoading? SingleChildScrollView(
        //reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05),
            Container(
              height: Dimensions.screenHeight*0.25,
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                      "assets/image/logo part 1.png"
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WellCome",
                    style: TextStyle(
                        fontSize: Dimensions.font20*4-Dimensions.font20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Sign in your account",
                    style: TextStyle(
                      fontSize: Dimensions.font16,
                      color: Colors.grey[500],
                      // fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20,),


            AppTextField(textController: phoneController,
                hintText: "Phone", icon: Icons.phone),
            SizedBox(height: Dimensions.height20,),
            AppTextField(textController: passwordController,
              hintText: "Password", icon: Icons.password_sharp,isObscure: true,),

            SizedBox(height: Dimensions.height20,),
            Row(
              children: [
                Expanded(child: Container()),

                RichText(
                    text: TextSpan(
                        text: "Sign in your account",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,

                        ))
                ),

                SizedBox(width: Dimensions.width20,),
              ],
            ),
            SizedBox(height: Dimensions.height30,),

            GestureDetector(
              onTap: (){
                _login(authController);
              },
              child: Container(
                width: Dimensions.screenWidth/2,
                height: Dimensions.screenHeight/13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(child: BigText(text: "Sign In",size: Dimensions.font26,color: Colors.white,)),
              ),
            ),

            SizedBox(height: Dimensions.screenHeight*0.05,),

            RichText(
                text: TextSpan(
                    text: "Don\'t you have account? ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(),transition: Transition.fade),
                          text: "Create ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20
                          )
                      )
                    ]
                )
            ),

            SizedBox(height: Dimensions.height10,),

          ],
        ),

      ):const CustomLoader();
      })
    );
  }

}
