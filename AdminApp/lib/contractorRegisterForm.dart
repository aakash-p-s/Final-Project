// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Contractor Details Form',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: ContractorDetailsForm(),
// //     );
// //   }
// // }

// class SuccessDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }

//   Widget contentBox(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(
//             left: 20.0,
//             top: 65.0 + 20.0,
//             right: 20.0,
//             bottom: 20.0,
//           ),
//           margin: EdgeInsets.only(top: 65.0),
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black,
//                 offset: Offset(0, 10),
//                 blurRadius: 10.0,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 'Success!',
//                 style: TextStyle(
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 15.0),
//               Text(
//                 'Contractor details inserted successfully!',
//                 style: TextStyle(fontSize: 14.0),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 22.0),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   child: Text(
//                     'OK',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           left: 20.0,
//           right: 20.0,
//           child: CircleAvatar(
//             backgroundColor: Colors.green,
//             radius: 65.0,
//             child: Icon(
//               Icons.check,
//               color: Colors.white,
//               size: 70.0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ErrorDialog extends StatelessWidget {
//   final String errorMessage;

//   ErrorDialog({required this.errorMessage});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }

//   Widget contentBox(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(
//             left: 20.0,
//             top: 65.0 + 20.0,
//             right: 20.0,
//             bottom: 20.0,
//           ),
//           margin: EdgeInsets.only(top: 65.0),
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black,
//                 offset: Offset(0, 10),
//                 blurRadius: 10.0,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 'Error!',
//                 style: TextStyle(
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 15.0),
//               Text(
//                 errorMessage,
//                 style: TextStyle(fontSize: 14.0),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 22.0),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   child: Text(
//                     'OK',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           left: 20.0,
//           right: 20.0,
//           child: CircleAvatar(
//             backgroundColor: Colors.red,
//             radius: 65.0,
//             child: Icon(
//               Icons.error,
//               color: Colors.white,
//               size: 70.0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ContractorDetailsForm extends StatefulWidget {
//   @override
//   _ContractorDetailsFormState createState() => _ContractorDetailsFormState();
// }

// class _ContractorDetailsFormState extends State<ContractorDetailsForm> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _companyNameController = TextEditingController();

//   void _submitForm() async {
//     String firstName = _firstNameController.text.trim();
//     String lastName = _lastNameController.text.trim();
//     String email = _emailController.text.trim();
//     String phone = _phoneController.text.trim();
//     String address = _addressController.text.trim();
//     String companyName = _companyNameController.text.trim();

//     // Check if any field is empty
//     if (firstName.isEmpty ||
//         lastName.isEmpty ||
//         email.isEmpty ||
//         phone.isEmpty ||
//         address.isEmpty ||
//         companyName.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(errorMessage: 'All fields are required');
//         },
//       );
//       return;
//     }

//     // Check if first name contains only characters
//     if (!RegExp(r'^[a-zA-Z]+$').hasMatch(firstName)) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(
//               errorMessage: 'First name should only contain characters');
//         },
//       );
//       return;
//     }

//     // Check if last name contains only characters
//     if (!RegExp(r'^[a-zA-Z]+$').hasMatch(lastName)) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(
//               errorMessage: 'Last name should only contain characters');
//         },
//       );
//       return;
//     }

//     // Check if company name contains only characters
//     if (!RegExp(r'^[a-zA-Z]+$').hasMatch(companyName)) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(
//               errorMessage: 'Company name should only contain characters');
//         },
//       );
//       return;
//     }

//     // Check if email is valid
//     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(errorMessage: 'Invalid email format');
//         },
//       );
//       return;
//     }

//     // Check if phone number is valid
//     if (phone.length != 10 || int.tryParse(phone) == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(
//               errorMessage: 'Phone number should be a 10-digit number');
//         },
//       );
//       return;
//     }

//     // Generate password
//     String password = firstName + phone.substring(max(0, phone.length - 4));

//     // Construct the request body
//     Map<String, dynamic> requestBody = {
//       "cntr_fname": firstName,
//       "cntr_lname": lastName,
//       "cntr_email": email,
//       "cntr_phno": int.parse(phone),
//       "local_address": address,
//       "company_name": companyName,
//       "pswd": password,
//     };

//     try {
//       // Send POST request
//       final response = await http.post(
//         Uri.parse('http://192.168.43.156:3000/api/insert/cntrdetails'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(requestBody),
//       );

//       if (response.statusCode == 200) {
//         // Successful insertion
//         print('Contractor details inserted successfully');
//         //=========CLEARING=============
//         _firstNameController.clear();
//         _lastNameController.clear();
//         _emailController.clear();
//         _phoneController.clear();
//         _addressController.clear();
//         _companyNameController.clear();
//         //==============================
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return SuccessDialog();
//           },
//         );
//       } else {
//         // Error in insertion
//         print('Failed to insert contractor details');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return ErrorDialog(
//                 errorMessage: 'Failed to insert contractor details');
//           },
//         );
//       }
//     } catch (error) {
//       // Handle network or other errors
//       print('Error: $error');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ErrorDialog(
//               errorMessage: 'An error occurred while submitting the form');
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Contractor Details Form'),
//       // ),
//       body:
//           // Padding(
//           //   padding: EdgeInsets.all(16.0),

