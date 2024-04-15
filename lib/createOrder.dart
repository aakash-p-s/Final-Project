// import 'package:contractorpanel/createJob.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// //import 'package:ppppp/createJob.dart';
// //import 'package:insert1/NextPage.dart';
// import 'package:quickalert/quickalert.dart';

// class OrderDetailsPage extends StatefulWidget {
//   @override
//   _OrderDetailsPageState createState() => _OrderDetailsPageState();
// }

// class _OrderDetailsPageState extends State<OrderDetailsPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _orderDateController = TextEditingController();
//   final TextEditingController _expDateController = TextEditingController();
//   final TextEditingController _remarksController = TextEditingController();

//   Future<void> _selectOrderDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         _orderDateController.text =
//             "${picked.day}-${picked.month}-${picked.year}";
//       });
//     }
//   }

//   Future<void> _selectExpDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         _expDateController.text =
//             "${picked.day}-${picked.month}-${picked.year}";
//       });
//     }
//   }

//   Future<void> _submitOrderDetails() async {
//     final String apiUrl = 'http://192.168.43.156:3000/api/insert/orderdetails';

//     final response = await http.post(Uri.parse(apiUrl), body: {
//       'cust_name': _nameController.text,
//       'cust_phno': _phoneController.text,
//       'cust_email': _emailController.text,
//       'delivery_address': _addressController.text,
//       'area_pincode': _pincodeController.text,
//       'order_date': _orderDateController.text,
//       'exp_date': _expDateController.text,
//       'remarks': _remarksController.text,
//     });

//     if (response.statusCode == 200) {
//       // Order details inserted successfully
//       print('Order details inserted successfully');
//       // Show QuickAlert for success
//       Navigator.of(context).pop();

//       // Delay navigation to the next page
//       Future.delayed(Duration(seconds: 0), () {
//         // Navigate to the next page
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   NextPage(cust_email: _emailController.text)),
//         );
//       });

