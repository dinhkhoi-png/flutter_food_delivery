import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList =>_popularProductList;
  late CartController _cart;


  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCarItems => _inCartItems + _quantity;

  Future<void> getPopularProductList()async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){

      //print("got product");
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded=true;
      update();
    }else{

    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      //print("increment"+_quantity.toString());
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
      //print("decrement"+_quantity.toString());
    }
    update();
  }
  int checkQuantity(int quantity){
    if(quantity<0){
      Get.snackbar("Product Count", "You cannot reduce more !",backgroundColor: AppColors.mainColor,);
      return 0;
    }else if(quantity >30){
      Get.snackbar("Product Count", "You cannot add more !",backgroundColor: AppColors.mainColor,);
      return 30;
    }else{
      return quantity;
    }
  }

  void initProduct(CartController cart){
    _quantity = 0;
    _inCartItems=0;
    _cart=cart;
    //if exits
    //get form storage _incartitems=3
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
  }

}