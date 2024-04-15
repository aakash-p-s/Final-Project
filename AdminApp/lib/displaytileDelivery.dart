import 'package:adminpanel/adminpanel.dart';
import 'package:adminpanel/contractortabbar.dart';
import 'package:adminpanel/marked.dart';
//import 'package:adminpanel/contractortabbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeliveryDetails {
  final String deliveryId;
  final String orderId;
  final String contractorId;
  final String expectedDate;
  final String invoiceId;

  DeliveryDetails({
    required this.deliveryId,
    required this.orderId,
    required this.contractorId,
    required this.expectedDate,
    required this.invoiceId,
  });

  factory DeliveryDetails.fromJson(List<dynamic> json) {
    return DeliveryDetails(
      deliveryId: json[0],
      orderId: json[1],
      contractorId: json[2],
      expectedDate: json[3],
      invoiceId: json[4],
    );
  }
}

Future<List<DeliveryDetails>> fetchDeliveryDetails() async {
  final response = await http.get(
      Uri.parse('http://192.168.43.156:3000/api/foradmin/assignmentsheet'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => DeliveryDetails.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch delivery details');
  }
}

class DeliveryDetailsPage extends StatefulWidget {
  @override
  _DeliveryDetailsPageState createState() => _DeliveryDetailsPageState();
}

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
  late Future<List<DeliveryDetails>> _futureDeliveryDetails;

  @override
  void initState() {
    super.initState();
    _futureDeliveryDetails = fetchDeliveryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DeliveryDetails>>(
        future: _futureDeliveryDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Image.asset('assets/images/404robot.gif'),
                SizedBox(height: 16),
                Text('No Data'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BackdropPageDashBoard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(143, 148, 251, 0.8),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text('Go to Main Page'),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final deliveryDetail = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              caption: 'Assign',
                              color: Color.fromARGB(255, 240, 246, 241),
                              icon: Icons.control_point_duplicate,

                              // borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MarkedPage(
                                      invoiceId: deliveryDetail.invoiceId,
                                      deliveryId: deliveryDetail.deliveryId,
                                      orderId: deliveryDetail.orderId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: ListTile(
                                leading: Icon(Icons.delivery_dining),
                                title: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: const Color.fromARGB(
                                                    255, 245, 131, 123)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${deliveryDetail.deliveryId}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(width: 60),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Color.fromARGB(
                                                  255, 137, 211, 234)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '${deliveryDetail.orderId}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${deliveryDetail.contractorId}'),
                                        ],
                                      ),
                                      SizedBox(width: 80),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${deliveryDetail.expectedDate}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //slidable
                  );
                },
              );
            } else {
              // Display empty data skeleton
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/emptydataskeleton.gif'),
                  SizedBox(height: 16),
                  Text('Empty Page'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BackdropPageDashBoard()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(143, 148, 251, 0.8),
                      minimumSize: Size(200, 50),
                    ),
                    child: Text('Add Contractor'),
                  ),
                ],
              );
            }
          } else {
            // Display empty data skeleton
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/404robot.gif'),
                SizedBox(height: 16),
                Text('No Data'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BackdropPageDashBoard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(143, 148, 251, 0.8),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text('Go To Home'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DeliveryDetailsPage(),
  ));
}
