import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pacegotwo/dashboard/createuser.dart';
import 'package:pacegotwo/dashboard/dropoff.dart';
import 'package:pacegotwo/dashboard/orders.dart';
import 'package:pacegotwo/dashboard/pickup.dart';
import 'package:pacegotwo/dashboard/viewalluser.dart';
import 'package:pacegotwo/providers/dropprovider.dart';
import 'package:pacegotwo/providers/pickprovider.dart';
import 'package:pacegotwo/providers/userprovider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  bool isLoading = false;

  String selectedType = "same_day";

  String paymentMethod = "cash";

  //earth radius
  final double earthRadius = 6371.0;

//convert degree to radian
  double _degreesToRadians(double degrees) {
    return degrees * Math.pi / 180;
  }

  double distanceInKmBetweenEarthCoordinates(
      double lat1, double lon1, double lat2, double lon2) {
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = Math.pow(Math.sin(dLat / 2), 2) +
        Math.cos(_degreesToRadians(lat1)) *
            Math.cos(_degreesToRadians(lat2)) *
            Math.pow(Math.sin(dLon / 2), 2);

    final double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return earthRadius * c;
  }

  // int generateRandomSixDigitNumber() {
  //   Random random = Random();
  //   int min = 100000; // Minimum 6-digit number (100000)
  //   int max = 999999; // Maximum 6-digit number (999999)
  //   return min + random.nextInt(max - min);
  // }

  int generateRandom() {
    Random random = Random();

    int min = 100000;
    int max = 999999;

    return min + random.nextInt(max - min);
  }

  addOrderToFiretore() async {
    setState(() {
      isLoading = true;
    });
    final db = FirebaseFirestore.instance;

    Map<String, dynamic> data = {
      "customer_name": context.read<UserProvider>().getUsername,
      "customer_phone": context.read<PickupProvider>().getPhone,
      "distance": distanceInKmBetweenEarthCoordinates(
              context.read<PickupProvider>().getLatitude,
              context.read<PickupProvider>().getLongitude,
              context.read<DropoffProvider>().getLatitude,
              context.read<DropoffProvider>().getLongitude)
          .toInt(),
      "dropoff_address": context.read<DropoffProvider>().getDeliveryAddress,
      "dropoff_lat": context.read<DropoffProvider>().getLatitude,
      "dropoff_long": context.read<DropoffProvider>().getLongitude,
      "orderno": generateRandom(),
      "pickup_address": context.read<PickupProvider>().getPickupAddress,
      "pickup_area": context.read<PickupProvider>().getArea,
      "pickup_house": context.read<PickupProvider>().getApartment,
      "pickup_lat": context.read<PickupProvider>().getLatitude,
      "pickup_long": context.read<PickupProvider>().getLongitude,
      "recipient_area": context.read<DropoffProvider>().getDropOffArea,
      "recipient_house": context.read<DropoffProvider>().getDropoffApartment,
      "recipient_name": context.read<DropoffProvider>().getRecipientName,
      "recipient_phone": context.read<DropoffProvider>().getRecipientPhone,
      "status": "pending",
      "customer_email": context.read<UserProvider>().getEmail,
      "category": context.read<DropoffProvider>().getCategoryList.toString(),
      "amount":
          "N ${distanceInKmBetweenEarthCoordinates(context.read<PickupProvider>().getLatitude, context.read<PickupProvider>().getLongitude, context.read<DropoffProvider>().getLatitude, context.read<DropoffProvider>().getLongitude).toInt() * 300}",
    };

    await db
        .collection("orders")
        .doc(generateRandom().toString())
        .set(data)
        .then((documentSnapshot) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Pickup order request was successful",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );

      context.read<PickupProvider>().setPhone("");
      context.read<PickupProvider>().setLatitude(0.0);
      context.read<PickupProvider>().setLongitude(0.0);
      context.read<DropoffProvider>().setLatitude(0.0);
      context.read<DropoffProvider>().setLongitude(0.0);
      context.read<DropoffProvider>().setDeliveryAddress("");
      context.read<PickupProvider>().setPickupAddress("");

      context.read<PickupProvider>().setArea("");
      context.read<PickupProvider>().setApartment("");
      context.read<DropoffProvider>().setDropOffArea("");
      context.read<DropoffProvider>().setDropoffApartment("");
      context.read<DropoffProvider>().setRecipientName("");
      context.read<DropoffProvider>().setRecipientPhone("");
      context.read<DropoffProvider>().setCategorylist([]);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Orders();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text(
          "New Order",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1E4854),
        elevation: 0.0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 25.0,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PickUp();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                        color: Color.fromARGB(119, 116, 167, 181),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pickup",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  "Enter pickup details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Delivery point

                SizedBox(
                  height: 25.0,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DropOff();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                        color: Color.fromARGB(119, 116, 167, 181),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Dropoff",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  "Enter delivery  details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Delivery Type",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Radio(
                      activeColor: Colors.amber,
                      value: "same_day",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                        print(selectedType);
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "PaceGo jet (Same day delivery)",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),

                Row(
                  children: [
                    Radio(
                      activeColor: Colors.amber,
                      value: "standard",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                        print(selectedType);
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Standard Delivery(24hours)",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Payment Method",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Radio(
                      activeColor: Colors.amber,
                      value: "cash",
                      groupValue: paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value!;
                        });
                        print(paymentMethod);
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Cash",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30.0,
                ),

                context.watch<PickupProvider>().getPhone != "" &&
                        context.watch<PickupProvider>().getPickupAddress !=
                            "" &&
                        context.watch<PickupProvider>().getLatitude != 0.0 &&
                        context.watch<PickupProvider>().getLongitude != 0.0 &&
                        context.watch<DropoffProvider>().getRecipientName !=
                            "" &&
                        context.watch<DropoffProvider>().getRecipientPhone !=
                            "" &&
                        context.watch<DropoffProvider>().getDeliveryAddress !=
                            "" &&
                        context
                            .watch<DropoffProvider>()
                            .getCategoryList
                            .isNotEmpty &&
                        context.watch<DropoffProvider>().getLatitude != 0.0 &&
                        context.watch<DropoffProvider>().getLongitude != 0.0
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Estimated Distance",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "${distanceInKmBetweenEarthCoordinates(context.watch<PickupProvider>().getLatitude, context.watch<PickupProvider>().getLongitude, context.watch<DropoffProvider>().getLatitude, context.watch<DropoffProvider>().getLongitude).toInt()}  km",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "N ${distanceInKmBetweenEarthCoordinates(context.watch<PickupProvider>().getLatitude, context.watch<PickupProvider>().getLongitude, context.watch<DropoffProvider>().getLatitude, context.watch<DropoffProvider>().getLongitude).toInt() * 300}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                //add to firestore

                                addOrderToFiretore();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF049FA3),
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                child: Text(
                                  "Request Pickup",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),

                SizedBox(
                  height: 20.0,
                ),

                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                //       return CreateUser();
                //     }));
                //   },
                //   child: Text(
                //     "Create Firestore Users",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 17.0,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                // SizedBox(
                //   height: 20.0,
                // ),

                // Text(
                //   context.watch<PickupProvider>().getArea,
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20.0,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
    );
  }
}
