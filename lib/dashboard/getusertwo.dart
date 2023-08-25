import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GetUserTwo extends StatefulWidget {
  const GetUserTwo({super.key});

  @override
  State<GetUserTwo> createState() => _GetUserTwoState();
}

class _GetUserTwoState extends State<GetUserTwo> {
  final updateKey = GlobalKey<FormState>();

  String firstname = "";
  String lastname = "";
  String email = "";
  String age = "";

  updateUser(f, l, e, a) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(e)
        .update({"firstname": f, "lastname": l, "email": e, "age": a}).then(
            (documentSnapshop) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "User Updated succesfully",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return GetUserTwo();
      }));
    });
  }

  deleteUser(email) async {
    await FirebaseFirestore.instance.collection("users").doc(email).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "User Deleted succesfully",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return GetUserTwo();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E4854),
        elevation: 0.0,
        title: Text(
          "All Firestore Users",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").get(),
        builder: (BuildContext context, snapshop) {
          // check if connection state is waiting

          if (snapshop.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshop.hasError) {
            return Center(
              child: Text(
                'An error occured',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          List document = snapshop.data!.docs;

          return ListView.builder(
              itemCount: document.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                Text("Remove ${document[index]['firstname']}"),
                            content: Container(
                              height: 60.0,
                              child: Text(
                                "Kindly note that deleted data cannot be retrieved",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  //your delete function here

                                  deleteUser(document[index]['email']);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    "${document[index]["email"]}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  "Edit ${document[index]['firstname']} details"),
                              content: Container(
                                height: 250.0,
                                child: Form(
                                  key: updateKey,
                                  child: Column(
                                    children: [
                                      // firstname
                                      TextFormField(
                                        initialValue: document[index]
                                            ['firstname'],
                                        decoration: InputDecoration(),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Firstname field is required";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            firstname = value!;
                                          });
                                        },
                                      ),

                                      SizedBox(
                                        height: 5.0,
                                      ),

                                      // lastname
                                      TextFormField(
                                        initialValue: document[index]
                                            ['lastname'],
                                        decoration: InputDecoration(),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Lastname field is required";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            lastname = value!;
                                          });
                                        },
                                      ),

                                      SizedBox(
                                        height: 5.0,
                                      ),

                                      // email
                                      TextFormField(
                                        enabled: false,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        initialValue: document[index]['email'],
                                        decoration: InputDecoration(),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Email field is required";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            email = value!;
                                          });
                                        },
                                      ),

                                      SizedBox(
                                        height: 5.0,
                                      ),

                                      // age
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        initialValue: document[index]['age'],
                                        decoration: InputDecoration(),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Age field is required";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            age = value!;
                                          });
                                        },
                                      ),

                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Update'),
                                  onPressed: () {
                                    // check if the form is valid

                                    if (updateKey.currentState!.validate()) {
                                      updateKey.currentState!.save();

                                      updateUser(
                                          firstname, lastname, email, age);
                                    }

                                    // save the data
                                    // call the update function
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
