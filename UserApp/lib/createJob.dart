// import 'dart:convert';
// import 'package:contractorpanel/createOrder.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// //import 'package:ppppp/createOrder.dart';
// //import 'package:insert1/page2.dart';

// class NextPage extends StatelessWidget {
//   final String cust_email;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _slnoController = TextEditingController();
//   final TextEditingController _unitpriceController = TextEditingController();
//   final TextEditingController _qntyController = TextEditingController();

//   NextPage({required this.cust_email});

//   Future<void> _submitJobDetails(
//     BuildContext context,
//     String orderid,
//     String productName,
//     int slno,
//     double unitPrice,
//     int qnty,
//   ) async {
//     final String apiUrl = 'http://192.168.43.156:3000/api/insert/jobdetails';

//     try {
//       final response = await http.post(Uri.parse(apiUrl), body: {
//         'orderid': orderid,
//         'product_name': productName,
//         'slno': slno.toString(),
//         'unit_price': unitPrice.toString(),
//         'qnty': qnty.toString(),
//       });

//       if (response.statusCode == 200) {
//         // Job details inserted successfully
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text('Success'),
//             content: Text('Job details inserted successfully!'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       } else {
//         // Failed to insert job details
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to insert job details'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (error) {
//       // Handle any errors during the HTTP request
//       print('Error submitting job details: $error');
//       // You can add further error handling logic here if needed
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(80.0), // Set your desired height here
//         child: AppBar(
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 245, 239, 5),
//           title: Text('Provide Order Details'),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20.0), // Adjust the value as needed
//               bottomRight: Radius.circular(20.0), // Adjust the value as needed
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           // Text(
//           //   'Email:',
//           //   style: TextStyle(fontSize: 20),
//           // ),
//           // SizedBox(height: 10),
//           // Text(
//           //   cust_email,
//           //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           // ),
//           SizedBox(height: 20),
//           TextField(
//             controller: _nameController,
//             decoration: InputDecoration(labelText: 'Product Name'),
//           ),
//           SizedBox(height: 20),
//           TextField(
//             controller: _slnoController,
//             decoration: InputDecoration(labelText: 'Serial Number'),
//           ),
//           SizedBox(height: 20),
//           TextField(
//             controller: _unitpriceController,
//             decoration: InputDecoration(labelText: 'Unit Price'),
//           ),
//           SizedBox(height: 20),
//           TextField(
//             controller: _qntyController,
//             decoration: InputDecoration(labelText: 'Quantity'),
//           ),
//           SizedBox(height: 20),
//           Row(
//             children: [
//               Column(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       final String orderid = await _fetchOrderID(cust_email);
//                       await _submitJobDetails(
//                         context,
//                         orderid,
//                         _nameController.text,
//                         int.parse(_slnoController.text),
//                         double.parse(_unitpriceController.text),
//                         int.parse(_qntyController.text),
//                       );
//                     },
//                     child: Text('Add JOB'),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       final String orderid = await _fetchOrderID(cust_email);
//                       await _fetchRows(
//                         context,
//                         orderid,
//                       );
//                     },
//                     child: Text('Create New order'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future<String> _fetchOrderID(String cust_email) async {
//     final String apiUrl = 'http://192.168.43.156:3000/orderid/email/$cust_email';

//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       final String orderid = data.isNotEmpty ? data[0]['ORDERID'] : '';
//       return orderid;
//     } else {
//       throw Exception('Failed to fetch order ID');
//     }
//   }

//   Future<String> _fetchRows(BuildContext context, String orderid) async {
//     final String apiUrl2 =
//         'http://192.168.43.156:3000/submitbutton/orderid/$orderid';

//     final response1 = await http.get(Uri.parse(apiUrl2));

