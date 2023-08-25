import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupProvider with ChangeNotifier {
  //phone number

  String phonenumber = "";

  //get phone number

  String get getPhone => phonenumber;

  //set phonenumber

  void setPhone(String phone) {
    phonenumber = phone;
    notifyListeners();
  }

  //

  String pickupaddress = "";

  //get pickup address

  String get getPickupAddress => pickupaddress;

  //set pickup address

  void setPickupAddress(String address) {
    pickupaddress = address;
    notifyListeners();
  }

  //apartment /house

  String apartment = "";

//get apartment
  String get getApartment => apartment;

  //set apartment

  void setApartment(String house) {
    apartment = house;
    notifyListeners();
  }

  //area

  String area = "";

  //get area

  String get getArea => area;

  //set area

  void setArea(String myarea) {
    area = myarea;
    notifyListeners();
  }

  // latitude

  double latitude = 0.0;

  //get latitude

  double get getLatitude => latitude;

  // set latitude

  void setLatitude(double lat) {
    latitude = lat;
    notifyListeners();
  }

  // longitude

  double longitude = 0.0;

  // get longitude

  double get getLongitude => longitude;

  // set longitude

  void setLongitude(double lng) {
    longitude = lng;
    notifyListeners();
  }
}
