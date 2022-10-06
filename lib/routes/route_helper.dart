import 'package:flutter_food_delivery/pages/address/add_address_page.dart';
import 'package:flutter_food_delivery/pages/auth/sign_in_page.dart';
import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery/pages/food/recommended_food_detail.dart';
import 'package:flutter_food_delivery/pages/home/home_page.dart';
import 'package:flutter_food_delivery/pages/home/main_food_page.dart';
import 'package:flutter_food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';


class RouteHelper{
  static const String splashPage="/splash-page";
  static const String initial = "/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";
  static const String signIn="/sign-in";
  static const String addAddress="/add-address";


  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSignInPage()=>'$signIn';
  static String getAddAddressPage()=>'$addAddress';


  static List<GetPage> routes=[
    GetPage(name: splashPage, page: ()=>SplashPage()),

    GetPage(name: initial, page:(){
      return HomePage();
    } ),
    GetPage(name: signIn, page:(){
      return SignInPage();
    },transition: Transition.fade),

    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];

      return PopularFoodDetail(pageId:int.parse(pageId!),page:page!);
    },
      transition: Transition.fade
    ),

    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      //print("popular food called");
      return RecommendedFoodDetail(pageId:int.parse(pageId!),page:page!);
    },
        transition: Transition.fade
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fade
    ),
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    })
  ];
}