import 'package:flutter/material.dart';
import './login.dart';
import 'package:http/http.dart' as http;
import './base_url.dart';
import 'dart:convert';

class Daftar extends StatefulWidget {
  const Daftar({Key? key}) : super(key: key);

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  Future<void> registerUser() async {
    var url = Uri.parse(baseUrl + 'api/user/create');
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'code': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text
        }));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['code'] == 0) {
        // Jika berhasil, tampilkan snackbar hijau
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Akun Berhasil Dibuat',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 9, 109, 13),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => login()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal mendaftar: Silakan coba lagi',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Jika gagal, tampilkan snackbar merah
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Server gagal dihubungkan',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Akun'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              child: Image.asset("assets/images/logo7.png"),
            ),
            Center(
              child: Text(
                "DAFTAR AKUN",
                style: TextStyle(
                  color: Color(0xffD04848),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Nama",
              style: TextStyle(
                color: Color(0xffD04848),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextField(
                controller: nameController, // Menambahkan TextEditingController
                decoration: InputDecoration(
                  hintText: "Masukkan Nama Anda",
                  prefixIcon: Icon(Icons.person),
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Username",
              style: TextStyle(
                color: Color(0xffD04848),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextField(
                controller:
                    usernameController, // Menambahkan TextEditingController
                keyboardType: TextInputType.text, // Koreksi jenis keyboard
                decoration: InputDecoration(
                  hintText: "Masukkan Username Anda",
                  prefixIcon: Icon(Icons.person_outline), // Koreksi ikon
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Email",
              style: TextStyle(
                color: Color(0xffD04848),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextField(
                controller:
                    emailController, // Menambahkan TextEditingController
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Masukkan Email Anda",
                  prefixIcon: Icon(Icons.email),
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password",
              style: TextStyle(
                color: Color(0xffD04848),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: TextField(
                controller:
                    passwordController, // Menambahkan TextEditingController
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Masukkan Password Anda",
                  prefixIcon: Icon(Icons.lock),
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD04848),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: registerUser,
                child: Text(
                  "Daftar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah punya akun? ",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  child: Text(
                    "Masuk disini",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
