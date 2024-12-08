import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './hometoko.dart';
import './daftar.dart';
import './lupasandi.dart';
import './base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _LoginState();
}

class _LoginState extends State<login> {
  bool ishide = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    var url = Uri.parse(baseUrl + 'api/auth/login');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'code': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['code'] == 0) {
          // Simpan data user ke SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', data['data']['user_id']);
          await prefs.setString('name', data['data']['name']);
          await prefs.setString('code', data['data']['code']);
          await prefs.setString('phone', data['data']['phone']);
          await prefs.setString('email', data['data']['email']);
          await prefs.setString('password', passwordController.text);
          // Menavigasi ke HomeToko setelah data disimpan
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeToko()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['info'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to reach server with status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              child: Image.asset("assets/images/logo7.png"),
            ),
            Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Color(0xffD04848),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 30),
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
                controller: emailController, // Tambahkan controller ini
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Masukkan Username Anda",
                  prefixIcon: Icon(Icons.person),
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Tambahkan controller untuk password
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
                controller: passwordController, // Tambahkan controller ini
                obscureText: ishide,
                decoration: InputDecoration(
                    hintText: "Masukkan Password Anda",
                    prefixIcon: Icon(Icons.lock),
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ishide = !ishide;
                          });
                        },
                        icon: Icon(
                            ishide ? Icons.visibility : Icons.visibility_off))),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    // Navigasi ke halaman lupa password ketika teks "Lupa Password?" ditekan
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => LupaSandi())));
                  },
                  child: Text(
                    "Lupa Password?",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD04848),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: login,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // Navigasi ke halaman pendaftaran ketika teks "Belum punya akun? Daftar" ditekan
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Daftar())));
                    },
                    child: Text(
                      "Belum punya akun? Daftar",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
