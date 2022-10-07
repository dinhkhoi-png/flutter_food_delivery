import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widget/app_text_field.dart';
import 'package:flutter_food_delivery/widget/big_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../utils/colors.dart';
import '../../widget/app_icon.dart';
class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName =TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;

  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(10.823842,106.634098 ),zoom: 20);

  late LatLng _initialPosition=const LatLng(10.823842,106.634098);//45.51563 , -122.677433 //10.823842,106.634098
  late LatLng _initial;
  // lấy location mặc định tại vị trí hiện tại
  // * kiểm tra trong mainferst đã cấp quyền chưa?
  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));
    setState(() {
      _initial = LatLng(position.latitude, position.longitude);
      print('address>>>>>>>>>>>>>>>> : $_initial');

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().adressList.isNotEmpty){
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
      ),
      body: GetBuilder<UserController>(builder: (userController){

        if(userController.userModel!=null && _contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text='${userController.userModel?.phone}';
          if(Get.find<LocationController>().adressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }

        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text ='${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("address in my view "+_addressController.text);
          return SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
                  height: Dimensions.height20*8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height10/2),
                      border: Border.all(
                          width: Dimensions.height10/5 , color: Theme.of(context).primaryColor
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition:
                      CameraPosition(target: _initialPosition,zoom: 20),
                        zoomControlsEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition,true);
                        },
                        onCameraMove: ((position)=>_cameraPosition=position),
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20 ,top: 20),
                  child: SizedBox(height: 50,child: ListView.builder(
                    shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        locationController.setAddressTypeIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height20),
                          margin: EdgeInsets.only(right: Dimensions.width10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 5
                              )
                            ]
                          ),
                        child: Row(
                          children: [
                            Icon(
                              index==0?Icons.home:index==1?Icons.work:Icons.location_on,
                              color: locationController.addressTypeIndex==index?AppColors.mainColor:Theme.of(context).disabledColor,
                            )
                          ],
                        ),
                      ),
                    );
                  }),),
                ),
                IconButton(onPressed: (){
                  _getUserLocation();
                }, icon:Icon(Icons.location_on) ),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _addressController, hintText: "Your address", icon: Icons.map),
                SizedBox(height: Dimensions.height20,),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BigText(text: "Delivery name"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonName, hintText: "Your address", icon: Icons.person),
                SizedBox(height: Dimensions.height20,),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BigText(text: "Delivery phone"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonNumber, hintText: "Your address", icon: Icons.phone),

              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(

            mainAxisSize: MainAxisSize.min,
            children: [

              Container(

                height: Dimensions.height20*7,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: BigText(
                          text: "SAVE",size: Dimensions.font26,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
