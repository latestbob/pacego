import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pacegotwo/dashboard/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  bool showPassword = false;

  bool checkvalue = false;

  showIcon() {
    if (showPassword == true) {
      return GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Icon(
          Icons.visibility,
          size: 25.0,
          color: Colors.white,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Icon(
          Icons.visibility_off,
          color: Colors.white,
          size: 25.0,
        ),
      );
    }
  }

  signUp() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateDisplayName(usernameController.text);

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Home();
        }));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Pasword is too weak!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Email Already Exist, use different mail",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E4854),
        title: Text(
          "Regiser",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: usernameController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(119, 116, 167, 181),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username is required";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(119, 116, 167, 181),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email Address is required";
                      } else if (!value.contains("@")) {
                        return "Invalid Email address, @ is required";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Phone No",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(119, 116, 167, 181),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number is required";
                      } else if (value.length < 11) {
                        return "Phone number should be 11 characters";
                      } else if (value.length > 11) {
                        return "Phone number should not be more than 11";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: showIcon(),
                      hintText: "Secured Password",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(119, 116, 167, 181),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                    ),
                    obscureText: showPassword ? false : true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      } else if (value.length < 8) {
                        return "Password should be up to 8 characters";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(
                          color: Color(0xFF049FA3),
                          width: 2.0,
                        ),
                        value: checkvalue,
                        onChanged: (value) {
                          setState(() {
                            checkvalue = !checkvalue;
                          });
                        },
                      ),
                      Text(
                        "I agree with PaceGo's",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          color: Color(0xFF049FA3),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  checkvalue
                      ? GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              signUp();
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
                              "Register Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
