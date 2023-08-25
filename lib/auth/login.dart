import 'package:flutter/material.dart';
import 'package:pacegotwo/admin/adminhome.dart';
import 'package:pacegotwo/auth/forgot.dart';
import 'package:pacegotwo/dashboard/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pacegotwo/providers/userprovider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

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

  signIn() async {
    try {
      final crendential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // final user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => Home()),
      //   );
      // }

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        context.read<UserProvider>().setUsername(user.displayName.toString());

        context.read<UserProvider>().setEmail(user.email.toString());

        if (user.email.toString() == "admin@pacego.com") {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return AdminHome();
          }));
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return Home();
          }));
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print("User not in our database");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "User not found",
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
      } else if (e.code == 'wrong-password') {
        // print("Invalid Password");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Invalid Password",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(
                  "https://res.cloudinary.com/edifice-solutions/image/upload/v1680642543/Group_2_1_vo9yzo.png"),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Form(
            key: loginKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
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
                    height: 20.0,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ForgotScreen();
                      }));
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (loginKey.currentState!.validate()) {
                        // print("Submitted Login Successful");

                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return Home();
                        // }));

                        signIn();
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
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
