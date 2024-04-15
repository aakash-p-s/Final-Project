import 'package:adminpanel/assignmentTabBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MarkedPage extends StatefulWidget {
  final String invoiceId;
  final String deliveryId;
  final String orderId;

  MarkedPage({
    required this.invoiceId,
    required this.deliveryId,
    required this.orderId,
  });

  @override
  _MarkedPageState createState() => _MarkedPageState();
}

class _MarkedPageState extends State<MarkedPage> {
  List<Map<String, dynamic>> _availableDrivers = [];
  int? _selectedDriverIndex;

  @override
  void initState() {
    super.initState();
    fetchAvailableDrivers();
  }

  Future<void> fetchAvailableDrivers() async {
    final response = await http.get(Uri.parse(
        'http://192.168.43.156:3000/delivery/assignment/${widget.orderId}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _availableDrivers = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to fetch available drivers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marked Page'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Available Drivers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildDriverTable(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _selectedDriverIndex != null ? _assignDriver : null,
            style: ElevatedButton.styleFrom(
              elevation: 4, // Add elevation
            ),
            child: Text('Assign'),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.all(0),
        child: DataTable(
          dataRowHeight: 40,
          headingRowHeight: 40,
          columns: <DataColumn>[
            DataColumn(
                label: Text('Assign Driver', style: TextStyle(fontSize: 14))),
            DataColumn(
                label: Text('Driver ID', style: TextStyle(fontSize: 14))),
            DataColumn(
                label: Text('Driver Name', style: TextStyle(fontSize: 14))),
            DataColumn(
                label: Text('Vehicle Type', style: TextStyle(fontSize: 14))),
          ],
          rows: List<DataRow>.generate(
            _availableDrivers.length,
            (index) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Radio(
                      value: index,
                      groupValue: _selectedDriverIndex,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedDriverIndex = value;
                        });
                      },
                    ),
                  ),
                  DataCell(Text(_availableDrivers[index]['DRIVERID'],
                      style: TextStyle(fontSize: 14))),
                  DataCell(Text(_availableDrivers[index]['DRVR_NAME'],
                      style: TextStyle(fontSize: 14))),
                  DataCell(Text(_availableDrivers[index]['VTYPE'],
                      style: TextStyle(fontSize: 14))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _assignDriver() async {
    if (_selectedDriverIndex != null) {
      Map<String, dynamic> selectedDriver =
          _availableDrivers[_selectedDriverIndex!];

      final response = await http.post(
        Uri.parse(
            'http://192.168.43.156:3000/api/insert/assignmentdetailsfor/driver'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'driverid': selectedDriver['DRIVERID'],
          'deliveryid': widget.deliveryId,
          'orderid': widget.orderId,
          'invoiceid': widget.invoiceId,
        }),
      );

      if (response.statusCode == 200) {
        // Insertion successful
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Driver assigned successfully!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Assignmentsheet()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Insertion failed
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to assign driver. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
