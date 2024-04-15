import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PincodeDisplayPage extends StatefulWidget {
  @override
  _PincodeDisplayPageState createState() => _PincodeDisplayPageState();
}

class _PincodeDisplayPageState extends State<PincodeDisplayPage> {
  List<dynamic> pincodeData = []; // List to store pincode data

  // Function to fetch pincode data from the API
  Future<void> fetchPincodeData() async {
    try {
      // Make GET request to the API
      final response = await http
          .get(Uri.parse('http://192.168.43.156:3000/api/pincode/display'));

      // Check if request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        setState(() {
          pincodeData = jsonDecode(response.body);
        });
      } else {
        // Handle other status codes
        print('Failed to load pincode data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Error fetching pincode data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch pincode data when the page loads
    fetchPincodeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pincode Display'),
      ),
      body: pincodeData.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator if data is being fetched
            )
          : ListView.builder(
              itemCount: pincodeData.length,
              itemBuilder: (context, index) {
                // Extract pincode data for the current index
                var pincodeDetails = pincodeData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(142, 146, 225, 0.8),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      title: Text(
                        pincodeDetails[1], // Display area as title
                        style: TextStyle(
                            color: Colors.red), // Set title text color to red
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text('Local Address: ${pincodeDetails[2]}'),
                          Text('Pincode: ${pincodeDetails[0]}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Navigate to the update page and pass pincode details
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdatePage(
                                      pincodeDetails: pincodeDetails),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Implement delete functionality here
                              // You can use pincodeDetails to get the necessary data for deletion
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// UpdatePage widget
class UpdatePage extends StatelessWidget {
  final dynamic pincodeDetails;

  UpdatePage({required this.pincodeDetails});

  @override
  Widget build(BuildContext context) {
    // Implement UI for the update page
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Update Page'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pincode: ${pincodeDetails[0]}'),
            Text('Area: ${pincodeDetails[1]}'),
            Text('Local Place: ${pincodeDetails[2]}'),
            ElevatedButton(
              onPressed: () {
                // Implement update functionality here
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
