import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init()async {

  //Api Client
  Get.lazyPut(()=>ApiClient(appBaseUrl:"http://mvs.bslmeiyu.com"));

  //Api repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //Api Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}