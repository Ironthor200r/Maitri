import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shield/pages/location.dart';
import 'package:shield/pages/profile.dart';
import 'package:shield/pages/reg_page.dart';
import 'package:shield/pages/start.dart';
import 'package:shield/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: 'AIzaSyCigyTiwVfJuXU77yM-S4Mq_FMG_xyThbw',
              appId: '1:550462101291:android:ba5fa2f693662f4dd9d76e',
              messagingSenderId: '550462101291',
              projectId: 'my-shield-project'))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => homepage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/yoi.png', // Replace with your actual image path or asset name
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            print('Error loading image: $error');
            return Container(); // Return an empty container or placeholder widget if the image fails to load
          },
        ),
      ),
    );
  }
}
