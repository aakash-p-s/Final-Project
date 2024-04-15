import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssignedDriver extends StatefulWidget {
  @override
  _AssignedDriverState createState() => _AssignedDriverState();
}

class _AssignedDriverState extends State<AssignedDriver> {
  List<List<String>> _data = [];
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.43.156:3000/api/foradmin/ASSIGNEDpage/temp'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<List<String>> parsedData =
            responseData.map((item) => List<String>.from(item)).toList();
        setState(() {
          _data = parsedData;
          _isLoading = false;
          _isError = false;
        });
      } else {
        print('Failed to fetch data');
        setState(() {
          _isLoading = false;
          _isError = true;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marked Page Temp'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _isError
              ? Center(
                  child: Image.asset('assets/images/404robot.gif'),
                )
              : _data.isEmpty
                  ? Center(
                      child: Image.asset('assets/images/emptydataskeleton.gif'),
                    )
                  : ListView.builder(
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 4, // Add elevation
                            shadowColor: Color.fromARGB(
                                255, 2, 248, 56), // Add shadow color
                            child: ListTile(
                              leading: Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 2, 248, 56),
                              ),
                              title: Text('Driver ID: ${_data[index][1]}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Delivery ID: ${_data[index][2]}'),
                                  Text('Area: ${_data[index][5]}'),
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
