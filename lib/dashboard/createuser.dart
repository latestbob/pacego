import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pacegotwo/dashboard/getusers.dart';
import 'package:pacegotwo/dashboard/getusertwo.dart';
import 'package:pacegotwo/dashboard/viewalluser.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final createKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  createRandomIdUser() async {
    final db = await FirebaseFirestore.instance;

    Map<String, dynamic> data = {
      "firstname": firstnameController.text,
      "lastname": lastnameController.text,
      "email": emailController.text,
      "age": ageController.text
    };

    await db.collection("users").add(data).then((documentSnapshot) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "User added to firstore succesfully",
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
        firstnameController.text = "";
        lastnameController.text = "";
        emailController.text = "";
        ageController.text = "";
      });
    });
  }

  // create user with meaningful unique document ID

  createUniqueUser() async {
    final db = await FirebaseFirestore.instance;

    Map<String, dynamic> data = {
      "firstname": firstnameController.text,
      "lastname": lastnameController.text,
      "email": emailController.text,
      "age": ageController.text,
    };

    await db
        .collection("users")
        .doc(emailController.text)
        .set(data)
        .then((documentSnapshot) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "User added to firstore succesfully",
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
        firstnameController.text = "";
        lastnameController.text = "";
        emailController.text = "";
        ageController.text = "";
      });
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) {
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
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Create Firestore User",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Form(
              key: createKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstnameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter First Name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "First name is required";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 15.0,
                    ),

                    // LASTNMAE
                    TextFormField(
                      controller: lastnameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Last Name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Last name is required";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 15.0,
                    ),

                    // email
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Email Address",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!value.contains("@")) {
                          return "Email address not valid";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 15.0,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your Age",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "age is required";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 40.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (createKey.currentState!.validate()) {
                          //add user to firestore
                          // print("working");

                          //createRandomIdUser();
                          createUniqueUser();
                        }
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
                          "Create Firestore User",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    )

                    //
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
