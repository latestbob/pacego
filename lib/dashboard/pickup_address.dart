import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pacegotwo/providers/pickprovider.dart';
import 'package:provider/provider.dart';

class PickupAddress extends StatefulWidget {
  const PickupAddress({super.key});

  @override
  State<PickupAddress> createState() => _PickupAddressState();
}

class _PickupAddressState extends State<PickupAddress> {
  TextEditingController inputController = TextEditingController();
  List place = [
    "Lagos State Nigeria",
    "Aso Rock, Abuja Fct",
    "Onitsha, Anambra State, Nigeria"
  ];
  List prediction = [];
  getPrediction(String value) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${value}&language=en&type=geocode&components=country:ng&key=AIzaSyBzt_dYPF4iZorlJAGggSXlnaCaDKMJ4S0";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      var myprediction = res["predictions"].toList();

      setState(() {
        prediction = myprediction;
      });
    }
  }

  getLatLong(String place_id) async {
    String url_two =
        "https://maps.googleapis.com/maps/api/geocode/json?place_id=${place_id}&key=AIzaSyBzt_dYPF4iZorlJAGggSXlnaCaDKMJ4S0";

    final response = await http.get(Uri.parse(url_two));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      double latitude = res["results"][0]["geometry"]["location"]["lat"];
      double longitude = res["results"][0]["geometry"]["location"]["lng"];

      context.read<PickupProvider>().setLatitude(latitude);
      context.read<PickupProvider>().setLongitude(longitude);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text(
          "Pickup Address",
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
      body: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: inputController,
              onChanged: (value) {
                getPrediction(value);
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Pickup Address",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 191, 191, 191),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.location_on,
                  size: 25.0,
                  color: Colors.white,
                ),
                fillColor: Color.fromARGB(119, 116, 167, 181),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: Container(
              height: 400,
              child: prediction.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: prediction.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          onTap: () async {
                            context.read<PickupProvider>().setPickupAddress(
                                prediction[index]["description"]);

                            getLatLong(prediction[index]["place_id"]);
                          },
                          title: Text(
                            prediction[index]["description"],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      })
                  : SizedBox(
                      height: 20.0,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
