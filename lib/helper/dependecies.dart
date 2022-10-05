import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/data/repository/cart_repo.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences,fenix: true);
  //Api Client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL),fenix: true);

  //Api repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()),fenix: true);

  //Api Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()),fenix: true);
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()),fenix: true);
  Get.lazyPut(() => CartController(cartRepo: Get.find()),fenix: true);
}