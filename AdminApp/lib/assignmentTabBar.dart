//import 'package:adminpanel/pincodeForm.dart';
//import 'package:adminpanel/pincodeTileDisplay.dart';
import 'package:adminpanel/adminpanel.dart';
import 'package:adminpanel/assigned.dart';
import 'package:adminpanel/displaytileDelivery.dart';
import 'package:adminpanel/marked2.dart';
import 'package:flutter/material.dart';
//import 'package:pincode/pincodeForm.dart';
//import 'package:pincode/pincodeTileDisplay.dart';

class Assignmentsheet extends StatefulWidget {
  @override
  _AssignmentsheetState createState() => _AssignmentsheetState();
}

class _AssignmentsheetState extends State<Assignmentsheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Back Layer with Image Background
          Container(
            color: Color.fromARGB(255, 143, 148, 251), // Semi-transparent black color
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BackdropPageDashBoard()),
                          );
                        },
                        child: Icon(
                          Icons.chevron_left,
                          size: 30.0,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    Text(
                      'Delivery Assignment',
                      style: const TextStyle(
                        fontSize: 24.0,
                        // fontFamily: 'Caveat',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Front Layer with White Background and Rounded Top-Left Corner
          Positioned(
            top: 100,
            left: 5,
            right: 5,
            bottom: 0, // Reduced bottom padding for bottom navigation bar
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                ),
              ),
              padding: EdgeInsets.only(top: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // give the tab bar a height [can change height to preferred height]
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: TabBar(
                          controller: _tabController,
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              18.0,
                            ),
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // Set the width of the indicator to match the tab label
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                              text: 'Request',
                            ),
                            Tab(
                              text: 'Marked',
                            ),

                            // second tab [you can add an icon using the icon property]
                            Tab(
                              text: 'Assigned',
                            ),
                            Tab(
                              text: 'Outbox',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // tab bar view here
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Details Tab
                          DeliveryDetailsPage(),
                          // Create Invoice Tab
                          MarkedPageTemp(),
                          AssignedDriver(),
                          AssignedDriver(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvoiceDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Assignment'),
      ),
    );
  }
}

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('assigned'),
      ),
    );
  }
}
