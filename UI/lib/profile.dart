import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './layanan.dart';
import './login.dart';
import './ubahpassword.dart';
import './hapusakun.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? 'Nama tidak ditemukan';
    String email = prefs.getString('email') ?? 'Email tidak ditemukan';
    return {
      'name': name,
      'email': email,
    };
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<Map<String, String>>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileItem('Nama:', snapshot.data?['name'] ?? 'Loading...'),
                    SizedBox(height: 20),
                    profileItem('Email:', snapshot.data?['email'] ?? 'Loading...'),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UbahPassword()),
                        );
                      },
                      child: Text('Ubah Password'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => layanan()),
                        );
                      },
                      child: Text('Layanan'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HapusAkun()),
                        );
                      },
                      child: Text('Hapus Akun'),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () => logout(context),
                      child: Text('Logout'),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget profileItem(String label, String value) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
