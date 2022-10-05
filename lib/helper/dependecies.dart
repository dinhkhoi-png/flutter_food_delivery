import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/data/repository/auth_repo.dart';
import 'package:flutter_food_delivery/data/repository/cart_repo.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../controllers/auth_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);
  //Api Client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL));
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Api repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  //Api Controllers
  Get.lazyPut(()=> AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

}