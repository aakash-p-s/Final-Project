import 'dart:convert';
import 'package:contractorpanel/driverPages/driverDelivery.dart';
//import 'package:contractorpanel/driverPages/driverlogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OTPScreendelivery extends StatefulWidget {
  final String email;
  final String otp;
  final String orderId;
  final String invoiceId;
  final String deliveryId;

  OTPScreendelivery({
    required this.email,
    required this.otp,
    required this.orderId,
    required this.deliveryId,
    required this.invoiceId,
  });

  @override
  _OTPScreendeliveryState createState() => _OTPScreendeliveryState();
}

class _OTPScreendeliveryState extends State<OTPScreendelivery> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (index) => TextEditingController());
    _focusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyOTP(String otp) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.43.156:3000/api/delivery-confirmation/verify-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': widget.email,
          'otps': otp,
          'invoiceId': widget.invoiceId,
          'deliveryId':widget.deliveryId,
          'orderId':widget.orderId,

        }),
      );

      if (response.statusCode == 200) {
        // OTP verification successful, navigate to DriverHomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DeliveryPage()),
        );
      } else {
        // OTP verification failed, show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 5),
                  Text('Error'),
                ],
              ),
              content: Text('Invalid OTP. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      // Show error dialog for any unexpected error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 5),
                Text('Error'),
              ],
            ),
            content: Text('An unexpected error occurred.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/otp2.gif',
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Verify OTP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "OTP is sent to your customer's email",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 20),
                  // Text(
                  //   ${email},
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      for (var i = 0; i < 4; i++)
                        buildOTPTextField(_controllers[i], _focusNodes[i], i),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              String otp = _controllers
                                  .map((controller) => controller.text)
                                  .join();
                              _verifyOTP(otp);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryPage()),
                );
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOTPTextField(
      TextEditingController controller, FocusNode focusNode, int index) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
          } else {
            if (index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          }
        },
        decoration: InputDecoration(
          counter: Offstage(),
          border: InputBorder.none,
        ),
        focusNode: focusNode,
      ),
    );
  }
}
