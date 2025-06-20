import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/dosen_model.dart';

class EditDosenScreen extends StatefulWidget {
  final Dosen dosen;
  const EditDosenScreen({super.key, required this.dosen});

  @override
  State<EditDosenScreen> createState() => _EditDosenScreenState();
}

class _EditDosenScreenState extends State<EditDosenScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nipController;
  late TextEditingController namaController;
  late TextEditingController telpController;
  late TextEditingController emailController;
  late TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    nipController = TextEditingController(text: widget.dosen.nip);
    namaController = TextEditingController(text: widget.dosen.namaLengkap);
    telpController = TextEditingController(text: widget.dosen.noTelepon);
    emailController = TextEditingController(text: widget.dosen.email);
    alamatController = TextEditingController(text: widget.dosen.alamat);
  }

  Future<void> updateDosen() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.put(
        Uri.parse('http://192.168.43.228:8000/api/dosen/${widget.dosen.no}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nip': nipController.text,
          'nama_lengkap': namaController.text,
          'no_telepon': telpController.text,
          'email': emailController.text,
          'alamat': alamatController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Data berhasil di edit')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Gagal mengedit data')),
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
        title: Text("Edit Dosen", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
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
                  Text("Edit Data Dosen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
                  SizedBox(height: 20),
                  buildInputField(nipController, 'NIP', Icons.badge, Colors.indigo),
                  buildInputField(namaController, 'Nama Lengkap', Icons.person, Colors.pink),
                  buildInputField(telpController, 'No Telepon', Icons.phone, Colors.teal),
                  buildInputField(emailController, 'Email', Icons.email, Colors.indigo),
                  buildInputField(alamatController, 'Alamat', Icons.home, Colors.deepOrange),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: updateDosen,
                    icon: Icon(Icons.save, color: Colors.white),
                    label: Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
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
