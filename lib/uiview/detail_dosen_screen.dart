import 'package:flutter/material.dart';
import '../model/dosen_model.dart';

class DetailDosenScreen extends StatelessWidget {
  final Dosen dosen;
  const DetailDosenScreen({super.key, required this.dosen});

  Widget buildDetailRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[700])),
                SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF3F3F3),
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text("Detail Data Dosen", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Informasi Dosen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
                    SizedBox(height: 20),
                    buildDetailRow('NIP', dosen.nip, Icons.badge, Colors.indigo),
                    Divider(),
                    buildDetailRow('Nama Lengkap', dosen.namaLengkap, Icons.person, Colors.pink),
                    Divider(),
                    buildDetailRow('No Telepon', dosen.noTelepon, Icons.phone, Colors.teal),
                    Divider(),
                    buildDetailRow('Email', dosen.email, Icons.email, Colors.indigo),
                    Divider(),
                    buildDetailRow('Alamat', dosen.alamat, Icons.home, Colors.deepOrange),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
