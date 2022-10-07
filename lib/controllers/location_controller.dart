import 'dart:convert';

import 'package:flutter_food_delivery/data/repository/location_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _isLoading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList=[];
  List<AddressModel> get adressList => _addressList;
  late List<AddressModel> _allAddressList=[];
  final List<String> _addressTypeList=["home","office","others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex=0;
  int get addressTypeIndex => _addressTypeIndex;


  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;


  bool get loading =>_isLoading;
  Position get position =>_position;
  Position get pickPosition=> _pickPosition;
  // Placemark get placemark => _placemark;
  // Placemark get pickPlaceMark =>_pickPlacemark;



  void setMapController(GoogleMapController mapController){
    _mapController = mapController;
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData){
      _isLoading=true;
      update();
      try{
        if(fromAddress){
          _position = Position(
          latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1 ,accuracy: 1,altitude: 1,speedAccuracy: 1,speed: 1
          );
        }else{
          _pickPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1 ,accuracy: 1,altitude: 1,speedAccuracy: 1,speed: 1
          );
        }
        if(_changeAddress){
          String _address = await getAddressfromGeocode(
            LatLng(
                position.target.latitude,
                position.target.longitude
            )
          );

          fromAddress?_placemark=Placemark(name: _address):_pickPlacemark=Placemark(name: _address);
        }
      }catch(e){
        print(e);
      }
    }

  }
  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = "Unknow Location Found";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if(response.body["status"]=="OK"){
      _address = response.body["results"][0]['formatted_address'].toString();
      print("print address >> "+_address);
    }else{
      print("Error getting the google api");
    }
    return _address;
  }
  late Map<String , dynamic> _getAddress;
  Map get getAddress =>_getAddress;

  AddressModel getUserAddress(){

    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    }catch(e){
      print(e);
    }

    return _addressModel;
  }
  void setAddressTypeIndex( int index){
    _addressTypeIndex =index;
    update();
  }
}