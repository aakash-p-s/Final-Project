// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'contractorHomePage.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isObscure = true;

//   Future<void> loginUser(BuildContext context) async {
//     String username = usernameController.text;
//     String password = passwordController.text;

//     try {
//       var response = await http.post(
//         Uri.parse('http://192.168.43.156:3000/api/logincontractor'),
//         body: jsonEncode({'username': username, 'password': password}),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ContractorHomePage()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Invalid username or password'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (error) {
//       print('Error: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error occurred. Please try again later.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 245, 239, 5),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               flex: 1,
//               child: Center(
//                 child: Image.asset(
//                   'assets/images/login.gif',
//                   height: 500,
//                   width: 500,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Welcome!',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       hintText: 'Username',
//                       prefixIcon: Icon(Icons.email),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: passwordController,
//                     obscureText: isObscure,
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       prefixIcon: Icon(Icons.lock),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           isObscure ? Icons.visibility : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             isObscure = !isObscure;
//                           });
//                         },
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       loginUser(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                       onPrimary: Colors.white,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Text('Login'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:contractorpanel/driverPages/driverlogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'contractorHomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  Future<void> loginUser(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    try {
      var response = await http.post(
        Uri.parse('http://192.168.43.156:3000/api/logincontractor'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ContractorHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 239, 5),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the default back button
        backgroundColor: Color.fromARGB(255, 245, 239, 5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Contractor',
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        height: 200.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              color: Colors.red,
                              size: 50.0,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Are you a Transporter..?',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                  ),
                                  child: Text('No'),
                                ),
                                SizedBox(width: 20.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DriverLogin()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 225, 222, 66),
                                  ),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Image.asset(
                  'assets/images/login.gif',
                  height: 500,
                  width: 500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 30,
                      //  fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      loginUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
