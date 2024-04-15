// import 'package:contractorpanel/invoiceForm.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// //import 'package:ppppp/invoiceForm.dart';
// import 'dart:convert';

// class InvoicePage extends StatefulWidget {
//   @override
//   _InvoicePageState createState() => _InvoicePageState();
// }

// class _InvoicePageState extends State<InvoicePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'Details'),
//             Tab(text: 'Create Invoice'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Details Tab
//           InvoiceDetailsPage(),
//           // Create Invoice Tab
//           OrderListPage(),
//         ],
//       ),
//     );
//   }
// }
// import 'package:contractorpanel/contractorHomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:contractorpanel/invoiceForm.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class InvoicePage extends StatefulWidget {
//   @override
//   _InvoicePageState createState() => _InvoicePageState();
// }

// class _InvoicePageState extends State<InvoicePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // Remove the default back button
//         leading: IconButton(
//           icon: Icon(Icons.chevron_left),
//           onPressed: () {
//             // Navigate to the new screen
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ContractorHomePage()),
//             );
//           },
//         ),
//         title: Text('Invoice'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(45),
//           child: Container(
//             height: 45,
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 245, 239, 5),
//               borderRadius: BorderRadius.circular(25.0),
//             ),
//             child: TabBar(
//               controller: _tabController,
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18.0),
//                 color: Color.fromRGBO(143, 148, 251, 1),
//               ),
//               indicatorSize: TabBarIndicatorSize.tab,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.black,
//               tabs: [
//                 Tab(text: 'Details'),
//                 Tab(text: 'Create Invoice'),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Details Tab
//           InvoiceDetailsPage(),
//           // Create Invoice Tab
//           OrderListPage(),
//         ],
//       ),
//     );
//   }
// }

// //=======================1st page=========================
// class InvoiceDetailsPage extends StatefulWidget {
//   @override
//   _InvoiceDetailsPageState createState() => _InvoiceDetailsPageState();
// }

// class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
//   List<dynamic> invoiceDetails = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchInvoiceDetails();
//   }

//   Future<void> fetchInvoiceDetails() async {
//     try {
//       final response = await http
//           .get(Uri.parse('http://192.168.43.156:3000/api/invoiceready'));
//       if (response.statusCode == 200) {
//         setState(() {
//           invoiceDetails = json.decode(response.body);
//         });
//       } else {
//         throw Exception('Failed to load invoice details');
//       }
//     } catch (error) {
//       print('Error fetching invoice details: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice Details'),
//       ),
//       body: ListView.builder(
//         itemCount: invoiceDetails.length,
//         itemBuilder: (context, index) {
//           final invoiceDetail = invoiceDetails[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: ListTile(
//                     title: Text('${invoiceDetail[0]}'),
//                     subtitle: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Order ID: ${invoiceDetail[1]}'),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color:
//                                       const Color.fromARGB(255, 239, 236, 212),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 padding: EdgeInsets.all(4.0),
//                                 child: Text('Total: ${invoiceDetail[3]} ₹'),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 // Add functionality for editing here
//                               },
//                             ),
//                             SizedBox(width: 8), // Add spacing between icons
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 // Add functionality for deleting here
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10), // Add sized box for separation
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// //=================================2nd tab==========================
// class OrderListPage extends StatefulWidget {
//   @override
//   _OrderListPageState createState() => _OrderListPageState();
// }

// class _OrderListPageState extends State<OrderListPage> {
//   List<String> orderIds = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchOrderIds();
//   }

//   Future<void> fetchOrderIds() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.43.156:3000/api/invoice/not/created'));
//     if (response.statusCode == 200) {
//       setState(() {
//         orderIds = List<String>.from(
//             json.decode(response.body).map((orderId) => orderId[0]));
//       });
//     } else {
//       // Handle error
//       print('Failed to fetch order IDs');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order IDs'),
//       ),
//       body: ListView.builder(
//         itemCount: orderIds.length,
//         itemBuilder: (context, index) {
//           final orderId = orderIds[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: ListTile(
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(orderId),
//                         TextButton(
//                           onPressed: () {
//                             print('Generated invoice for order ID: $orderId');
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         BillFormPage(orderId: orderId)));
//                           },
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.green),
//                             padding: MaterialStateProperty.all(
//                               EdgeInsets.symmetric(
//                                 horizontal: 16.0,
//                                 vertical: 8.0,
//                               ),
//                             ),
//                           ),
//                           child: Text(
//                             'Generate',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10), // Add sized box for separation
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// //==================2nd end=======================================================
// void main() {
//   runApp(MaterialApp(
//     home: OrderListPage(),
//   ));
// }
// import 'package:contractorpanel/contractorHomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:contractorpanel/invoiceForm.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class InvoicePage extends StatefulWidget {
//   @override
//   _InvoicePageState createState() => _InvoicePageState();
// }