//       // You can navigate to another page or show a success message here
//     } else {
//       // Failed to insert order details
//       print('Failed to insert order details');
//       QuickAlert.show(
//         context: context,
//         type: QuickAlertType.error,
//         title: 'Oops...',
//         text: 'Sorry, something went wrong',
//       );
//       // Handle error here
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter Order Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Customer Name'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _addressController,
//               decoration: InputDecoration(labelText: 'Delivery Address'),
//             ),
//             TextField(
//               controller: _pincodeController,
//               decoration: InputDecoration(labelText: 'Area Pincode'),
//             ),
//             InkWell(
//               onTap: _selectOrderDate,
//               child: IgnorePointer(
//                 child: TextField(
//                   controller: _orderDateController,
//                   decoration: InputDecoration(labelText: 'Order Date'),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: _selectExpDate,
//               child: IgnorePointer(
//                 child: TextField(
//                   controller: _expDateController,
//                   decoration:
//                       InputDecoration(labelText: 'Expected Delivery Date'),
//                 ),
//               ),
//             ),
//             TextField(
//               controller: _remarksController,
//               decoration: InputDecoration(labelText: 'Remarks'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitOrderDetails,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:contractorpanel/contractorHomePage.dart';
import 'package:contractorpanel/createJob.dart';
//import 'package:contractorpanel/tabBarInvoice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:email_validator/email_validator.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _orderDateController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Future<void> _selectOrderDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _orderDateController.text =
            "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  Future<void> _selectExpDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _expDateController.text =
            "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  Future<void> _submitOrderDetails() async {
    // Validate inputs
    if (_nameController.text.isEmpty ||
        !_nameController.text.contains(RegExp(r'^[a-zA-Z\s]+$'))) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Validation Error',
        text: 'Please enter a valid customer name.',
      );
      return;
    }

    if (_phoneController.text.isEmpty ||
        _phoneController.text.length != 10 ||
        !_isNumeric(_phoneController.text)) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Validation Error',
        text: 'Please enter a valid phone number (10 digits).',
      );
      return;
    }

    if (_emailController.text.isEmpty ||
        !EmailValidator.validate(_emailController.text)) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Validation Error',
        text: 'Please enter a valid email address.',
      );
      return;
    }

    if (_pincodeController.text.isEmpty ||
        _pincodeController.text.length != 6 ||
        !_isNumeric(_pincodeController.text)) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Validation Error',
        text: 'Please enter a valid area pincode (6 digits).',
      );
      return;
    }

    if (_orderDateController.text.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Validation Error',
        text: 'Please select an order date.',
      );
      return;
    }

    if (_expDateController.text.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Validation Error',
        text: 'Please select an expected delivery date.',
      );
      return;
    }
    // Validate pincode against areadetails
    final String pincheckUrl =
        'http://192.168.43.156:3000/api/pincheck/fordelivery';

    final pincheckResponse = await http.post(Uri.parse(pincheckUrl), body: {
      'area_pincode': _pincodeController.text,
    });

    if (pincheckResponse.statusCode == 200) {
      // Pincode validation successful, proceed to submit order details

      final String apiUrl =
          'http://192.168.43.156:3000/api/insert/orderdetails';

      final response = await http.post(Uri.parse(apiUrl), body: {
        'cust_name': _nameController.text,
        'cust_phno': _phoneController.text,
        'cust_email': _emailController.text,
        'delivery_address': _addressController.text,
        'area_pincode': _pincodeController.text,
        'order_date': _orderDateController.text,
        'exp_date': _expDateController.text,
        'remarks': _remarksController.text,
      });

      if (response.statusCode == 200) {
        // Order details inserted successfully
        print('Order details inserted successfully');
        // Show QuickAlert for success
        Navigator.of(context).pop();

        // Delay navigation to the next page
        Future.delayed(Duration(seconds: 0), () {
          // Navigate to the next page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NextPage(cust_email: _emailController.text)),
          );
        });

        // You can navigate to another page or show a success message here
      } else {
        // Failed to insert order details
        print('Failed to insert order details');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, something went wrong',
        );
        // Handle error here
      }
    } else {
      // Pincode validation failed
      print('Invalid pincode');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Invalid Pincode',
        text: 'Delivery Not Available',
      );
      // Handle error here
    }
  }

  bool _isNumeric(String str) {
    // if (str == null) {
    //   return false;
    // }
    return double.tryParse(str) != null;
  }

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
//       body: Container(
//         color: Color.fromARGB(255, 245, 239, 5),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         labelText: 'Customer Name',
//                         prefixIcon: Icon(Icons.person),
//                         border: OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: TextField(
//                       controller: _phoneController,
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         prefixIcon: Icon(Icons.phone),
//                         border: OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         prefixIcon: Icon(Icons.email),
//                         border: OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: TextField(
//                       controller: _addressController,
//                       decoration: InputDecoration(
//                         labelText: 'Delivery Address',
//                         prefixIcon: Icon(Icons.location_on),
//                         border: OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _pincodeController,
//                       decoration: InputDecoration(
//                         labelText: 'Area Pincode',
//                         prefixIcon: Icon(Icons.pin_drop),
//                         border: OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: InkWell(
//                       onTap: _selectOrderDate,
//                       child: IgnorePointer(
//                         child: TextField(
//                           controller: _orderDateController,
//                           decoration: InputDecoration(
//                             labelText: 'Order Date',
//                             prefixIcon: Icon(Icons.calendar_today),
//                             border: OutlineInputBorder(),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: _selectExpDate,
//                       child: IgnorePointer(
//                         child: TextField(
//                           controller: _expDateController,
//                           decoration: InputDecoration(
//                             labelText: 'Expected Delivery Date',
//                             prefixIcon: Icon(Icons.calendar_today),
//                             border: OutlineInputBorder(),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: TextField(
//                       controller: _remarksController,
//                       decoration: InputDecoration(
//                         labelText: 'Remarks',
//                         prefixIcon: Icon(Icons.comment),
//                         border: OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitOrderDetails,
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 245, 239, 5),
      child: Scaffold(
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
                  MaterialPageRoute(builder: (context) => ContractorHomePage()),
                );
              },
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 245, 239, 5),
            title: Text('Provide Order Details'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0), // Adjust the value as needed
                bottomRight:
                    Radius.circular(30.0), // Adjust the value as needed
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Image.asset(
              'assets/images/Messenger.gif',
              height: 300,
              width: 300,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Customer Name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone),
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
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                labelText: 'Delivery Address',
                                prefixIcon: Icon(Icons.location_on),
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
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _pincodeController,
                              decoration: InputDecoration(
                                labelText: 'Area Pincode',
                                prefixIcon: Icon(Icons.pin_drop),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: InkWell(
                              onTap: _selectOrderDate,
                              child: IgnorePointer(
                                child: TextField(
                                  controller: _orderDateController,
                                  decoration: InputDecoration(
                                    labelText: 'Order Date',
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: InkWell(
                              onTap: _selectExpDate,
                              child: IgnorePointer(
                                child: TextField(
                                  controller: _expDateController,
                                  decoration: InputDecoration(
                                    labelText: 'Expected Delivery Date',
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _remarksController,
                              decoration: InputDecoration(
                                labelText: 'Remarks',
                                prefixIcon: Icon(Icons.comment),
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
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 70), // Specify padding for left and right
                      child: ElevatedButton(
                        onPressed: _submitOrderDetails,
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
          ],
        ),
      ),
    );
  }
}
