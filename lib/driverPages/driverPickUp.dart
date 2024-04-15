import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:contractorpanel/driverPages/driverHomePage.dart';
import 'package:contractorpanel/driverPages/driverPickUpVerification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PickupPage extends StatefulWidget {
  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  late Future<List<List<String>>> _fetchPickupData;
  late String _otp;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _fetchPickupData = _getPickupData();
    _generateOTP();
  }

  void _generateOTP() {
    _otp = _random.nextInt(10000).toString();
  }

  Future<void> _insertOTPDetails(String email, String otp) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Sending OTP...'),
              ],
            ),
          );
        },
      );

      final response = await http.post(
        Uri.parse('http://192.168.43.156:3000/api/insert/otpdetails2'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'otps': otp,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreenpickup(
              email: 'mrgroove26@gmail.com',
              otp: _otp,
            ),
          ),
        );
      } else {
        throw Exception('Failed to insert OTP details');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<List<String>>> _getPickupData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.156:3000/driverViewPickUp'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) {
          // If data is empty, return an empty list
          return [];
        } else {
          return List<List<String>>.from(
              data.map((item) => List<String>.from(item)));
        }
      } else {
        throw Exception('Failed to load pickup data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriverHomePage()),
              );
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Pick Up Details',
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<List<String>>>(
        future: _fetchPickupData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/pnf.gif',
                    width: 500,
                    height: 500,
                  ),
                ),
                Text(
                  'Server Issues!!!',
                  textAlign: TextAlign.center,
                )
              ],
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/emptydataskeleton.gif',
                      width: 500,
                      height: 500,
                    ),
                  ),
                  Text(
                    'No PickUp data available.!!!',
                    textAlign: TextAlign.center,
                  )
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildPickupTile(snapshot.data![index]);
                },
              );
            }
          }
        },
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints.expand(height: 60, width: double.infinity),
        decoration: BoxDecoration(
          color: Color.fromRGBO(142, 146, 255, 1),
        ),
        child: ElevatedButton(
          onPressed: () {
            _insertOTPDetails('mrgroove26@gmail.com', _otp);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(142, 146, 255, 0.8)),
            elevation: MaterialStateProperty.all<double>(0.0),
          ),
          child: Text(
            'Confirm',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPickupTile(List<String> data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.local_shipping),
        title: Text(data[0]), // Delivery ID
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class PickupPage extends StatefulWidget {
//   @override
//   _PickupPageState createState() => _PickupPageState();
// }

// class _PickupPageState extends State<PickupPage> {
//   late Future<List<List<String>>> _fetchPickupData;
//   late String _otp;
//   final _random = Random();

//   @override
//   void initState() {
//     super.initState();
//     _fetchPickupData = _getPickupData();
//     _generateOTP();
//   }

//   void _generateOTP() {
//     _otp = _random.nextInt(10000).toString();
//   }

//   Future<void> _insertOTPDetails(String email, String otp) async {
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(height: 20),
//                 Text('Sending OTP...'),
//               ],
//             ),
//           );
//         },
//       );

//       final response = await http.post(
//         Uri.parse('http://192.168.43.156:3000/api/insert/otpdetails2'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'email': email,
//           'otps': otp,
//         }),
//       );

//       if (response.statusCode == 200) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OTPScreenpickup(
//               email: 'mrgroove26@gmail.com',
//               otp: _otp,
//             ),
//           ),
//         );
//       } else {
//         throw Exception('Failed to insert OTP details');
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $error'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<List<List<String>>> _getPickupData() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.43.156:3000/driverViewPickUp'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         if (data.isEmpty) {
//           // If data is empty, return an empty list
//           return [];
//         } else {
//           return List<List<String>>.from(
//               data.map((item) => List<String>.from(item)));
//         }
//       } else {
//         throw Exception('Failed to load pickup data');
//       }
//     } catch (error) {
//       throw Exception('Error: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             icon: Icon(
//               Icons.chevron_left,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => DriverHomePage()),
//               );
//             },
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           title: Text(
//             'Pick Up Details',
//             style: TextStyle(color: Colors.white),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//             ),
//           ),
//         ),
//       ),
//       body: FutureBuilder<List<List<String>>>(
//         future: _fetchPickupData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Column(
//               children: [
//                 Center(
//                   child: Image.asset(
//                     'assets/images/pnf.gif',
//                     width: 500,
//                     height: 500,
//                   ),
//                 ),
//                 Text(
//                   'Server Issues!!!',
//                   textAlign: TextAlign.center,
//                 )
//               ],
//             );
//           } else {
//             if (snapshot.data!.isEmpty) {
//               return Column(
//                 children: [
//                   Center(
//                     child: Image.asset(
//                       'assets/images/emptydataskeleton.gif',
//                       width: 500,
//                       height: 500,
//                     ),
//                   ),
//                   Text(
//                     'No PickUp data available.!!!',
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return _buildPickupTile(snapshot.data![index]);
//                 },
//               );
//             }
//           }
//         },
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(snapshot),
//     );
//   }

//   Widget _buildBottomNavigationBar(AsyncSnapshot<List<List<String>>> snapshot) {
//     if (snapshot.hasData && !snapshot.data!.isEmpty) {
//       return Container(
//         constraints: BoxConstraints.expand(height: 60, width: double.infinity),
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(142, 146, 255, 1),
//         ),
//         child: ElevatedButton(
//           onPressed: () {
//             _insertOTPDetails('mrgroove26@gmail.com', _otp);
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(
//                 const Color.fromRGBO(142, 146, 255, 0.8)),
//             elevation: MaterialStateProperty.all<double>(0.0),
//           ),
//           child: Text(
//             'Confirm',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       );
//     } else {
//       return SizedBox(); // Return an empty SizedBox if condition is not met
//     }
//   }

//   Widget _buildPickupTile(List<String> data) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.yellow,
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(Icons.local_shipping),
//         title: Text(data[0]), // Delivery ID
//         trailing: Icon(Icons.chevron_right),
//       ),
//     );
//   }
// }

// class OTPScreenpickup extends StatelessWidget {
//   final String email;
//   final String otp;

//   OTPScreenpickup({required this.email, required this.otp});

//   @override
//   Widget build(BuildContext context) {
//     // Implement your OTP screen UI here
//     return Container();
//   }
// }

// class DriverHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Implement your driver home page UI here
//     return Container();
//   }
// }
