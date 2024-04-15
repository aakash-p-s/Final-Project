// import 'package:contractorpanel/driverPages/driverlogin.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class DriverHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           automaticallyImplyLeading: false, // Remove the default back button
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           title: Text(
//             'Home Page',
//             style: TextStyle(color: Colors.white),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 8),
//               child: IconButton(
//                 icon: Icon(Icons.settings, color: Colors.white),
//                 onPressed: () {
//                   _showSettingsBottomSheet(context);
//                 },
//               ),
//             ),
//           ],
//           leading: Builder(
//             builder: (context) => IconButton(
//               icon: Icon(Icons.menu, color: Colors.white),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             ),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.black,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.shopping_cart,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     'DelliHurry',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 244, 224, 6),
//               child: ListTile(
//                 leading: Icon(Icons.local_shipping),
//                 title: Text(
//                   'Pick Up',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 1 tap
//                 },
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 48, 117, 237),
//               child: ListTile(
//                 leading: Icon(Icons.motorcycle),
//                 title: Text(
//                   'Delivery',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 2 tap
//                 },
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 17, 240, 36),
//               child: ListTile(
//                 leading: Icon(Icons.motorcycle),
//                 title: Text(
//                   'History',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 2 tap
//                 },
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 0, 0, 0),
//               child: ListTile(
//                 leading: Icon(Icons.motorcycle),
//                 title: Text(
//                   'Reports',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 2 tap
//                 },
//               ),
//             ),
//             // Add more Card widgets for additional items as needed
//           ],
//         ),
//       ),
//       body: Center(
//         child: Text('Welcome to Driver Home Page'),
//       ),
//     );
//   }

//   void _showSettingsBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.account_circle),
//                 title: Text('Account'),
//                 onTap: () {
//                   // Handle account option tap
//                   // Example: Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.exit_to_app),
//                 title: Text('Logout'),
//                 onTap: () {
//                   // Show logout dialog
//                   _showLogoutDialog(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.warning,
//                 color: Colors.orange,
//                 size: 50,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Are You Sure to Logout',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       _performLogout(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                     ),
//                     child: Text(
//                       'Logout',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.white,
//                     ),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _performLogout(BuildContext context) async {
//     final url = 'http://192.168.43.156:3000/contractorsession/logout';

//     try {
//       final response = await http.delete(
//         Uri.parse(url),
//       );

//       if (response.statusCode == 200) {
//         // Logout successful, navigate to LoginScreen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DriverLogin()),
//         );
//       } else {
//         // Display error message
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Logout failed. Please try again.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (error) {
//       // Display error message
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('An error occurred. Please try again later.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
// import 'dart:convert';
// import 'package:contractorpanel/driverPages/driverlogin.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:http/http.dart' as http;

// class DriverHomePage extends StatefulWidget {
//   @override
//   _DriverHomePageState createState() => _DriverHomePageState();
// }

// class _DriverHomePageState extends State<DriverHomePage> {
//   late Future<List<List<String>>> _fetchDeliveryData;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDeliveryData = _getDeliveryData();
//   }
//   Future<List<List<String>>> _getDeliveryData() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.43.156:3000/driverViewNewRequest'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return List<List<String>>.from(
//           data.map((item) => List<String>.from(item)));
//     } else {
//       throw Exception('Failed to load delivery data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           automaticallyImplyLeading: false, // Remove the default back button
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           title: Text(
//             'Home Page',
//             style: TextStyle(color: Colors.white),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 8),
//               child: IconButton(
//                 icon: Icon(Icons.settings, color: Colors.white),
//                 onPressed: () {
//                   _showSettingsBottomSheet(context);
//                 },
//               ),
//             ),
//           ],
//           leading: Builder(
//             builder: (context) => IconButton(
//               icon: Icon(Icons.dashboard, color: Colors.white),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             ),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.black,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.shopping_cart,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     'DelliHurry',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 244, 224, 6),
//               child: ListTile(
//                 leading: Icon(Icons.local_shipping),
//                 title: Text(
//                   'Pick Up',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 1 tap
//                 },
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 48, 117, 237),
//               child: ListTile(
//                 leading: Icon(Icons.motorcycle),
//                 title: Text(
//                   'Delivery',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 2 tap
//                 },
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 17, 240, 36),
//               child: ListTile(
//                 leading: Icon(Icons.motorcycle),
//                 title: Text(
//                   'History',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 2 tap
//                 },
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               shadowColor: Color.fromARGB(255, 0, 0, 0),
//               child: ListTile(
//                 leading: Icon(Icons.motorcycle),
//                 title: Text(
//                   'Reports',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 onTap: () {
//                   // Handle item 2 tap
//                 },
//               ),
//             ),
//             // Add more Card widgets for additional items as needed
//           ],
//         ),
//       ),
//       body: FutureBuilder<List<List<String>>>(
//         future: _fetchDeliveryData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return _buildSlidableDeliveryTile(snapshot.data![index]);
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   void _showSettingsBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.account_circle),
//                 title: Text('Account'),
//                 onTap: () {
//                   // Handle account option tap
//                   // Example: Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.exit_to_app),
//                 title: Text('Logout'),
//                 onTap: () {
//                   // Show logout dialog
//                   _showLogoutDialog(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.warning,
//                 color: Colors.orange,
//                 size: 50,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Are You Sure to Logout',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       _performLogout(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                     ),
//                     child: Text(
//                       'Logout',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.white,
//                     ),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _performLogout(BuildContext context) async {
//     final url = 'http://192.168.43.156:3000/contractorsession/logout';

