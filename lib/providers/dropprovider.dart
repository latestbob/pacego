import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropoffProvider with ChangeNotifier {
  //recipient_name

  String recipient_name = "";

  //get recipient_name

  String get getRecipientName => recipient_name;

  //set recipient_name

  void setRecipientName(String name) {
    recipient_name = name;
    notifyListeners();
  }

  //recipient phone

  String recipient_phone = "";

  //get recipient phone

  String get getRecipientPhone => recipient_phone;

  //set recipient phone

  void setRecipientPhone(String phone) {
    recipient_phone = phone;

    notifyListeners();
  }

  //delivery_Address

  String delivery_address = "";

  //get delivery address

  String get getDeliveryAddress => delivery_address;

  //set delivery address

  void setDeliveryAddress(String address) {
    delivery_address = address;
    notifyListeners();
  }

  //category

  List categoryList = [];

//get categorylist
  List get getCategoryList => categoryList;

  //set categorylist

  void updateCategoryList(String item) {
    if (categoryList.contains(item)) {
      categoryList.remove(item);
    } else if (!categoryList.contains(item)) {
      categoryList.add(item);
    }

    notifyListeners();
  }
  //empty category list

  void setCategorylist(List list) {
    categoryList = list;
    notifyListeners();
  }

  //dropoff_apartment

  String dropoff_apartment = "";

  //get DROPoff Apartment

  String get getDropoffApartment => dropoff_apartment;

  //set dropoffapartment

  void setDropoffApartment(String apartment) {
    dropoff_apartment = apartment;
    notifyListeners();
  }

  //dropoff area

  String dropoff_area = "";

  //GET dropoff area

  String get getDropOffArea => dropoff_area;

  //set dropoff area

  void setDropOffArea(String area) {
    dropoff_area = area;
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
