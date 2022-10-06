import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_product_controller.dart';
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/pages/auth/sign_in_page.dart';
import 'package:flutter_food_delivery/pages/auth/sign_up_page.dart';
import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery/pages/food/recommended_food_detail.dart';
import 'package:flutter_food_delivery/pages/home/food_page_body.dart';
import 'package:flutter_food_delivery/pages/home/main_food_page.dart';
import 'package:flutter_food_delivery/routes/route_helper.dart';
import 'helper/dependecies.dart'as dep;
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.find<CartController>().getCartData();
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetBuilder<PopularProductController>(
      builder: (_){
        return GetBuilder<RecommendedProductController>(builder: (_){
          return GetMaterialApp (
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            //home: SignInPage(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
      
    );
  }
}
