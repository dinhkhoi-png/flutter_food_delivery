import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
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

  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(10.823842,106.634098),zoom: 20);

  late LatLng _initialPosition=const LatLng(10.823842,106.634098);//45.51563 , -122.677433 //10.823842,106.634098

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
      body: GetBuilder<LocationController>(builder: (locationController){
        return Column(
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
            )
          ],
        );
      }),
    );
  }
}