//     if (response1.statusCode == 200) {
//       // Show alert for successful submission
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text('Success'),
//           content: Text('Order submitted!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 // Navigate to OrderDetailsPage
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => OrderDetailsPage(),
//                   ),
//                 );
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else if (response1.statusCode == 404) {
//       // Show alert for unsuccessful submission
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           backgroundColor: Colors.red, // Set background color to red
//           title: Text('Error'),
//           content: Text('Please insert at least one item'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       throw Exception('Failed '); // Throw an exception for other errors
//     }

//     return ''; // Add a return statement at the end
//   }
// }
// import 'dart:convert';
// import 'package:contractorpanel/createOrder.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class NextPage extends StatelessWidget {
//   final String cust_email;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _slnoController = TextEditingController();
//   final TextEditingController _unitpriceController = TextEditingController();
//   final TextEditingController _qntyController = TextEditingController();

//   NextPage({required this.cust_email});

//   Future<void> _submitJobDetails(
//     BuildContext context,
//     String orderid,
//     String productName,
//     int slno,
//     double unitPrice,
//     int qnty,
//   ) async {
//     final String apiUrl = 'http://192.168.43.156:3000/api/insert/jobdetails';

//     try {
//       final response = await http.post(Uri.parse(apiUrl), body: {
//         'orderid': orderid,
//         'product_name': productName,
//         'slno': slno.toString(),
//         'unit_price': unitPrice.toString(),
//         'qnty': qnty.toString(),
//       });

//       if (response.statusCode == 200) {
//         _qntyController.clear();
//         _unitpriceController.clear();
//         _slnoController.clear();
//         _nameController.clear();
//         // Job details inserted successfully
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text('Success'),
//             content: Text('Job details inserted successfully!'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       } else {
//         // Failed to insert job details
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to insert job details'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (error) {
//       // Handle any errors during the HTTP request
//       print('Error submitting job details: $error');
//       // You can add further error handling logic here if needed
//     }
//   }

//   void _showValidationErrorSnackBar(BuildContext context, String message) {
//     final snackBar = SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.red,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(80.0),
//         child: AppBar(
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 245, 239, 5),
//           title: Text('Provide Job Details'),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20.0),
//               bottomRight: Radius.circular(20.0),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Image.asset(
//             'assets/images/createJob.gif',
//             height: 300,
//             width: 300,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   //mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           //child: Padding(
//                           // padding: const EdgeInsets.only(left: 5),
//                           child: TextField(
//                             controller: _nameController,
//                             decoration: InputDecoration(
//                               labelText: 'Product Name',
//                               prefixIcon: Icon(Icons.interests),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                             ),
//                           ),
//                           //),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           //child: Padding(
//                           // padding: const EdgeInsets.only(right: 5),
//                           child: TextField(
//                             controller: _slnoController,
//                             decoration: InputDecoration(
//                               labelText: 'Serial Number',
//                               prefixIcon: Icon(Icons.pin),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                             ),
//                           ),
//                           // ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           //child: Padding(
//                           //padding: const EdgeInsets.only(left: 5),
//                           child: TextField(
//                             controller: _unitpriceController,
//                             decoration: InputDecoration(
//                               labelText: 'Unit Price',
//                               prefixIcon: Icon(Icons.money),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                             ),
//                             //),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           //child: Padding(
//                           //padding: const EdgeInsets.only(right: 5),
//                           child: TextField(
//                             controller: _qntyController,
//                             decoration: InputDecoration(
//                               labelText: 'Quantity',
//                               prefixIcon:
//                                   Icon(Icons.production_quantity_limits),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                             ),
//                           ),
//                           //),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 30),
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   if (_nameController.text.trim().isEmpty) {
//                                     _showValidationErrorSnackBar(context,
//                                         'Product name cannot be empty');
//                                     return;
//                                   }

//                                   if (!RegExp(r'^[a-zA-Z\s]+$')
//                                       .hasMatch(_nameController.text)) {
//                                     _showValidationErrorSnackBar(context,
//                                         'Product name can only contain characters and white space');
//                                     return;
//                                   }

//                                   if (_slnoController.text.trim().isEmpty) {
//                                     _showValidationErrorSnackBar(context,
//                                         'Serial number cannot be empty');
//                                     return;
//                                   }

//                                   if (int.tryParse(_slnoController.text) ==
//                                       null) {
//                                     _showValidationErrorSnackBar(context,
//                                         'Serial number must be a whole number');
//                                     return;
//                                   }

//                                   if (!RegExp(r'^[0-9]*\.?[0-9]+$')
//                                       .hasMatch(_unitpriceController.text)) {
//                                     _showValidationErrorSnackBar(context,
//                                         'Unit price must be a floating or whole number');
//                                     return;
//                                   }

//                                   if (int.tryParse(_qntyController.text) ==
//                                       null) {
//                                     _showValidationErrorSnackBar(context,
//                                         'Quantity must be a whole number');
//                                     return;
//                                   }

//                                   final String orderid =
//                                       await _fetchOrderID(cust_email);
//                                   await _submitJobDetails(
//                                     context,
//                                     orderid,
//                                     _nameController.text,
//                                     int.parse(_slnoController.text),
//                                     double.parse(_unitpriceController.text),
//                                     int.parse(_qntyController.text),
//                                   );
//                                 },
//                                 child: Text('Add JOB',
//                                     style: TextStyle(color: Colors.white)),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.black, // Background color
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 10), // Padding to center
//                                   fixedSize: Size(
//                                       140, 40), // Specific height and width
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(width: 30),
//                         Column(
//                           children: [
//                             ElevatedButton(
//                               onPressed: () async {
//                                 final String orderid =
//                                     await _fetchOrderID(cust_email);
//                                 await _fetchRows(
//                                   context,
//                                   orderid,
//                                 );
//                               },
//                               child: Text('Create New order',
//                                   style: TextStyle(color: Colors.black)),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Color.fromARGB(
//                                     255, 216, 211, 211), // Background color
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 10), // Padding to center
//                                 fixedSize:
//                                     Size(140, 40), // Specific height and width
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<String> _fetchOrderID(String cust_email) async {
//     final String apiUrl = 'http://192.168.43.156:3000/orderid/email/$cust_email';

//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       final String orderid = data.isNotEmpty ? data[0]['ORDERID'] : '';
//       return orderid;
//     } else {
//       throw Exception('Failed to fetch order ID');
//     }
//   }

//   Future<String> _fetchRows(BuildContext context, String orderid) async {
//     final String apiUrl2 =
//         'http://192.168.43.156:3000/submitbutton/orderid/$orderid';

//     final response1 = await http.get(Uri.parse(apiUrl2));

//     if (response1.statusCode == 200) {
//       // Show alert for successful submission
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text('Success'),
//           content: Text('Order submitted!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 // Navigate to OrderDetailsPage
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => OrderDetailsPage(),
//                   ),
//                 );
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else if (response1.statusCode == 404) {
//       // Show alert for unsuccessful submission
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           backgroundColor: Colors.red,
//           title: Text('Error'),
//           content: Text('Please insert at least one item'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       throw Exception('Failed ');
//     }

//     return '';
//   }
// }
import 'dart:convert';
//import 'package:contractorpanel/contractorHomePage.dart';
import 'package:contractorpanel/createOrder.dart';
//import 'package:contractorpanel/tabBarInvoice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NextPage extends StatelessWidget {
  final String cust_email;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _slnoController = TextEditingController();
  final TextEditingController _unitpriceController = TextEditingController();
  final TextEditingController _qntyController = TextEditingController();

  NextPage({required this.cust_email});

  Future<void> _submitJobDetails(
    BuildContext context,
    String orderid,
    String productName,
    int slno,
    double unitPrice,
    int qnty,
  ) async {
    final String apiUrl = 'http://192.168.43.156:3000/api/insert/jobdetails';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'orderid': orderid,
        'product_name': productName,
        'slno': slno.toString(),
        'unit_price': unitPrice.toString(),
        'qnty': qnty.toString(),
      });

      if (response.statusCode == 200) {
        _qntyController.clear();
        _unitpriceController.clear();
        _slnoController.clear();
        _nameController.clear();
        // Job details inserted successfully
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Success'),
            content: Text('Job details inserted successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Failed to insert job details
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to insert job details'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle any errors during the HTTP request
      print('Error submitting job details: $error');
      // You can add further error handling logic here if needed
    }
  }

  void _showValidationErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the default back button
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () async {
              final String orderid = await _fetchOrderID(cust_email);
              await _fetchRows(
                context,
                orderid,
              );
            },
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 245, 239, 5),
          title: Text('Provide Job Details'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/createJob.gif',
            height: 300,
            width: 300,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          //child: Padding(
                          // padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Product Name',
                              prefixIcon: Icon(Icons.interests),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          //),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          //child: Padding(
                          // padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: _slnoController,
                            decoration: InputDecoration(
                              labelText: 'Serial Number',
                              prefixIcon: Icon(Icons.pin),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          // ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          //child: Padding(
                          //padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: _unitpriceController,
                            decoration: InputDecoration(
                              labelText: 'Unit Price',
                              prefixIcon: Icon(Icons.money),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            //),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          //child: Padding(
                          //padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: _qntyController,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              prefixIcon:
                                  Icon(Icons.production_quantity_limits),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          //),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_nameController.text.trim().isEmpty) {
                                    _showValidationErrorSnackBar(context,
                                        'Product name cannot be empty');
                                    return;
                                  }

                                  if (!RegExp(r'^[a-zA-Z\s]+$')
                                      .hasMatch(_nameController.text)) {
                                    _showValidationErrorSnackBar(context,
                                        'Product name can only contain characters and white space');
                                    return;
                                  }

                                  if (_slnoController.text.trim().isEmpty) {
                                    _showValidationErrorSnackBar(context,
                                        'Serial number cannot be empty');
                                    return;
                                  }

                                  if (int.tryParse(_slnoController.text) ==
                                      null) {
                                    _showValidationErrorSnackBar(context,
                                        'Serial number must be a whole number');
                                    return;
                                  }

                                  if (!RegExp(r'^[0-9]*\.?[0-9]+$')
                                      .hasMatch(_unitpriceController.text)) {
                                    _showValidationErrorSnackBar(context,
                                        'Unit price must be a floating or whole number');
                                    return;
                                  }

                                  if (int.tryParse(_qntyController.text) ==
                                      null) {
                                    _showValidationErrorSnackBar(context,
                                        'Quantity must be a whole number');
                                    return;
                                  }

                                  final String orderid =
                                      await _fetchOrderID(cust_email);
                                  await _submitJobDetails(
                                    context,
                                    orderid,
                                    _nameController.text,
                                    int.parse(_slnoController.text),
                                    double.parse(_unitpriceController.text),
                                    int.parse(_qntyController.text),
                                  );
                                },
                                child: Text('Add JOB',
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, // Background color
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10), // Padding to center
                                  fixedSize: Size(
                                      140, 40), // Specific height and width
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final String orderid =
                                    await _fetchOrderID(cust_email);
                                await _fetchRows(
                                  context,
                                  orderid,
                                );
                              },
                              child: Text('Create New order',
                                  style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(
                                    255, 216, 211, 211), // Background color
                                padding: EdgeInsets.symmetric(
                                    vertical: 10), // Padding to center
                                fixedSize:
                                    Size(140, 40), // Specific height and width
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _fetchOrderID(String cust_email) async {
    final String apiUrl =
        'http://192.168.43.156:3000/orderid/email/$cust_email';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final String orderid = data.isNotEmpty ? data[0]['ORDERID'] : '';
      return orderid;
    } else {
      throw Exception('Failed to fetch order ID');
    }
  }

  Future<String> _fetchRows(BuildContext context, String orderid) async {
    final String apiUrl2 =
        'http://192.168.43.156:3000/submitbutton/orderid/$orderid';

    final response1 = await http.get(Uri.parse(apiUrl2));

    if (response1.statusCode == 200) {
      // Show alert for successful submission
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text('Order submitted!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                // Navigate to OrderDetailsPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if (response1.statusCode == 404) {
      // Show custom dialog for unsuccessful submission
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                size: 64,
                color: Colors.yellow,
              ),
              SizedBox(height: 16),
              Text(
                'Order without job Can\'t exist',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure to delete the order details?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Perform the delete operation
                      final apiUrl =
                          'http://192.168.43.156:3000/api/delete/forcefulback';
                      try {
                        final response = await http.post(
                          Uri.parse(apiUrl),
                          body: {'cust_email': cust_email},
                        );
                        if (response.statusCode == 200) {
                          // Order deleted successfully
                          Navigator.of(context).pop();
                          _showValidationErrorSnackBar(
                              context, 'Order Details Deleted');

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailsPage(),
                            ),
                          );
                        } else {
                          // Failed to delete order details
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to delete order details'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (error) {
                        // Handle any errors during the HTTP request
                        print('Error deleting order details: $error');
                        // You can add further error handling logic here if needed
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      throw Exception('Failed ');
    }

    return '';
  }
}
