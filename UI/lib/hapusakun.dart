import 'package:flutter/material.dart';
import './daftar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './base_url.dart';

class HapusAkun extends StatefulWidget {
  @override
  _HapusAkunState createState() => _HapusAkunState();
}

class _HapusAkunState extends State<HapusAkun> {
  String? alasan;
  bool setuju = false;

  Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID tidak ditemukan.')),
      );
      return;
    }

    var url = Uri.parse(baseUrl + 'api/user/delete');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['code'] == 0) {
        await prefs.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Daftar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(responseData['info'] ?? 'Gagal menghapus akun.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hapus Akun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alasan Penghapusan Akun:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: alasan,
              onChanged: (value) {
                setState(() {
                  alasan = value;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Sudah tidak menggunakan aplikasi',
                  child: Text('Sudah tidak menggunakan aplikasi'),
                ),
                DropdownMenuItem(
                  value: 'Ingin membuat data baru',
                  child: Text('Ingin membuat data baru'),
                ),
                DropdownMenuItem(
                  value: 'Lainnya',
                  child: Text('Lainnya'),
                ),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih alasan',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: setuju,
                  onChanged: (value) {
                    setState(() {
                      setuju = value ?? false;
                    });
                  },
                ),
                Text(
                    'Saya yakin dan menyetujui setelah penghapusan akun, akun akan hilang.'),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (alasan != null && setuju) {
                  // Lakukan penghapusan akun
                  // Contoh: Menampilkan notifikasi dan pindah ke halaman Daftar
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Akun Berhasil Dihapus'),
                      content: Text('Anda berhasil menghapus akun.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            if (alasan != null && setuju) {
                              deleteUser();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Harap lengkapi alasan dan setujui persyaratan penghapusan akun.')),
                              );
                            }
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Tampilkan pesan kesalahan jika alasan atau persetujuan tidak lengkap
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Harap lengkapi alasan dan setujui persyaratan.'),
                    ),
                  );
                }
              },
              child: Text('Hapus Akun'),
            ),
          ],
        ),
      ),
    );
  }
}
