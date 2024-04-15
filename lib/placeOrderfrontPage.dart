// import 'package:contractorpanel/contractorHomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PackagesPage extends StatefulWidget {
//   @override
//   _PackagesPageState createState() => _PackagesPageState();
// }

// class _PackagesPageState extends State<PackagesPage> {
//   List<dynamic> packageDetails = [];

//   Future<void> fetchPackageDetails() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.43.156:3000/api/productready'));

//     if (response.statusCode == 200) {
//       setState(() {
//         packageDetails = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load package details');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchPackageDetails();
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
//       body: ListView.builder(
//         itemCount: packageDetails.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Page2(packageDetails[index][0]),
//                 ),
//               );
//             },
//             child: Container(
//               padding: EdgeInsets.all(16.0),
//               margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 159, 240, 88),
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Text(
//                               '${packageDetails[index][0]}',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 70),
//                       Expanded(child: Icon(Icons.chevron_right)),
//                     ],
//                   ),
//                   SizedBox(height: 5.0),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Text(
//                               '${packageDetails[index][1]}',
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 80),
//                       Expanded(
//                         child: Container(
//                           color: Color.fromARGB(255, 245, 239, 5),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Total: ${packageDetails[index][2]}₹',
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class Page2 extends StatefulWidget {
//   final String orderId;

//   Page2(this.orderId);

//   @override
//   _Page2State createState() => _Page2State();
// }

// class _Page2State extends State<Page2> {
//   List<dynamic> jobDetails = [];
//   List<dynamic> allDetails = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final jobResponse = await http.get(
//         Uri.parse('http://192.168.43.156:3000/jobdetails/${widget.orderId}'));

//     final printResponse = await http.get(
//         Uri.parse('http://192.168.43.156:3000/printdetails/${widget.orderId}'));

//     if (jobResponse.statusCode == 200 && printResponse.statusCode == 200) {
//       setState(() {
//         jobDetails = jsonDecode(jobResponse.body);
//         allDetails = jsonDecode(printResponse.body);
//       });
//     } else {
//       throw Exception('Failed to load details');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Info'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Order Details',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             if (allDetails.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Order ID: ${allDetails[0]['ORDERID']}',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text('Order Status: ${allDetails[0]['ORDER_STATUS']}'),
//                     Text('Order Date: ${allDetails[0]['ORDER_DATE']}'),
//                     Text('Expected Date: ${allDetails[0]['EXP_DATE']}'),
//                     Text('Customer Name: ${allDetails[0]['CUST_NAME']}'),
//                     Text('Customer Email: ${allDetails[0]['CUST_EMAIL']}'),
//                     Text('Customer Phno: ${allDetails[0]['CUST_PHNO']}'),
//                     Text(
//                         'Delivery Address: ${allDetails[0]['DELIVERY_ADDRESS']}'),
//                     Text('Area Pincode: ${allDetails[0]['AREA_PINCODE']}'),
//                     Text('Total: ${allDetails[0]['TOTAL']}'),
//                   ],
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Job Details',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             DataTable(
//               columnSpacing: 10.0,
//               columns: [
//                 DataColumn(
//                   label: Text(
//                     'Job ID',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Product Name',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Quantity',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Unit Price',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Net Price',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//               ],
//               dataRowHeight: 40.0,
//               rows: jobDetails
//                   .map(
//                     (job) => DataRow(
//                       cells: [
//                         DataCell(
//                           Text(
//                             job['JOBID'],
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['PRODUCT_NAME'],
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['QNTY'].toString(),
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['UNIT_PRICE'].toString(),
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['NET_PRICE'].toString(),
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:contractorpanel/contractorHomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PackagesPage extends StatefulWidget {
//   @override
//   _PackagesPageState createState() => _PackagesPageState();
// }

// class _PackagesPageState extends State<PackagesPage> {
//   List<dynamic> packageDetails = [];

//   Future<void> fetchPackageDetails() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.43.156:3000/api/productready'));

//     if (response.statusCode == 200) {
//       setState(() {
//         packageDetails = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load package details');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchPackageDetails();
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
//       body: ListView.builder(
//         itemCount: packageDetails.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Page2(packageDetails[index][0]),
//                 ),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Card(
//                 color: Color.fromARGB(255, 159, 240, 88),
//                 elevation: 5, // Add elevation for shadow
//                 shadowColor: Colors.grey, // Add shadow color
//                 child: Container(
//                   padding: EdgeInsets.all(16.0),
//                   margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   '${packageDetails[index][0]}',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 70),
//                           Expanded(child: Icon(Icons.chevron_right)),
//                         ],
//                       ),
//                       SizedBox(height: 5.0),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   '${packageDetails[index][1]}',
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 80),
//                           Expanded(
//                             child: Container(
//                               color: Color.fromARGB(255, 245, 239, 5),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     '${packageDetails[index][2]}₹',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(right: 15, bottom: 50),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40.0),
//           ),
//           child: FloatingActionButton(
//             onPressed: () {
//               // Add functionality for the floating action button
//             },
//             backgroundColor:
//                 Color.fromARGB(255, 26, 26, 26), // Set background color
//             child: Icon(Icons.upload, color: Colors.white), // Add icon
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Page2 extends StatefulWidget {
//   final String orderId;

//   Page2(this.orderId);

//   @override
//   _Page2State createState() => _Page2State();
// }

// class _Page2State extends State<Page2> {
//   List<dynamic> jobDetails = [];
//   List<dynamic> allDetails = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final jobResponse = await http.get(
//         Uri.parse('http://192.168.43.156:3000/jobdetails/${widget.orderId}'));

//     final printResponse = await http.get(
//         Uri.parse('http://192.168.43.156:3000/printdetails/${widget.orderId}'));

//     if (jobResponse.statusCode == 200 && printResponse.statusCode == 200) {
//       setState(() {
//         jobDetails = jsonDecode(jobResponse.body);
//         allDetails = jsonDecode(printResponse.body);
//       });
//     } else {
//       throw Exception('Failed to load details');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Info'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Order Details',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             if (allDetails.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Order ID: ${allDetails[0]['ORDERID']}',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text('Order Status: ${allDetails[0]['ORDER_STATUS']}'),
//                     Text('Order Date: ${allDetails[0]['ORDER_DATE']}'),
//                     Text('Expected Date: ${allDetails[0]['EXP_DATE']}'),
//                     Text('Customer Name: ${allDetails[0]['CUST_NAME']}'),
//                     Text('Customer Email: ${allDetails[0]['CUST_EMAIL']}'),
//                     Text('Customer Phno: ${allDetails[0]['CUST_PHNO']}'),
//                     Text(
//                         'Delivery Address: ${allDetails[0]['DELIVERY_ADDRESS']}'),
//                     Text('Area Pincode: ${allDetails[0]['AREA_PINCODE']}'),
//                     Text('Total: ${allDetails[0]['TOTAL']}'),
//                   ],
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Job Details',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             DataTable(
//               columnSpacing: 10.0,
//               columns: [
//                 DataColumn(
//                   label: Text(
//                     'Job ID',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Product Name',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Quantity',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Unit Price',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Net Price',
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                 ),
//               ],
//               dataRowHeight: 40.0,
//               rows: jobDetails
//                   .map(
//                     (job) => DataRow(
//                       cells: [
//                         DataCell(
//                           Text(
//                             job['JOBID'],
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['PRODUCT_NAME'],
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['QNTY'].toString(),
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['UNIT_PRICE'].toString(),
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             job['NET_PRICE'].toString(),
//                             style: TextStyle(fontSize: 12.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:contractorpanel/contractorHomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PackagesPage extends StatefulWidget {
  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  List<dynamic> packageDetails = [];
  String contractorId = '';

  Future<void> fetchPackageDetails() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.156:3000/api/productready'));

    if (response.statusCode == 200) {
      setState(() {
        packageDetails = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load package details');
    }
  }

  Future<void> fetchContractorId() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.156:3000/api/contractorid/select'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        contractorId = data[0]
            [0]; // Assuming contractorId is the first element in the array
      });
    } else {
      throw Exception('Failed to load contractor id');
    }
  }

  Future<int> fetchOrderCount() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.156:3000/api/countforloop/select'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data[0][0]; // Assuming the count is the first element in the array
    } else {
      throw Exception('Failed to load order count');
    }
  }

  Future<void> insertDeliveryDetails(
      String invoiceId, String orderId, String contractorId) async {
    final response = await http.post(
      Uri.parse('http://192.168.43.156:3000/api/insert/DELIVERYdetails'),
      body: json.encode({
        'invoiceid': invoiceId,
        'orderid': orderId,
        'cntrid': contractorId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Delivery details inserted successfully');
    } else {
      throw Exception('Failed to insert delivery details');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPackageDetails();
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
      body: ListView.builder(
        itemCount: packageDetails.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page2(packageDetails[index][0]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Color.fromARGB(255, 159, 240, 88),
                elevation: 5, // Add elevation for shadow
                shadowColor: Colors.grey, // Add shadow color
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${packageDetails[index][0]}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 70),
                          Expanded(child: Icon(Icons.chevron_right)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${packageDetails[index][1]}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 80),
                          Expanded(
                            child: Container(
                              color: Color.fromARGB(255, 245, 239, 5),
                              child: Column(
                                children: [
                                  Text(
                                    '${packageDetails[index][2]}₹',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 70),
        child: FloatingActionButton(
          onPressed: () async {
            await fetchContractorId();
            final count = await fetchOrderCount();
            for (int i = 0; i < count; i++) {
              await insertDeliveryDetails(
                  packageDetails[i][3], packageDetails[i][0], contractorId);
            }
          },
          backgroundColor: const Color.fromARGB(255, 247, 222, 4),
          child: Icon(Icons.upload),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  final String orderId;

  Page2(this.orderId);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<dynamic> jobDetails = [];
  List<dynamic> allDetails = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final jobResponse = await http.get(
        Uri.parse('http://192.168.43.156:3000/jobdetails/${widget.orderId}'));

    final printResponse = await http.get(
        Uri.parse('http://192.168.43.156:3000/printdetails/${widget.orderId}'));

    if (jobResponse.statusCode == 200 && printResponse.statusCode == 200) {
      setState(() {
        jobDetails = jsonDecode(jobResponse.body);
        allDetails = jsonDecode(printResponse.body);
      });
    } else {
      throw Exception('Failed to load details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Info'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Order Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            if (allDetails.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: ${allDetails[0]['ORDERID']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Order Status: ${allDetails[0]['ORDER_STATUS']}'),
                    Text('Order Date: ${allDetails[0]['ORDER_DATE']}'),
                    Text('Expected Date: ${allDetails[0]['EXP_DATE']}'),
                    Text('Customer Name: ${allDetails[0]['CUST_NAME']}'),
                    Text('Customer Email: ${allDetails[0]['CUST_EMAIL']}'),
                    Text('Customer Phno: ${allDetails[0]['CUST_PHNO']}'),
                    Text(
                        'Delivery Address: ${allDetails[0]['DELIVERY_ADDRESS']}'),
                    Text('Area Pincode: ${allDetails[0]['AREA_PINCODE']}'),
                    Text('Total: ${allDetails[0]['TOTAL']}'),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Job Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columnSpacing: 10.0,
              columns: [
                DataColumn(
                  label: Text(
                    'Job ID',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Product Name',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Quantity',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Unit Price',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Net Price',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
              dataRowHeight: 40.0,
              rows: jobDetails
                  .map(
                    (job) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            job['JOBID'],
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        DataCell(
                          Text(
                            job['PRODUCT_NAME'],
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        DataCell(
                          Text(
                            job['QNTY'].toString(),
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        DataCell(
                          Text(
                            job['UNIT_PRICE'].toString(),
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        DataCell(
                          Text(
                            job['NET_PRICE'].toString(),
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
