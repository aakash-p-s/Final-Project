// // //common nav bar
// // import 'package:flutter/material.dart';

// // class ContractorHomePage extends StatefulWidget {
// //   ContractorHomePage({Key? key}) : super(key: key);

// //   @override
// //   _ContractorHomePageState createState() => _ContractorHomePageState();
// // }

// // class _ContractorHomePageState extends State<ContractorHomePage> {
// //   int _currentIndex = 0;

// //   final List<Widget> _pages = [
// //     Page1(),
// //     Page2(),
// //     Page3(),
// //   ];

// //   void _onTabTapped(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _pages[_currentIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: _onTabTapped,
// //         items: [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home,
// //                 color: _currentIndex == 0 ? Colors.blue : Colors.black),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.person,
// //                 color: _currentIndex == 1 ? Colors.blue : Colors.black),
// //             label: 'Person',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.earbuds,
// //                 color: _currentIndex == 2 ? Colors.blue : Colors.black),
// //             label: 'Reports',
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class Page1 extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text('Page 1'),
// //     );
// //   }
// // }

// // class Page2 extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text('Page 2'),
// //     );
// //   }
// // }

// // class Page3 extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text('Page 3'),
// //     );
// //   }
// // }
// // //=============================================================================
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Floating Bottom Navbar Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: ContractorHomePage(),
//     );
//   }
// }

// class ContractorHomePage extends StatefulWidget {
//   ContractorHomePage({Key? key}) : super(key: key);

//   @override
//   _ContractorHomePageState createState() => _ContractorHomePageState();
// }

// class _ContractorHomePageState extends State<ContractorHomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     Page1(),
//     Page2(),
//     Page3(),
//   ];

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: ClipRRect(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(
//               top: BorderSide(color: Colors.black.withOpacity(0.2)),
//             ),
//           ),
//           child: BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: _onTabTapped,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home,
//                     color: _currentIndex == 0 ? Colors.blue : Colors.black),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person,
//                     color: _currentIndex == 1 ? Colors.blue : Colors.black),
//                 label: 'Person',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.earbuds,
//                     color: _currentIndex == 2 ? Colors.blue : Colors.black),
//                 label: 'Reports',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page 1'),
//     );
//   }
// }

// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page 2'),
//     );
//   }
// }

// class Page3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Page 3'),
//     );
//   }
// }

//=================================================================================
import 'package:contractorpanel/createOrder.dart';
import 'package:contractorpanel/tabBarInvoice.dart';
import 'package:contractorpanel/placeOrderfrontPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryDetailsPage extends StatefulWidget {
  @override
  _DeliveryDetailsPageState createState() => _DeliveryDetailsPageState();
}

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
  List<dynamic> deliveryDetails = [];
  bool isLoading = true;

  Future<void> fetchDeliveryDetails() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.156:3000/api/deliverydetails'));

    if (response.statusCode == 200) {
      setState(() {
        deliveryDetails = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load delivery details');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDeliveryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: deliveryDetails.length,
              itemBuilder: (context, index) {
                var detail = deliveryDetails[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 234, 173),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'Order ID: ${detail[0]}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      subtitle: Text(
                        'Order Status: ${detail[9]}',
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Page2(deliveryDetails[index][0]),
                                ),
                              );

                              print('Info icon clicked');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Handle update icon click
                              print('Update icon clicked');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Handle delete icon click
                              print('Delete icon clicked');
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

class ContractorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order Details'),
        backgroundColor: Color.fromARGB(255, 245, 239, 5),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 234, 132),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'DelliHurry',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Create Order'),
              leading: Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Place Order'),
              leading: Icon(Icons.bike_scooter_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PackagesPage()),
                );
              },
            ),
            ListTile(
              title: Text('Invoice'),
              leading: Icon(Icons.currency_rupee_sharp),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvoicePage()),
                );
              },
            ),
            ListTile(
              title: Text('Reports'),
              leading: Icon(Icons.receipt),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Back Layer with Image Background
          Container(
            child: Center(
              child: Container(
                color: Color.fromARGB(255, 245, 239, 5),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                  left: 40.0,
                ),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 280,
                        height: 35,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Search OrderID',
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // Handle filter icon click
                          print('Filter icon clicked');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.filter_list),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Front Layer (White with rounded top-left corner)
          Positioned(
            top: 45,
            left: 5,
            right: 5,
            bottom: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(236, 245, 241, 241),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0),
                ),
              ),
              child:
                  DeliveryDetailsPage(), // Replace this with DeliveryDetailsPage
            ),
          ),
        ],
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
    // Fetch job details
    final jobResponse = await http.get(
        Uri.parse('http://192.168.43.156:3000/jobdetails/${widget.orderId}'));

    // Fetch order details
    final printResponse = await http.get(
        Uri.parse('http://192.168.43.156:3000/orderdetails/${widget.orderId}'));

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
