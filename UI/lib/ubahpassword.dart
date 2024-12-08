import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './base_url.dart'; // Pastikan URL dasar API Anda benar

class UbahPassword extends StatefulWidget {
  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  final TextEditingController passwordController = TextEditingController();

  Future<void> changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('User ID tidak tersedia. Silakan login kembali.')),
      );
      return;
    }

    var url =
        Uri.parse(baseUrl + 'api/auth/change-password'); // Sesuaikan endpoint
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': userId,
        'new_password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['code'] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password berhasil diubah')),
        );
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['info'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Gagal mengubah password dengan status: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan password baru:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password Baru',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: changePassword,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
