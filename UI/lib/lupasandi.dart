import 'package:flutter/material.dart';
import './login.dart';

class LupaSandi extends StatelessWidget {
  const LupaSandi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Password'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              child: Image.asset("assets/images/logo7.png"),
            ),
            SizedBox(height: 30),
            Text(
              "Lupa Password",
              style: TextStyle(
                color: Color(0xffD04848),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Masukkan email Anda di bawah ini. Kami akan mengirimkan tautan untuk mereset kata sandi Anda.",
              style: TextStyle(
                color: Color(0xffD04848),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Masukkan Email Anda",
                prefixIcon: Icon(Icons.email),
                hintStyle: TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD04848),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Implementasi untuk mengirim email reset password
                  // TODO: Tambahkan logika di sini
                },
                child: Text(
                  "Kirim",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Tombol kembali ke halaman login
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login()));
              },
              child: Text(
                "Kembali ke Login",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
