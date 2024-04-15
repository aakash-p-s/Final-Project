import 'dart:async';
import 'package:contractorpanel/contractorHomePage.dart';
import 'package:contractorpanel/driverPages/driverHomePage.dart';
//import 'package:contractorpanel/createJob.dart';
import 'package:contractorpanel/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkSession() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.43.156:3000/api/login/session/contractorpanel'), // Replace with your server API URL
        headers: {'Content-Type': 'application/json'},
      );
      final response1 = await http.get(
        Uri.parse(
            'http://192.168.43.156:3000/api/user-check'), // Replace with your server API URL
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        if (response1.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ContractorHomePage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DriverHomePage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (error) {
      print('Error: $error');
      // Handle error or display error message
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), checkSession);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 239, 5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.gif',
              height: 500,
              width: 500,
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.gesture,
                  size: 12,
                  color: Colors.black,
                ),
                SizedBox(height: 2),
                Text(
                  'DeliHurry',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
