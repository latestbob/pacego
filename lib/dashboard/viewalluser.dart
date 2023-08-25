import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({super.key});

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E4854),
        elevation: 0.0,
      ),
      // body: ListView(
      //   shrinkWrap: true,
      //   children: [
      //     SizedBox(
      //       height: 20.0,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: ListTile(
      //         leading: Icon(
      //           Icons.person,
      //           color: Colors.white,
      //           size: 30.0,
      //         ),
      //         title: Text(
      //           "useremail@gmail.com",
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 16.0,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         trailing: Icon(
      //           Icons.edit,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ],

      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("users").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being fetched, show a loading indicator
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          } else if (snapshot.hasError) {
            // If an error occurs, show an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // Once the data is available, process it
            List<DocumentSnapshot> documents = snapshot.data!.docs;

            // Render the documents in a ListView or any other widget
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                // Access document data using documents[index].data()
                //Map<String, dynamic> userData = documents[index].data() as Map<String, dynamic>;

                // Render the user data
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    title: Text(
                      documents[index]["email"],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