//     try {
//       final response = await http.delete(
//         Uri.parse(url),
//       );

//       if (response.statusCode == 200) {
//         // Logout successful, navigate to LoginScreen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DriverLogin()),
//         );
//       } else {
//         // Display error message
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Logout failed. Please try again.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (error) {
//       // Display error message
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('An error occurred. Please try again later.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }

// Widget _buildSlidableDeliveryTile(List<String> data) {
//   return Slidable(
//     actionPane: const SlidableDrawerActionPane(),
//     actions: [
//       Container(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: IconSlideAction(
//             caption: 'Cancel',
//             color: Colors.red,
//             icon: Icons.cancel,
//             onTap: () {
//               // Handle cancel action
//             },
//           ),
//         ),
//       ),
//     ],
//     secondaryActions: [
//       Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: IconSlideAction(
//           caption: 'Accept',
//           color: Colors.green,
//           icon: Icons.check,
//           onTap: () {
//             // Handle accept action
//             updateStatusToPickup(data[1]);

//           },
//         ),
//       ),
//     ],
//     child: Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Color.fromRGBO(255, 255, 255, 1),
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromARGB(255, 6, 26, 247).withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 10),
//           ListTile(
//             contentPadding: EdgeInsets.all(16),
//             title: Row(
//               children: [
//                 Icon(Icons.delivery_dining), // Preceding icon
//                 SizedBox(width: 8),
//                 Text(
//                   data[0], // Delivery ID
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(width: 155),
//                 Icon(Icons.chevron_right), // Preceding icon
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Future<void> updateStatusToPickup(String orderId) async {
//   final apiUrl =
//       'http://192.168.43.156:3000/update-status-to-pickup/$orderId'; // Replace 'your_api_url' with your actual API URL

//   try {
//     final response = await http.put(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       print(responseData['message']);
//       // Log success message
//     } else {
//       print('Failed to update status to pickup');
//     }
//   } catch (error) {
//     print('Error updating status to pickup: $error');
//   }
// }
import 'dart:convert';
import 'package:contractorpanel/driverPages/driverDelivery.dart';
import 'package:contractorpanel/driverPages/driverPickUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:contractorpanel/driverPages/driverlogin.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  late Future<List<List<String>>> _fetchDeliveryData;

  @override
  void initState() {
    super.initState();
    _fetchDeliveryData = _getDeliveryData();
  }

  Future<List<List<String>>> _getDeliveryData() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.156:3000/driverViewNewRequest'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isEmpty) {
        // If data is empty, return an empty list
        return [];
      } else {
        return List<List<String>>.from(
            data.map((item) => List<String>.from(item)));
      }
    } else {
      throw Exception('Failed to load delivery data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the default back button
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  _showSettingsBottomSheet(context);
                },
              ),
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'DelliHurry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Color.fromARGB(255, 244, 224, 6),
              child: ListTile(
                leading: Icon(Icons.local_shipping),
                title: Text(
                  'Pick Up',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PickupPage()),
                  );
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Color.fromARGB(255, 48, 117, 237),
              child: ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text(
                  'Delivery',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeliveryPage()),
                  );
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Color.fromARGB(255, 17, 240, 36),
              child: ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text(
                  'History',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Handle item 2 tap
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Color.fromARGB(255, 0, 0, 0),
              child: ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text(
                  'Reports',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Handle item 2 tap
                },
              ),
            ),
            // Add more Card widgets for additional items as needed
          ],
        ),
      ),
      body: //RefreshIndicator(
          //// onRefresh: () {
          //  return _getDeliveryData();
          // },
          // child:
          FutureBuilder<List<List<String>>>(
        future: _fetchDeliveryData,
        builder: (context, snapshot) {
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
                  'Server Error!!!',
                  textAlign: TextAlign.center,
                ),
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
                    'No New Tasks',
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildSlidableDeliveryTile(snapshot.data![index]);
                },
              );
            }
          }
        },
      ),
      // ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Account'),
                onTap: () {
                  // Handle account option tap
                  // Example: Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  // Show logout dialog
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: Colors.orange,
                size: 50,
              ),
              SizedBox(height: 20),
              Text(
                'Are You Sure to Logout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _performLogout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    final url = 'http://192.168.43.156:3000/contractorsession/logout';

    try {
      final response = await http.delete(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        // Logout successful, navigate to LoginScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DriverLogin()),
        );
      } else {
        // Display error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Logout failed. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Display error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildSlidableDeliveryTile(List<String> data) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actions: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconSlideAction(
              caption: 'Cancel',
              color: Colors.red,
              icon: Icons.cancel,
              onTap: () {
                // Handle cancel action
              },
            ),
          ),
        ),
      ],
      secondaryActions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconSlideAction(
            caption: 'Accept',
            color: Colors.green,
            icon: Icons.check,
            onTap: () {
              _updateStatusToPickup(data[1]);
            },
          ),
        ),
      ],
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 6, 26, 247).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Row(
                children: [
                  Icon(Icons.delivery_dining), // Preceding icon
                  SizedBox(width: 8),
                  Text(
                    data[0], // Delivery ID
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 155),
                  Icon(Icons.chevron_right), // Preceding icon
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateStatusToPickup(String orderId) async {
    final apiUrl =
        'http://192.168.43.156:3000/update-status-to-pickup/$orderId';

    try {
      final response = await http.put(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData['message']); // Log success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Status updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          // Reload the page
          _fetchDeliveryData = _getDeliveryData();
        });
      } else {
        print('Failed to update status to pickup');
      }
    } catch (error) {
      print('Error updating status to pickup: $error');
    }
  }
}
