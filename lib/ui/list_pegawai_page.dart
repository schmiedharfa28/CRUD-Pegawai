import 'package:flutter/material.dart';
import 'package:flutter_sqflite/db/db_helper.dart';
import 'package:flutter_sqflite/model/pegawai.dart';
import 'package:flutter_sqflite/ui/detail_pegawai.dart';
import 'package:flutter_sqflite/ui/form_pegawai.dart';

class ListPegawaiPage extends StatefulWidget {
  @override
  _ListPegawaiPageState createState() => _ListPegawaiPageState();
}

class _ListPegawaiPageState extends State<ListPegawaiPage> {
  List<Pegawai> listPegawai = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllPegawai();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pegawai"),
        centerTitle: true,
        backgroundColor: Color(0xff6D9886),
      ),
      body: ListView.builder(
          itemCount: listPegawai.length,
          itemBuilder: (context, index) {
            Pegawai pegawai = listPegawai[index];

            return ListTile(
              onTap: () {
                //edit
                _openFormEdit(pegawai);
              },
              contentPadding: EdgeInsets.all(16),
              title: Text(
                "${pegawai.firstName} ${pegawai.lastName}",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff406343),
                ),
              ),
              subtitle: Text('${pegawai.email}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  AlertDialog hapus = AlertDialog(
                    title: Text('Information'),
                    content: Container(
                      height: 100.0,
                      child: Column(
                        children: [
                          Text(
                              'Apakah anda yakin ingin hapus data ${pegawai.email}'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          //delete
                          _deletePegawai(pegawai, index);
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );

                  showDialog(context: context, builder: (context) => hapus);
                },
              ),
              leading: IconButton(
                onPressed: () {
                  //detail
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(pegawai),
                      ));
                },
                icon: Icon(Icons.visibility),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xff6D9886),
        onPressed: () {
          //add
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllPegawai() async {
    var list = await db.getAllPegawai();
    setState(() {
      listPegawai.clear();
      list!.forEach((pegawai) {
        listPegawai.add(Pegawai.fromMap(pegawai));
      });
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormPegawai(),
        ));

    if (result == 'save') {
      await _getAllPegawai();
    }
  }

  Future<void> _deletePegawai(Pegawai pegawai, int position) async {
    await db.deletePegawai(pegawai.id!);

    setState(() {
      listPegawai.removeAt(position);
    });
  }

  Future<void> _openFormEdit(Pegawai pegawai) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormPegawai(pegawai: pegawai),
        ));

    if (result == 'update') {
      await _getAllPegawai();
    }
  }
}
