import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahDosenScreen extends StatefulWidget {
  @override
  _TambahDosenScreenState createState() => _TambahDosenScreenState();
}

class _TambahDosenScreenState extends State<TambahDosenScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  Future<void> submitDosen() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://192.168.43.228:8000/api/dosen'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nip': nipController.text,
          'nama_lengkap': namaController.text,
          'no_telepon': telpController.text,
          'email': emailController.text,
          'alamat': alamatController.text,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Data berhasil ditambahkan')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Gagal menambahkan dosen')),
        );
      }
    }
  }

  Widget buildInputField(TextEditingController controller, String label, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[700]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) => value!.isEmpty ? '$label wajib diisi' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Dosen", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.7),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text("Tambah Data Dosen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
                  SizedBox(height: 20),
                  buildInputField(nipController, 'NIP', Icons.badge, Colors.indigo),
                  buildInputField(namaController, 'Nama Lengkap', Icons.person, Colors.pink),
                  buildInputField(telpController, 'No Telepon', Icons.phone, Colors.teal),
                  buildInputField(emailController, 'Email', Icons.email, Colors.indigo),
                  buildInputField(alamatController, 'Alamat', Icons.home, Colors.deepOrange),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: submitDosen,
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text('Simpan Data', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
