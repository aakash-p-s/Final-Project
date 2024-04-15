// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BillFormPage extends StatefulWidget {
//   final String orderId;

//   const BillFormPage({Key? key, required this.orderId}) : super(key: key);

//   @override
//   _BillFormPageState createState() => _BillFormPageState();
// }

// class _BillFormPageState extends State<BillFormPage> {
//   final TextEditingController deliveryChargeController =
//       TextEditingController();
//   final TextEditingController discountPercentController =
//       TextEditingController();

//   double netSum = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchNetSum();
//   }

//   Future<void> fetchNetSum() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'http://192.168.43.156:3000/jobdetails/netsum/${widget.orderId}'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           netSum = data[0]['SUM(NET_PRICE)'];
//         });
//       } else {
//         throw Exception('Failed to load net sum');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> submitData() async {
//     final String orderId = widget.orderId;
//     final int deliveryCharge = int.tryParse(deliveryChargeController.text) ?? 0;
//     final int discountPercent =
//         int.tryParse(discountPercentController.text) ?? 0;

//     final Map<String, dynamic> postData = {
//       'orderid': orderId,
//       'delivery_charge': deliveryCharge,
//       'discount_percent': discountPercent,
//       'net_sum': netSum,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.43.156:3000/api/insert/invoicedetails'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(postData),
//       );
//       if (response.statusCode == 200) {
//         _showDialog('Success', 'Job details inserted successfully!');
//       } else {
//         _showDialog('Error', 'Failed to insert job details');
//       }
//     } catch (e) {
//       print('Error: $e');
//       _showDialog('Error', 'Failed to insert job details');
//     }
//   }

//   void _showDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bill Form'),
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order ID: ${widget.orderId}',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             const SizedBox(height: 20),
//             TextForm(
//               controller: deliveryChargeController,
//               labelText: 'Delivery Charge',
//             ),
//             SizedBox(height: 10),
//             TextForm(
//               controller: discountPercentController,
//               labelText: 'Discount Percent',
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 submitData();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TextForm extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;

//   const TextForm({
//     Key? key,
//     required this.controller,
//     required this.labelText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }
//import 'package:contractorpanel/contractorHomePage.dart';
import 'package:contractorpanel/tabBarInvoice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BillFormPage extends StatefulWidget {
  final String orderId;

  const BillFormPage({Key? key, required this.orderId}) : super(key: key);

  @override
  _BillFormPageState createState() => _BillFormPageState();
}

class _BillFormPageState extends State<BillFormPage> {
  final TextEditingController deliveryChargeController =
      TextEditingController();
  final TextEditingController discountPercentController =
      TextEditingController();

  double netSum = 0;

  @override
  void initState() {
    super.initState();
    fetchNetSum();
  }

  Future<void> fetchNetSum() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.43.156:3000/jobdetails/netsum/${widget.orderId}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          netSum = data[0]['SUM(NET_PRICE)'];
        });
      } else {
        throw Exception('Failed to load net sum');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> submitData() async {
    final String orderId = widget.orderId;
    final String deliveryChargeText = deliveryChargeController.text.trim();
    final String discountPercentText = discountPercentController.text.trim();

    if (deliveryChargeText.isEmpty ||
        !isNumeric(deliveryChargeText) ||
        double.parse(deliveryChargeText) < 0 ||
        double.parse(deliveryChargeText) > 300) {
      showSnackBar('Delivery charge must be between 0 and 300');
      return;
    }

    if (discountPercentText.isEmpty ||
        !isNumeric(discountPercentText) ||
        double.parse(discountPercentText) < 0 ||
        double.parse(discountPercentText) > 60) {
      showSnackBar('Discount percent must be between 0 and 60');
      return;
    }

    final int deliveryCharge = int.parse(deliveryChargeText);
    final int discountPercent = int.parse(discountPercentText);

    final Map<String, dynamic> postData = {
      'orderid': orderId,
      'delivery_charge': deliveryCharge,
      'discount_percent': discountPercent,
      'net_sum': netSum,
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.156:3000/api/insert/invoicedetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        discountPercentController.clear();
        deliveryChargeController.clear();
        showSnackBar('Job details inserted successfully!');
      } else {
        showSnackBar('Failed to insert job details');
      }
    } catch (e) {
      print('Error: $e');
      showSnackBar('Failed to insert job details');
    }
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Future<void> submitData() async {
  //   final String orderId = widget.orderId;
  //   final String deliveryChargeText = deliveryChargeController.text.trim();
  //   final String discountPercentText = discountPercentController.text.trim();

  //   if (deliveryChargeText.isEmpty ||
  //       !isNumeric(deliveryChargeText) ||
  //       double.parse(deliveryChargeText) < 0 ||
  //       double.parse(deliveryChargeText) > 300) {
  //     _showDialog('Error', 'Delivery charge must be between 0 and 300');
  //     return;
  //   }

  //   if (discountPercentText.isEmpty ||
  //       !isNumeric(discountPercentText) ||
  //       double.parse(discountPercentText) < 0 ||
  //       double.parse(discountPercentText) > 60) {
  //     _showDialog('Error', 'Discount percent must be between 0 and 60');
  //     return;
  //   }

  //   final int deliveryCharge = int.parse(deliveryChargeText);
  //   final int discountPercent = int.parse(discountPercentText);

  //   final Map<String, dynamic> postData = {
  //     'orderid': orderId,
  //     'delivery_charge': deliveryCharge,
  //     'discount_percent': discountPercent,
  //     'net_sum': netSum,
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://192.168.43.156:3000/api/insert/invoicedetails'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(postData),
  //     );
  //     if (response.statusCode == 200) {
  //       _showDialog('Success', 'Job details inserted successfully!');
  //     } else {
  //       _showDialog('Error', 'Failed to insert job details');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     _showDialog('Error', 'Failed to insert job details');
  //   }
  // }

  // bool isNumeric(String value) {
  //   return double.tryParse(value) != null;
  // }

  // void _showDialog(String title, String message) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(message),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bill Form'),
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order ID: ${widget.orderId}',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             const SizedBox(height: 20),
//             TextForm(
//               controller: deliveryChargeController,
//               labelText: 'Delivery Charge',
//             ),
//             SizedBox(height: 10),
//             TextForm(
//               controller: discountPercentController,
//               labelText: 'Discount Percent',
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 submitData();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TextForm extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;

//   const TextForm({
//     Key? key,
//     required this.controller,
//     required this.labelText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Set your desired height here
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the default back button
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              // Navigate to the new screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvoicePage()),
              );
            },
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 245, 239, 5),
          title: Text('Provide Order Details'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0), // Adjust the value as needed
              bottomRight: Radius.circular(30.0), // Adjust the value as needed
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/invoice.gif',
            height: 300,
            width: 300,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.orderId}',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: deliveryChargeController,
                              decoration: InputDecoration(
                                labelText: 'Delivery Charge',
                                prefixIcon: Icon(Icons.bike_scooter),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: discountPercentController,
                              decoration: InputDecoration(
                                labelText: 'Discount Precentage',
                                prefixIcon: Icon(Icons.percent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     submitData();
                    //   },
                    //   child: Text('Submit'),
                    // ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 70), // Specify padding for left and right
                      child: ElevatedButton(
                        onPressed: () {
                          submitData();
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Background color
                          padding: EdgeInsets.symmetric(
                              vertical: 20), // Padding to center
                          fixedSize: Size(200, 60), // Specific height and width
                        ),
                      ),
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
}
