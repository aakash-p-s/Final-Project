//import 'package:backwithcustomtab/contarctorDetailsDisplay1.dart';
//import 'package:backwithcustomtab/contractorRegisterForm.dart';
import 'package:adminpanel/contractorDetailsDisplay1.dart';
import 'package:adminpanel/contractorRegisterForm.dart';
import 'package:flutter/material.dart';

class BackdropPage extends StatefulWidget {
  @override
  _BackdropPageState createState() => _BackdropPageState();
}

class _BackdropPageState extends State<BackdropPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            color: Color.fromRGBO(
                143, 148, 251, 1), // Semi-transparent black color
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(45),
            child: Text(
              'Contractors',
              style: const TextStyle(
                fontSize: 24.0,
                // fontFamily: 'Caveat',
                // fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
                            text: 'Add',
                          ),

                          // second tab [you can add an icon using the icon property]
                          Tab(
                            text: 'View',
                          ),
                        ],
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
                          ContractorDetailsForm(),
                          // Create Invoice Tab
                          MyPage(),
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
