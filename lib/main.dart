import 'package:flutter/material.dart';
import 'package:pacegotwo/dashboard/home.dart';
import 'package:pacegotwo/providers/dropprovider.dart';
import 'package:pacegotwo/providers/pickprovider.dart';
import 'package:pacegotwo/providers/userprovider.dart';

import 'package:pacegotwo/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:pacegotwo/providers/userprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        //User provider
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => PickupProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => DropoffProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
