import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/dosen_model.dart';
import 'edit_dosen_screen.dart';
import 'tambah_dosen_screen.dart';
import 'detail_dosen_screen.dart';

class ListDosenScreen extends StatefulWidget {
  @override
  _ListDosenScreenState createState() => _ListDosenScreenState();
}

class _ListDosenScreenState extends State<ListDosenScreen> {
  List<Dosen> listDosen = [];

  Future<void> fetchDosen() async {
    final response = await http.get(Uri.parse('http://192.168.43.228:8000/api/dosen'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      setState(() {
        listDosen = data.map((json) => Dosen.fromJson(json)).toList();
      });
    }
  }

  Future<void> deleteDosen(int no) async {
    final response = await http.delete(Uri.parse('http://192.168.43.228:8000/api/dosen/$no'));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data berhasil dihapus")),
      );
      fetchDosen();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDosen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Data Dosen",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      body: listDosen.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: listDosen.length,
        itemBuilder: (context, index) {
          final dosen = listDosen[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child:
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(dosen.namaLengkap, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(dosen.email),
              trailing: Wrap(
                spacing: 12,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditDosenScreen(dosen: dosen)),
                      );
                      if (result == true) fetchDosen();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Konfirmasi'),
                          content: Text('Anda yakin ingin menghapus data?'),
                          actions: [
                            TextButton(
                              child: Text('Batal'),
                              onPressed: () => Navigator.of(ctx).pop(),
                            ),
                            TextButton(
                              child: Text('Hapus'),
                              onPressed: () async {
                                Navigator.of(ctx).pop();
                                await deleteDosen(dosen.no!);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailDosenScreen(dosen: dosen)),
                );
              },
            ),

          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahDosenScreen()),
          );

          if (result == true) {
            fetchDosen();
          }
        },
      ),
    );
  }
}
