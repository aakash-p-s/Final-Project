import 'package:adminpanel/contractorDetailsDisplay2.dart';
import 'package:adminpanel/contractortabbar.dart';
//import 'package:backwithcustomtab/contractorDetailsDisplay2.dart';
//import 'package:backwithcustomtab/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Future<List<dynamic>> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.156:3000/api/contractor/emptycheck'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Image.asset('assets/images/404robot.gif'),
              SizedBox(height: 16),
              Text('No Data'),
              SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     // Handle button press
              //   },
              //   child: Text('Back'),
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BackdropPage()),
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
          // Center(
          //   child: Text('Error: ${snapshot.error}'),
          // );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.isNotEmpty) {
            // Display custom list tiles
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color.fromRGBO(142, 146, 225, 0.8),
                  child: ListTile(
                    title: Text('Name: ${data[index][1]} ${data[index][2]}'),
                    subtitle: Text('ID: ${data[index][0]}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => V1Page(
                                        cntr_id: data[index][0],
                                        cntr_fname: data[index][1],
                                        cntr_lname: data[index][2],
                                        cntr_email: data[index]
                                            [3], // Assuming email is available
                                        cntr_phno: data[index][4],
                                        local_address: data[index][5],
                                        company_name: data[index][6],
                                        pswd: data[index][7],
                                      )),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => V2Page(
                                        cntr_id: data[index][0],
                                        cntr_fname: data[index][1],
                                        cntr_lname: data[index][2],
                                        cntr_email: data[index]
                                            [3], // Assuming email is available
                                        cntr_phno: data[index][4],
                                        local_address: data[index][5],
                                        company_name: data[index][6],
                                        pswd: data[index][7],
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
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
                // ElevatedButton(
                //   onPressed: () {
                //     // Handle button press
                //   },
                //   child: Text('Back'),
                // ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BackdropPage()),
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
        }
        //else {
        //   return Center(
        //     child: Text('No Data'),
        //   );

        // }
        else {
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
                    MaterialPageRoute(builder: (context) => BackdropPage()),
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
      },
    );
  }
}
