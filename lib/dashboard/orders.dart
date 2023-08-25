import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pacegotwo/customwidgets/drawer.dart';
import 'package:pacegotwo/providers/userprovider.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  getIcon(status) {
    if (status == "pending") {
      return Icon(
        Icons.pending,
        size: 40,
        color: Colors.amber,
      );
    } else if (status == "ontransit") {
      return Icon(
        Icons.directions_bike,
        size: 40.0,
        color: Colors.blue,
      );
    } else {
      return Icon(
        Icons.check_circle,
        size: 40.0,
        color: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E4854),
        title: Text(
          "All Orders",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: DrawerWidget(),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("orders")
              .where("customer_email",
                  isEqualTo: context.read<UserProvider>().getEmail)
              .get(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }

            List document = snapshot.data!.docs;

            return ListView.builder(
                itemCount: document.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 228, 227, 227),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${document[index]["pickup_address"]}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 79, 79, 79),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${document[index]["dropoff_address"]}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 79, 79, 79),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Orderno :${document[index]["orderno"]}",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 79, 79, 79),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    Text(
                                      "Status :${document[index]["status"]} ",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 79, 79, 79),
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            getIcon(document[index]["status"]),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
