import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pacegotwo/dashboard/createuser.dart';

class GetUsers extends StatefulWidget {
  const GetUsers({super.key});

  @override
  State<GetUsers> createState() => _GetUsersState();
}

class _GetUsersState extends State<GetUsers> {
  final updateKey = GlobalKey<FormState>();

  String firstname = "";
  String lastname = "";
  String email = "";
  String age = "";

  updateUser(f, l, e, a) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(e)
        .update({'firstname': f, 'lastname': l, 'email': e, 'age': a}).then(
            (documentSnapshot) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "User updated succesfully",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        firstname = "";
        lastname = "";
        email = "";
        age = "";
      });

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return GetUsers();
      }));
    });
  }

  // delete from firestore

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
      return GetUsers();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return CreateUser();
            }));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
          future: FirebaseFirestore.instance
              .collection("users")
              .where("age", isGreaterThan: "18")
              .get(),
          builder: (BuildContext context, snapshot) {
            // check the connection state is waiting
            if (snapshot.connectionState == ConnectionState.waiting) {
              //SHOW circularindictor

              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List documents = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      "Delete ${documents[index]["firstname"]}"),
                                  content: Container(
                                    height: 70.0,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Kindly note that deleted data are not retrievable",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
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
                                        ),
                                      ),
                                      onPressed: () {
                                        // Handle form submission
                                        deleteUser(documents[index]["email"]);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
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
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Edit ${documents[index]["email"]}",
                                    ),
                                    content: Container(
                                      height: 250.0,
                                      child: Form(
                                        key: updateKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              initialValue: documents[index]
                                                  ["firstname"],
                                              decoration: InputDecoration(),
                                              onSaved: (value) {
                                                setState(() {
                                                  firstname = value!;
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "firstname is required";
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              initialValue: documents[index]
                                                  ["lastname"],
                                              decoration: InputDecoration(),
                                              onSaved: (value) {
                                                setState(() {
                                                  lastname = value!;
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "lastname is required";
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              enabled: false,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              initialValue: documents[index]
                                                  ["email"],
                                              decoration: InputDecoration(),
                                              onSaved: (value) {
                                                setState(() {
                                                  email = value!;
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Email is required";
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue: documents[index]
                                                  ["age"],
                                              decoration: InputDecoration(),
                                              onSaved: (value) {
                                                setState(() {
                                                  age = value!;
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Age is required";
                                                }
                                              },
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
                                        child: Text('Submit'),
                                        onPressed: () {
                                          // Handle form submission
                                          if (updateKey.currentState!
                                              .validate()) {
                                            // print(firstname);
                                            // updateUser(firstname, lastname,
                                            //     email, age);

                                            updateKey.currentState!.save();
                                            updateUser(firstname, lastname,
                                                email, age);
                                          }
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
                      ),
                    );
                  });
            }

            // check is there's an error

            // reture what you want i.e listviewbuilder
          }),
    );
  }
}
