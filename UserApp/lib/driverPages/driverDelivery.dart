// import 'package:contractorpanel/driverPages/driverHomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DeliveryPage extends StatefulWidget {
//   @override
//   _DeliveryPageState createState() => _DeliveryPageState();
// }

// class _DeliveryPageState extends State<DeliveryPage> {
//   late Future<List<List<String>>> _fetchDeliveryData;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDeliveryData = _getDeliveryData();
//   }

//   Future<List<List<String>>> _getDeliveryData() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.43.156:3000/driverViewDelivery'),
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
//             'Delivery Details',
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
//         future: _fetchDeliveryData,
//         builder: (context, snapshot) {
//           try {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Image.asset(
//                   'assets/images/pnf.gif',
//                   width: 200,
//                   height: 200,
//                 ),
//               );
//             } else {
//               if (snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Image.asset(
//                     'assets/images/emptydataskeleton.gif',
//                     width: 200,
//                     height: 200,
//                   ),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     return _buildPickupTile(snapshot.data![index]);
//                   },
//                 );
//               }
//             }
//           } catch (error) {
//             print('Error: $error');
//             return Center(
//               child: Text('An error occurred. Please try again later.'),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildPickupTile(List<String> data) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blue,
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(Icons.local_shipping),
//         title: Text(data[0]), // Delivery ID
//         trailing: ElevatedButton(
//           onPressed: () {
//             // Add functionality for completing the delivery
//           },
//           style: ElevatedButton.styleFrom(
//             primary: Colors.green,
//           ),
//           child: Text(
//             'Complete',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DeliveryPage extends StatefulWidget {
//   @override
//   _DeliveryPageState createState() => _DeliveryPageState();
// }

// class _DeliveryPageState extends State<DeliveryPage> {
//   late Future<List<List<String>>> _fetchDeliveryData;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDeliveryData = _getDeliveryData();
//   }

//   Future<List<List<String>>> _getDeliveryData() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.43.156:3000/driverViewDelivery'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         if (data.isEmpty) {
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
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           title: Text(
//             'Delivery Details',
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
//         future: _fetchDeliveryData,
//         builder: (context, snapshot) {
//           try {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else {
//               if (snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text('No delivery data available.'),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     return _buildPickupTile(snapshot.data![index]);
//                   },
//                 );
//               }
//             }
//           } catch (error) {
//             print('Error: $error');
//             return Center(
//               child: Text('An error occurred. Please try again later.'),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildPickupTile(List<String> data) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DeliveryDetailsPage(
//               deliveryId: data[0],
//               orderId: data[1],
//               invoiceId: data[2],
//             ),
//           ),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blue,
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: ListTile(
//           leading: Icon(Icons.local_shipping),
//           title: Text(data[0]), // Delivery ID
//           trailing: ElevatedButton(
//             onPressed: () {
//               // Add functionality for completing the delivery
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.green,
//             ),
//             child: Text(
//               'Complete',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DeliveryDetailsPage extends StatelessWidget {
//   final String deliveryId;
//   final String orderId;
//   final String invoiceId;

//   DeliveryDetailsPage({
//     required this.deliveryId,
//     required this.orderId,
//     required this.invoiceId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Delivery Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Delivery ID: $deliveryId'),
//             Text('Order ID: $orderId'),
//             Text('Invoice ID: $invoiceId'),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:contractorpanel/driverDeliveryVerification.dart';
import 'package:contractorpanel/driverPages/driverHomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  late Future<List<List<String>>> _fetchDeliveryData;
  late String _otp;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _fetchDeliveryData = _getDeliveryData();
    _generateOTP();
  }

  void _generateOTP() {
    _otp = _random.nextInt(10000).toString();
  }

  Future<void> _insertOTPDetails(String email, String otp, String orderId,
      String invoiceId, String deliveryId) async {
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
        Uri.parse('http://192.168.43.156:3000/api/insert/otpdetails3'),
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
            builder: (context) => OTPScreendelivery(
              email: email,
              otp: _otp,
              deliveryId: deliveryId,
              invoiceId: invoiceId,
              orderId: orderId,
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

  Future<List<List<String>>> _getDeliveryData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.156:3000/driverViewDelivery'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isEmpty) {
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
            'Delivery Details',
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
        future: _fetchDeliveryData,
        builder: (context, snapshot) {
          try {
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
                      'No delivery data available.!!!',
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
          } catch (error) {
            print('Error: $error');
            return Center(
              child: Text('An error occurred. Please try again later.'),
            );
          }
        },
      ),
    );
  }

  Widget _buildPickupTile(List<String> data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeliveryDetailsPage(
              deliveryId: data[0],
              orderId: data[1],
              invoiceId: data[2],
              completeDelivery: _completeDelivery,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(Icons.local_shipping),
          title: Text(data[0]), // Delivery ID
          trailing: ElevatedButton(
            onPressed: () {
              _completeDelivery(
                  data[1],
                  data[0],
                  data[
                      2]); // Pass orderId, deliveryId, invoiceId to completeDelivery method
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            child: Text(
              'Complete',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _completeDelivery(
      String orderId, String deliveryId, String invoiceId) async {
    try {
      final emailResponse = await http.get(
        Uri.parse(
            'http://192.168.43.156:3000/cust-email/deliveryverification/$orderId'),
      );

      if (emailResponse.statusCode == 200) {
        final List<dynamic> emailData = jsonDecode(emailResponse.body);
        if (emailData.isNotEmpty) {
          final String email =
              emailData.first['CUST_EMAIL']; // Extract email from the response

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DeliveryCompletionPage(
          //       email: email,
          //       deliveryId: deliveryId,
          //       invoiceId: invoiceId,
          //       orderId: orderId,
          //     ),
          //   ),
          // );
          _insertOTPDetails(email, _otp, orderId, invoiceId, deliveryId);
        } else {
          throw Exception('Email not found');
        }
      } else {
        throw Exception('Failed to fetch email');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}

class DeliveryDetailsPage extends StatelessWidget {
  final String deliveryId;
  final String orderId;
  final String invoiceId;
  final Function(String, String, String) completeDelivery;

  DeliveryDetailsPage({
    required this.deliveryId,
    required this.orderId,
    required this.invoiceId,
    required this.completeDelivery,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Delivery ID: $deliveryId'),
            Text('Order ID: $orderId'),
            Text('Invoice ID: $invoiceId'),
          ],
        ),
      ),
    );
  }
}

class DeliveryCompletionPage extends StatelessWidget {
  final String email;
  final String deliveryId;
  final String invoiceId;
  final String orderId;

  DeliveryCompletionPage({
    required this.email,
    required this.deliveryId,
    required this.invoiceId,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Completion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: $email'),
            Text('Delivery ID: $deliveryId'),
            Text('Invoice ID: $invoiceId'),
            Text('Order ID: $orderId'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Delivery App',
    home: DeliveryPage(),
  ));
}
