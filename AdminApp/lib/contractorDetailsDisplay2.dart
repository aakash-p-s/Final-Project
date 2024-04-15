import 'package:flutter/material.dart';

class V1Page extends StatelessWidget {
  final String cntr_id;
  final String cntr_fname;
  final String cntr_lname;
  final String cntr_email;
  final int cntr_phno;
  final String local_address;
  final String company_name;
  final String pswd;

  V1Page({
    required this.cntr_id,
    required this.cntr_fname,
    required this.cntr_lname,
    required this.cntr_email,
    required this.cntr_phno,
    required this.local_address,
    required this.company_name,
    required this.pswd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: $cntr_id'),
            Text('Name: $cntr_fname $cntr_lname'),
            Text('Phone: $cntr_phno'),
            Text('Email: $cntr_email'),
            Text('Address: $local_address'),
            Text('Company: $company_name'),
            Text('Password: $pswd'),
          ],
        ),
      ),
    );
  }
}

class V2Page extends StatelessWidget {
  final String cntr_id;
  final String cntr_fname;
  final String cntr_lname;
  final String cntr_email;
  final int cntr_phno;
  final String local_address;
  final String company_name;
  final String pswd;

  V2Page({
    required this.cntr_id,
    required this.cntr_fname,
    required this.cntr_lname,
    required this.cntr_email,
    required this.cntr_phno,
    required this.local_address,
    required this.company_name,
    required this.pswd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: $cntr_id'),
            Text('Name: $cntr_fname $cntr_lname'),
            Text('Phone: $cntr_phno'),
            Text('Phone: $cntr_email'),
            Text('Address: $local_address'),
            Text('Company: $company_name'),
            Text('Password: $pswd'),
          ],
        ),
      ),
    );
  }
}
