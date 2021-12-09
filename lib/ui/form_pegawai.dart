import 'package:flutter/material.dart';
import 'package:flutter_sqflite/db/db_helper.dart';
import 'package:flutter_sqflite/model/pegawai.dart';

class FormPegawai extends StatefulWidget {
  final Pegawai? pegawai;

  FormPegawai({this.pegawai});

  @override
  _FormPegawaiState createState() => _FormPegawaiState();
}

class _FormPegawaiState extends State<FormPegawai> {
  DbHelper db = DbHelper();

  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? mobileNo;
  TextEditingController? email;

  @override
  void initState() {
    firstName = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai!.firstName);
    lastName = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai!.lastName);
    mobileNo = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai!.mobileNo);
    email = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai!.email);
    super.initState();
  }

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pegawai'),
        centerTitle: true,
        backgroundColor: Color(0xff6D9886),
      ),
      body: Form(
        key: _keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First Name tidak boleh kosong';
                }
                return null;
              },
              controller: firstName,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last Name tidak boleh kosong';
                }
                return null;
              },
              controller: lastName,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No Hp tidak boleh kosong';
                }
                return null;
              },
              controller: mobileNo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                return null;
              },
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Color(0xff6D9886),
              child: (widget.pegawai == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  upsertPegawai();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Masih Ada yang Kosong")));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> upsertPegawai() async {
    if (widget.pegawai != null) {
      //update
      await db.updatePegawai(Pegawai.fromMap({
        'id': widget.pegawai!.id,
        'firstName': firstName!.text,
        'lastName': lastName!.text,
        'mobileNo': mobileNo!.text,
        'email': email!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.savePegawai(Pegawai(
        firstName: firstName!.text,
        lastName: lastName!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
