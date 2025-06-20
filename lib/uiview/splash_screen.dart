import 'package:flutter/material.dart';
import 'list_dosen_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 150, color: Colors.teal),
              SizedBox(height: 20),
              Text(
                'Aplikasi Data Dosen',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3),
              Text(
                'Dengan CRUD Data Dosen',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.teal,
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ListDosenScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
