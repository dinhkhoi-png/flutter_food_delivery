
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_loader.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/routes/route_helper.dart';

import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';


import 'package:get/get.dart';


import '../../base/show_custom_snackbar.dart';
import '../../models/signup_body_model.dart';
import '../../widget/app_text_field.dart';
import '../../widget/big_text.dart';
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png"
    ];
    void _registration(AuthController authController){
      //var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name",title: "Name");
      }else if (phone.isEmpty){
        showCustomSnackBar("Type in your phone",title: "Phone");
      }else if (email.isEmpty){
        showCustomSnackBar("Type in your email",title: "Email");
      }else if (!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valib email address",title: "Valid Email Address");
      }else if (password.isEmpty){
        showCustomSnackBar("Type in your password" , title: "password");
      }else if (password.length<6){
        showCustomSnackBar("Password can not be less than six chareters", title: "Password");
      }else{
        showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.offNamed(RouteHelper.getSignInPage());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
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
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: emailController,
                  hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: passwordController,
                hintText: "Password", icon: Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: nameController,
                  hintText: "Name", icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: phoneController,
                  hintText: "Phone", icon: Icons.phone),
              SizedBox(height: Dimensions.height30,),

              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(child: BigText(text: "Sign Up",size: Dimensions.font26,color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already ?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,

                      ))
              ),
              SizedBox(height: Dimensions.height15,),
              RichText(
                  text: TextSpan(
                      text: "Sign Up with",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      )
                  )
              ),
              SizedBox(height: Dimensions.height10,),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                )),
              )
            ],
          ),
        ):const CustomLoader();
      })
      );



  }
}
