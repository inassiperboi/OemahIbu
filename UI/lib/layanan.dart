import 'package:flutter/material.dart';

class layanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tulis pertanyaan atau permintaan:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tulis disini...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementasikan logika untuk mengirim pertanyaan/permintaan
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pertanyaan/permintaan terkirim')),
                );
              },
              child: Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
