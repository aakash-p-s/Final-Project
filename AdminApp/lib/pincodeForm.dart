import 'dart:convert';

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
                'Details inserted successfully!',
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

class PincodeDetailsForm extends StatefulWidget {
  @override
  _PincodeDetailsFormState createState() => _PincodeDetailsFormState();
}

class _PincodeDetailsFormState extends State<PincodeDetailsForm> {
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _local_placeController = TextEditingController();
  bool _isLoading = false;

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    String pincode = _pincodeController.text.trim();
    String area = _areaController.text.trim();
    String local_place = _local_placeController.text.trim();

    // Check if any field is empty
    if (pincode.isEmpty || area.isEmpty || local_place.isEmpty) {
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
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(area)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'area should only contain characters');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check if last name contains only characters
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(local_place)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'local_place should only contain characters');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Check if phone number is valid
    if (pincode.length != 6 || int.tryParse(pincode) == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
              errorMessage: 'Pincode should be a 6-digit number');
        },
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "pincode": pincode,
      "area": area,
      "local_place": local_place,
    };

    try {
      // Send POST request
      final response = await http.post(
        Uri.parse('http://192.168.43.156:3000/api/insert/areadetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Successful insertion
        print('Pincode details inserted successfully');
        //=========CLEARING=============
        _pincodeController.clear();
        _areaController.clear();
        _local_placeController.clear();
        //==============================
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessDialog();
          },
        );
      } else {
        // Error in insertion
        print('Failed to insert pincode details');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
                errorMessage: 'Failed to insert pincode details');
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
      //   title: Text('Pincode Details Form'),
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
                'assets/images/areadetails.gif', // Replace with the actual path to your image
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
                      controller: _pincodeController,
                      decoration: InputDecoration(
                        labelText: 'Pincode Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(
                            Icons.dialpad), // Icon preceding the text field
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _areaController,
                      decoration: InputDecoration(
                        labelText: 'Area/Taluk',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(
                            Icons.pin_drop), // Icon preceding the text field
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
                      controller: _local_placeController,
                      decoration: InputDecoration(
                        labelText: 'Local Place',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon:
                            Icon(Icons.place), // Icon preceding the text field
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
