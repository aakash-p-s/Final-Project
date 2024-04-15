// import 'package:flutter/material.dart';

// class BackdropPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Back Layer (Black)
//           Center(
//             child: Container(
//               color: Color.fromRGBO(143, 148, 251, 1),
//               alignment:
//                   Alignment.topCenter, // Align the child at the top center
//               padding: EdgeInsets.all(45),
//               child: Text(
//                 'My Dashboard',
//                 style: const TextStyle(
//                   fontSize: 24.0,
//                   fontFamily: 'Caveat',
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           // Front Layer (White with rounded top-left corner)
//           Positioned(
//             top: 100,
//             left: 5,
//             right: 5,
//             bottom: 5,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(236, 245, 241, 241),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(32.0),
//                 ),
//               ),
//               child: GridView.count(
//                 crossAxisCount: 2, // Two columns
//                 padding: EdgeInsets.all(20.0),
//                 mainAxisSpacing: 20.0, // Spacing between rows
//                 crossAxisSpacing: 20.0, // Spacing between columns
//                 children: [
//                   _buildGridItem(
//                     context,
//                     'Assignment',
//                     Icons.assignment,
//                     () {
//                       // Navigate to assignment page
//                     },
//                   ),
//                   _buildGridItem(
//                     context,
//                     'Delivery Details',
//                     Icons.delivery_dining,
//                     () {
//                       // Navigate to delivery details page
//                     },
//                   ),
//                   _buildGridItem(
//                     context,
//                     'Contractors',
//                     Icons.person,
//                     () {
//                       // Navigate to manage contractor page
//                     },
//                   ),
//                   _buildGridItem(
//                     context,
//                     'Delivery Persons',
//                     Icons.delivery_dining,
//                     () {
//                       // Navigate to manage delivery person page
//                     },
//                   ),
//                   _buildGridItem(
//                     context,
//                     'Manage Area',
//                     Icons.location_city,
//                     () {
//                       // Navigate to manage area page
//                     },
//                   ),
//                   _buildGridItem(
//                     context,
//                     'Reports',
//                     Icons.analytics_outlined,
//                     () {
//                       // Navigate to reports page
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGridItem(
//       BuildContext context, String name, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 3,
//               blurRadius: 7,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//           border: Border.all(
//             color: Colors.grey.withOpacity(0.5),
//             width: 1,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 48.0,
//               color: Color.fromRGBO(143, 148, 251, 1),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               name,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//import 'package:adminpanel/contractorRegiter.dart';
import 'package:adminpanel/assignmentTabBar.dart';
import 'package:adminpanel/contractortabbar.dart';
import 'package:adminpanel/pincodetabbar.dart';
import 'package:flutter/material.dart';

class BackdropPageDashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Back Layer with Image Background
          Container(
            child: Center(
              child: Container(
                color: Color.fromRGBO(
                    143, 148, 251, 0.8), // Semi-transparent black color
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(45),
                child: Text(
                  'My Dashboard',
                  style: const TextStyle(
                    fontSize: 24.0,
                    //fontFamily: 'Caveat',
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Front Layer (White with rounded top-left corner)
          Positioned(
            top: 100,
            left: 5,
            right: 5,
            bottom: 0, // Reduced bottom padding for bottom navigation bar
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(236, 245, 241, 241),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2, // Two columns
                padding: EdgeInsets.all(20.0),
                mainAxisSpacing: 20.0, // Spacing between rows
                crossAxisSpacing: 20.0, // Spacing between columns
                children: [
                  _buildGridItem(
                    context,
                    'Assignment',
                    Icons.assignment,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Assignmentsheet()),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Delivery Details',
                    Icons.shopping_cart_checkout,
                    () {
                      // Navigate to delivery details page
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Contractors',
                    Icons.person,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BackdropPage()),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Delivery Persons',
                    Icons.delivery_dining_outlined,
                    () {
                      // Navigate to manage delivery person page
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Manage Area',
                    Icons.location_city,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pincodesheet()),
                      );
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Reports',
                    Icons.analytics_outlined,
                    () {
                      // Navigate to reports page
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //     bottomNavigationBar: BottomNavigationBar(
      //       backgroundColor: Colors.white, // Background color
      //       //selectedItemColor:
      //       // Color.fromRGBO(216, 169, 13, 1), // Selected item color
      //       //unselectedItemColor: Colors.grey, // Unselected item color
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.business,
      //             color: const Color.fromRGBO(158, 158, 158, 1),
      //           ),
      //           label: 'Company',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           label: 'Home',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.account_circle),
      //           label: 'Account',
      //         ),
      //       ],
      //     ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, String name, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48.0,
              color: Color.fromRGBO(143, 148, 251, 1),
            ),
            SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
