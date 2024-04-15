import 'package:adminpanel/assigned.dart';
import 'package:adminpanel/assignmentTabBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';

class MarkedPageTemp extends StatefulWidget {
  @override
  _MarkedPageTempState createState() => _MarkedPageTempState();
}

class _MarkedPageTempState extends State<MarkedPageTemp> {
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
      final response = await http.get(
          Uri.parse('http://192.168.43.156:3000/api/foradmin/markedpage/temp'));
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

  Future<void> updateAssignmentDetails() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true); // Close the dialog
          });

          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Submitting Details...'),
              ],
            ),
          );
        },
      );

      final response = await http.put(
        Uri.parse(
            'http://192.168.43.156:3000/api/update-assignment-details/final'),
      );
      if (response.statusCode == 200) {
        Future.delayed(Duration(seconds: 3), () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Records updated successfully'),
          ));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Assignmentsheet(),
            ),
          ).then((_) {
            // Once Assignmentsheet page is pushed and popped,
            // animate to the Assigned tab.
            AssignedDriver();
          });
        });
        // Perform any additional actions after successful update
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update records'),
        ));
      }
    } catch (error) {
      print('Error updating records: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update records'),
      ));
    }
  }

  Future<void> deleteDelivery(String deliveryId) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.43.156:3000/api/update-delivery/foradmin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'deliveryId': deliveryId,
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Deleted successfully'),
        ));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Assignmentsheet()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to delete'),
        ));
      }
    } catch (error) {
      print('Error deleting delivery: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Marked Page Temp'),
      // ),
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
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actions: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconSlideAction(
                                    caption: 'Remove',
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    icon: Icons.delete,
                                    onTap: () {
                                      deleteDelivery(_data[index][2]);
                                    },
                                  ),
                                ),
                              ),
                            ],
                            child: Card(
                              elevation: 4,
                              shadowColor:
                                  const Color.fromARGB(255, 0, 138, 250),
                              child: ListTile(
                                leading: Icon(
                                  Icons.check_circle,
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
                          ),
                        );
                      },
                    ),
      bottomNavigationBar: !_isError && !_data.isEmpty
          ? Container(
              constraints:
                  BoxConstraints.expand(height: 60, width: double.infinity),
              decoration: BoxDecoration(
                color: Color.fromRGBO(142, 146, 255,
                    1), // Specify the background color of the button
              ),
              child: ElevatedButton(
                onPressed: () {
                  updateAssignmentDetails();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(142, 146, 255, 0.8)),
                  elevation: MaterialStateProperty.all<double>(
                      0.0), // Specify the background color
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white, // Specify the text color
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
// import 'package:adminpanel/assigned.dart';
// import 'package:adminpanel/assignmentTabBar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class MarkedPageTemp extends StatefulWidget {
//   @override
//   _MarkedPageTempState createState() => _MarkedPageTempState();
// }

// class _MarkedPageTempState extends State<MarkedPageTemp> {
//   List<List<String>> _data = [];
//   bool _isLoading = true;
//   bool _isError = false;
//   late Future<List<List<dynamic>>> _datas;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     _datas = fetchDatas();
//   }

//   Future<List<List<dynamic>>> fetchDatas() async {
//     final response1 = await http
//         .get(Uri.parse('http://192.168.43.156:3000/api/horizontal-list-tile'));
//     if (response1.statusCode == 200) {
//       return List<List<dynamic>>.from(json.decode(response1.body));
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(
//           Uri.parse('http://192.168.43.156:3000/api/foradmin/markedpage/temp'));
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         final List<List<String>> parsedData =
//             responseData.map((item) => List<String>.from(item)).toList();
//         setState(() {
//           _data = parsedData;
//           _isLoading = false;
//           _isError = false;
//         });
//       } else {
//         print('Failed to fetch data');
//         setState(() {
//           _isLoading = false;
//           _isError = true;
//         });
//       }
//     } catch (error) {
//       print('Error fetching data: $error');
//       setState(() {
//         _isLoading = false;
//         _isError = true;
//       });
//     }
//   }

//   Future<void> updateAssignmentDetails() async {
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           Future.delayed(Duration(seconds: 3), () {
//             Navigator.of(context).pop(true); // Close the dialog
//           });

//           return AlertDialog(
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(height: 20),
//                 Text('Submitting Details...'),
//               ],
//             ),
//           );
//         },
//       );

//       final response = await http.put(Uri.parse(
//           'http://192.168.43.156:3000/api/update-assignment-details/final'));
//       if (response.statusCode == 200) {
//         Future.delayed(Duration(seconds: 3), () {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Records updated successfully'),
//           ));

//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Assignmentsheet(),
//             ),
//           ).then((_) {
//             // Once Assignmentsheet page is pushed and popped,
//             // animate to the Assigned tab.
//             AssignedDriver();
//           });
//         });
//         // Perform any additional actions after successful update
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to update records'),
//         ));
//       }
//     } catch (error) {
//       print('Error updating records: $error');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to update records'),
//       ));
//     }
//   }

//   Future<void> deleteDelivery(String deliveryId) async {
//     try {
//       final response = await http.put(
//         Uri.parse('http://192.168.43.156:3000/api/update-delivery/foradmin'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'deliveryId': deliveryId,
//         }),
//       );
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Deleted successfully'),
//         ));
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Assignmentsheet()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to delete'),
//         ));
//       }
//     } catch (error) {
//       print('Error deleting delivery: $error');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to delete'),
//       ));
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : _isError
//               ? Center(
//                   child: Image.asset('assets/images/404robot.gif'),
//                 )
//               : _data.isEmpty
//                   ? Center(
//                       child: Image.asset('assets/images/emptydataskeleton.gif'),
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: FutureBuilder(
//                               future: _datas,
//                               builder: (context,
//                                   AsyncSnapshot<List<List<dynamic>>> snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return Center(
//                                       child: CircularProgressIndicator());
//                                 } else if (snapshot.hasError) {
//                                   return Center(
//                                       child: Text('Error: ${snapshot.error}'));
//                                 } else {
//                                   final data = snapshot.data!;
//                                   return Row(
//                                     children: data.map((item) {
//                                       final color = _getColor(item);
//                                       return Container(
//                                         height: 200,
//                                         child: BlockWidget(
//                                           key: UniqueKey(),
//                                           area: item[0],
//                                           drivers: item[2],
//                                           assigned: item[1],
//                                           color: Colors.green,
//                                           icon:
//                                               Icons.home, // Set icon as needed
//                                         ),
//                                       );
//                                     }).toList(),
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                         if (_data.isNotEmpty)
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: _data.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 8, right: 8, bottom: 8),
//                                   child: Slidable(
//                                     actionPane: SlidableDrawerActionPane(),
//                                     actions: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: IconSlideAction(
//                                             caption: 'Remove',
//                                             color: Color.fromARGB(
//                                                 255, 255, 255, 255),
//                                             icon: Icons.delete,
//                                             onTap: () {
//                                               deleteDelivery(_data[index][2]);
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                     child: Card(
//                                       elevation: 4,
//                                       shadowColor: const Color.fromARGB(
//                                           255, 0, 138, 250),
//                                       child: ListTile(
//                                         leading: Icon(
//                                           Icons.check_circle,
//                                         ),
//                                         title: Text(
//                                             'Driver ID: ${_data[index][1]}'),
//                                         subtitle: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                                 'Delivery ID: ${_data[index][2]}'),
//                                             Text('Area: ${_data[index][5]}'),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         if (!_isError && !_data.isEmpty)
//                           Container(
//                             constraints: BoxConstraints.expand(
//                                 height: 60, width: double.infinity),
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(142, 146, 255,
//                                   1), // Specify the background color of the button
//                             ),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 updateAssignmentDetails();
//                               },
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all<
//                                         Color>(
//                                     const Color.fromRGBO(142, 146, 255, 0.8)),
//                                 elevation: MaterialStateProperty.all<double>(
//                                     0.0), // Specify the background color
//                               ),
//                               child: Text(
//                                 'Confirm',
//                                 style: TextStyle(
//                                   color: Colors.white, // Specify the text color
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//     );
//   }

//   Future<Color> _getColor(List<dynamic> item) async {
//     final data = await _datas;
//     final index = data.indexOf(item);
//     if (index != -1) {
//       switch (index % 3) {
//         case 0:
//           return Colors.green;
//         case 1:
//           return Colors.orange;
//         case 2:
//           return Colors.blue;
//         default:
//           return Colors.green;
//       }
//     }
//     return Colors.green; // Default color if index is not found
//   }
// }

// class BlockWidget extends StatelessWidget {
//   final String area;
//   final int drivers;
//   final int assigned;
//   final Color color;
//   final IconData icon;

//   const BlockWidget({
//     required Key key,
//     required this.area,
//     required this.drivers,
//     required this.assigned,
//     required this.color,
//     required this.icon,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 50,
//             color: Colors.white,
//           ),
//           SizedBox(height: 10),
//           Text(
//             area,
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(
//             'Drivers: $drivers',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//           Text(
//             'Deliveries: $assigned',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
