import 'package:flutter/material.dart';
import 'package:pacegotwo/dashboard/category.dart';
import 'package:pacegotwo/dashboard/dropoff_address.dart';
import 'package:pacegotwo/providers/dropprovider.dart';
import 'package:provider/provider.dart';

class DropOff extends StatefulWidget {
  const DropOff({super.key});

  @override
  State<DropOff> createState() => _DropOffState();
}

class _DropOffState extends State<DropOff> {
  final dropoffKey = GlobalKey<FormState>();
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientPhoneController = TextEditingController();
  TextEditingController houseApartmentController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text(
          "Drop-Off",
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
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Form(
            key: dropoffKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 80.0,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Recipient's Name *required",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: context
                                  .watch<DropoffProvider>()
                                  .getRecipientName,
                              onChanged: (value) {
                                context
                                    .read<DropoffProvider>()
                                    .setRecipientName(value);
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "recipient's Name",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 182, 180, 180),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "recipient's name is required";
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //recipients phone

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 80.0,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Recipient's Phone *required",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: context
                                  .watch<DropoffProvider>()
                                  .getRecipientPhone,
                              onChanged: (value) {
                                context
                                    .read<DropoffProvider>()
                                    .setRecipientPhone(value);
                              },
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "recipient's Phone",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 182, 180, 180),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "recipient's phone is required";
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Dropoff Address

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DropoffAddress();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 80.0,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Delivery Address *required",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                            Expanded(
                                child: context
                                        .watch<DropoffProvider>()
                                        .getDeliveryAddress
                                        .isEmpty
                                    ? Text(
                                        "Select Address",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 182, 180, 180),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : Text(
                                        context
                                            .watch<DropoffProvider>()
                                            .getDeliveryAddress,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 182, 180, 180),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //categories

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CategoryScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 80.0,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Package Category *required",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                            Expanded(
                              child: context
                                      .watch<DropoffProvider>()
                                      .getCategoryList
                                      .isNotEmpty
                                  ? Text(
                                      context
                                          .watch<DropoffProvider>()
                                          .getCategoryList
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Text(
                                      "Select category",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 182, 180, 180),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //House and Apartment

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 80.0,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "House/Apartment(optional)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: context
                                  .watch<DropoffProvider>()
                                  .getDropoffApartment,
                              onChanged: (value) {
                                context
                                    .read<DropoffProvider>()
                                    .setDropoffApartment(value);
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "House / Apartment(optional)",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 182, 180, 180),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //area

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 80.0,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Area(optional)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: context
                                  .watch<DropoffProvider>()
                                  .getDropOffArea,
                              onChanged: (value) {
                                context
                                    .read<DropoffProvider>()
                                    .setDropOffArea(value);
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Area(optional)",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 182, 180, 180),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {},
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
                        "Save DropOff",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Text(
          //   context.watch<DropoffProvider>().getLatitude.toString(),
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 15.0,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
          // Text(
          //   context.watch<DropoffProvider>().getLongitude.toString(),
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 15.0,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
