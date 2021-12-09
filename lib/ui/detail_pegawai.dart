import 'package:flutter/material.dart';
import 'package:flutter_sqflite/model/pegawai.dart';

class DetailPage extends StatelessWidget {
  final Pegawai? pegawai;

  DetailPage(this.pegawai);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6D9886),
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'First Name: ${pegawai!.firstName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Last Name: ${pegawai!.lastName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Mobile No: ${pegawai!.mobileNo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Email: ${pegawai!.email}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