//           Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/regbe.png', // Replace with the actual path to your image
//                 width: 200, // Adjust the width as needed
//                 height: 200, // Adjust the height as needed
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 SizedBox(width: 0),
//                 //
//                 Expanded(
//                   child: Container(
//                     child: TextField(
//                       controller: _firstNameController,
//                       decoration: InputDecoration(
//                         labelText: 'First Name',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         prefixIcon:
//                             Icon(Icons.person), // Icon preceding the text field
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Container(
//                     child: TextField(
//                       controller: _lastNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Last Name',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         prefixIcon: Icon(Icons
//                             .perm_identity), // Icon preceding the text field
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         prefixIcon: Icon(Icons
//                             .local_post_office), // Icon preceding the text field
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Container(
//                     child: TextField(
//                       controller: _phoneController,
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         prefixIcon:
//                             Icon(Icons.phone), // Icon preceding the text field
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     child: TextField(
//                       controller: _companyNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Company Name',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         prefixIcon: Icon(
//                             Icons.next_week), // Icon preceding the text field
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Container(
//                     child: TextField(
//                       controller: _addressController,
//                       decoration: InputDecoration(
//                         labelText: 'Local Address',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         prefixIcon: Icon(Icons
//                             .person_pin_circle), // Icon preceding the text field
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 35),
//             ElevatedButton(
//               onPressed: _submitForm,
//               style: ElevatedButton.styleFrom(
//                 primary: const Color.fromRGBO(
//                     143, 148, 251, 0.8), // Change the color here
//               ),
//               child: Text(
//                 'Submit',
//                 style: TextStyle(
//                   color: Colors.black, // Change the color here
// // Adjust the font weight as needed
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 65.0 + 20.0,
            right: 20.0,
            bottom: 20.0,
          ),
          margin: EdgeInsets.only(top: 65.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Success!',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'Contractor details inserted successfully!',
                style: TextStyle(fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22.0),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 65.0,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 70.0,
            ),
          ),
        ),
      ],
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String errorMessage;

  ErrorDialog({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 65.0 + 20.0,
            right: 20.0,
            bottom: 20.0,
          ),
          margin: EdgeInsets.only(top: 65.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Error!',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                errorMessage,
                style: TextStyle(fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22.0),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 65.0,
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: 70.0,
            ),
          ),
        ),
      ],
    );
  }
}

class ContractorDetailsForm extends StatefulWidget {
  @override
  _ContractorDetailsFormState createState() => _ContractorDetailsFormState();
}

class _ContractorDetailsFormState extends State<ContractorDetailsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  bool _isLoading = false;

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String address = _addressController.text.trim();
    String companyName = _companyNameController.text.trim();

    // Check if any field is empty
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        address.isEmpty ||
        companyName.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(errorMessage: 'All fields are required');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check if first name contains only characters
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(firstName)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'First name should only contain characters');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check if last name contains only characters
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(lastName)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'Last name should only contain characters');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check if company name contains only characters
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(companyName)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'Company name should only contain characters');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check if email is valid
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(errorMessage: 'Invalid email format');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check if phone number is valid
    if (phone.length != 10 || int.tryParse(phone) == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'Phone number should be a 10-digit number');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Generate password
    String password = firstName + phone.substring(max(0, phone.length - 4));

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "cntr_fname": firstName,
      "cntr_lname": lastName,
      "cntr_email": email,
      "cntr_phno": int.parse(phone),
      "local_address": address,
      "company_name": companyName,
      "pswd": password,
    };

    try {
      // Send POST request
      final response = await http.post(
        Uri.parse('http://192.168.43.156:3000/api/insert/cntrdetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Successful insertion
        print('Contractor details inserted successfully');
        //=========CLEARING=============
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _addressController.clear();
        _companyNameController.clear();
        //==============================
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessDialog();
          },
        );
      } else {
        // Error in insertion
        print('Failed to insert contractor details');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
                errorMessage: 'Failed to insert contractor details');
          },
        );
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'An error occurred while submitting the form');
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Contractor Details Form'),
      // ),
      body:
          // Padding(
          //   padding: EdgeInsets.all(16.0),

          Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/images/regbe.png', // Replace with the actual path to your image
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 0),
                //
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon:
                            Icon(Icons.person), // Icon preceding the text field
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons
                            .perm_identity), // Icon preceding the text field
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons
                            .local_post_office), // Icon preceding the text field
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon:
                            Icon(Icons.phone), // Icon preceding the text field
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _companyNameController,
                      decoration: InputDecoration(
                        labelText: 'Company Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(
                            Icons.next_week), // Icon preceding the text field
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Local Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons
                            .person_pin_circle), // Icon preceding the text field
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            _isLoading
                ? CircularProgressIndicator() // Display loading indicator
                : ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(
                          143, 148, 251, 0.8), // Change the color here
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.black, // Change the color here
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