// class _InvoicePageState extends State<InvoicePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0), // Set your desired height here
//         child: AppBar(
//           automaticallyImplyLeading: false, // Remove the default back button
//           leading: IconButton(
//             icon: Icon(Icons.chevron_left),
//             onPressed: () {
//               // Navigate to the new screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ContractorHomePage()),
//               );
//             },
//           ),
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 245, 239, 5),
//           title: Text('Invoice'),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30.0), // Adjust the value as needed
//               bottomRight: Radius.circular(30.0), // Adjust the value as needed
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Container(
//               height: 45,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(0, 18, 18, 18),
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(18.0),
//                   color: Colors.black,
//                 ),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.black,
//                 tabs: [
//                   Tab(text: 'Details'),
//                   Tab(text: 'Create Invoice'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   // Details Tab
//                   InvoiceDetailsPage(),
//                   // Create Invoice Tab
//                   OrderListPage(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class InvoiceDetailsPage extends StatefulWidget {
//   @override
//   _InvoiceDetailsPageState createState() => _InvoiceDetailsPageState();
// }

// class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
//   List<dynamic> invoiceDetails = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchInvoiceDetails();
//   }

//   Future<void> fetchInvoiceDetails() async {
//     try {
//       final response = await http
//           .get(Uri.parse('http://192.168.43.156:3000/api/invoiceready'));
//       if (response.statusCode == 200) {
//         setState(() {
//           invoiceDetails = json.decode(response.body);
//         });
//       } else {
//         throw Exception('Failed to load invoice details');
//       }
//     } catch (error) {
//       print('Error fetching invoice details: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: invoiceDetails.length,
//       itemBuilder: (context, index) {
//         final invoiceDetail = invoiceDetails[index];
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 234, 173),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: ListTile(
//                   title: Text('${invoiceDetail[0]}'),
//                   subtitle: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Order ID: ${invoiceDetail[1]}'),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Color.fromARGB(255, 26, 26, 26),
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                               padding: EdgeInsets.all(4.0),
//                               child: Text('Total: ${invoiceDetail[3]} ₹'),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () {
//                               // Add functionality for editing here
//                             },
//                           ),
//                           SizedBox(width: 8), // Add spacing between icons
//                           IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () {
//                               // Add functionality for deleting here
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10), // Add sized box for separation
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class OrderListPage extends StatefulWidget {
//   @override
//   _OrderListPageState createState() => _OrderListPageState();
// }

// class _OrderListPageState extends State<OrderListPage> {
//   List<String> orderIds = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchOrderIds();
//   }

//   Future<void> fetchOrderIds() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.43.156:3000/api/invoice/not/created'));
//     if (response.statusCode == 200) {
//       setState(() {
//         orderIds = List<String>.from(
//             json.decode(response.body).map((orderId) => orderId[0]));
//       });
//     } else {
//       // Handle error
//       print('Failed to fetch order IDs');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: orderIds.length,
//       itemBuilder: (context, index) {
//         final orderId = orderIds[index];
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 241, 234, 173),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: ListTile(
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(orderId),
//                       TextButton(
//                         onPressed: () {
//                           print('Generated invoice for order ID: $orderId');
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       BillFormPage(orderId: orderId)));
//                         },
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.green),
//                           padding: MaterialStateProperty.all(
//                             EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 8.0,
//                             ),
//                           ),
//                         ),
//                         child: Text(
//                           'Generate',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10), // Add sized box for separation
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: InvoicePage(),
//   ));
// }
import 'package:contractorpanel/contractorHomePage.dart';
import 'package:flutter/material.dart';
import 'package:contractorpanel/invoiceForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
                MaterialPageRoute(builder: (context) => ContractorHomePage()),
              );
            },
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 245, 239, 5),
          title: Text('Invoice'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0), // Adjust the value as needed
              bottomRight: Radius.circular(30.0), // Adjust the value as needed
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 18, 18, 18),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.black,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Details'),
                  Tab(text: 'Create Invoice'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Details Tab
                  InvoiceDetailsPage(),
                  // Create Invoice Tab
                  OrderListPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceDetailsPage extends StatefulWidget {
  @override
  _InvoiceDetailsPageState createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  List<dynamic> invoiceDetails = [];

  @override
  void initState() {
    super.initState();
    fetchInvoiceDetails();
  }

  Future<void> fetchInvoiceDetails() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.43.156:3000/api/invoiceready'));
      if (response.statusCode == 200) {
        setState(() {
          invoiceDetails = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load invoice details');
      }
    } catch (error) {
      print('Error fetching invoice details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: invoiceDetails.length,
      itemBuilder: (context, index) {
        final invoiceDetail = invoiceDetails[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  //color: const Color.fromARGB(255, 241, 234, 173),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    // Add functionality to delete here
                    // You can use invoiceDetail or index to identify the item to delete
                  },
                ),
              ),
            ],
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 234, 173),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Column(
                          children: [
                            Text('${invoiceDetail[0]}'),
                          ],
                        ),
                        SizedBox(width: 140),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '${invoiceDetail[3]} ₹',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${invoiceDetail[1]}'),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Add functionality for editing here
                              },
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.info),
                              onPressed: () {
                                // Add functionality for editing here
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  List<String> orderIds = [];

  @override
  void initState() {
    super.initState();
    fetchOrderIds();
  }

  Future<void> fetchOrderIds() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.156:3000/api/invoice/not/created'));
    if (response.statusCode == 200) {
      setState(() {
        orderIds = List<String>.from(
            json.decode(response.body).map((orderId) => orderId[0]));
      });
    } else {
      // Handle error
      print('Failed to fetch order IDs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderIds.length,
      itemBuilder: (context, index) {
        final orderId = orderIds[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  //color: const Color.fromARGB(255, 241, 234, 173),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconSlideAction(
                  caption: 'Details',
                  color: Color.fromARGB(255, 0, 10, 10),
                  icon: Icons.info,
                  onTap: () {
                    // Add functionality to delete here
                    // You can use orderId or index to identify the item to delete
                  },
                ),
              ),
            ],
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 234, 173),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderId),
                        TextButton(
                          onPressed: () {
                            print('Generated invoice for order ID: $orderId');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BillFormPage(orderId: orderId),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'Generate',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: InvoicePage(),
//   ));
// }
