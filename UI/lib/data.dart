class makanan {
  String name;
  String rate;
  String imageAsset;
  String description;

  makanan({
    required this.name,
    required this.description,
    required this.rate,
    required this.imageAsset,
  });
}

var makananList = [
  makanan(
    name: 'Rawon',
    rate: 'Sedang',
    imageAsset: 'assets/images/produk2.png',
    description:
    '- Bahan:\n'
        '1. Daging sapi - 250 gram\n'
        '2. Daun jeruk - 3 lembar\n'
        '3. Serai, geprek - 2 batang\n'
        '4. Daun salam - 2 lembar\n'
        '5. Air - 1,2 liter\n'
        '6. Gula - secukupnya\n'
        '7. Garam – secukupnya\n \n'
        '-Bumbu Halus\n'
        '1. Kluwek - 4 buah\n'
        '2. Bawang putih - 4 siung\n'
        '3. Bawang merah - 7 siung\n'
        '4. Kemiri - 3 butir\n'
        '5. Ketumbar - 2 sdt\n'
        '6. Jahe - 1 ruas\n'
        '7. Kunyit - 1 ruas\n'
        '8. Lada - 1 sdt\n \n'
        '- Pelengkap\n'
        '1. Bawang goreng - secukupnya\n'
        '2. Tauge kecil - secukupnya\n'
        '3. Jeruk nipis – secukupnya\n \n'
        '- Langkah\n'
        '1. Masak air sampai mendidih, masukkan daging sapi, rebus sampai berubah warna.\n'
        '2. Buang busa kotoran yang mengapung. Lanjutkan merebus sampai daging empuk.\n'
        '3. Buang kulit kluwek, ambil dagingnya dan rendam air panas sampai lembut. Haluskan bersama bumbu halus. Lalu tumis bumbu halus sampai harum\n'
        '4. Masukkan daun salam, serai, daun jeruk, lengkuas, aduk sebentar.\n'
        '5. Masukkan tumisan bumbu ke dalam rebusan daging.\n'
        '6. Bumbui dengan garam, kaldu sapi bubuk, dan gula merah, aduk rata kemudian koreksi rasa.\n'
        '7. Angkat dan potong-potong daging.\n'
        '8. Masukkan kembali ke air rebusan. Masak lagi sebentar.\n'
        '9. Angkat, sajikan dengan telur asin, tauge, taburan daun bawang, bawang merah goreng,sambal dan perasan jeruk nipis.\n \n',
  ),
  makanan(
    name: 'Sup Jamur Kuping',
    rate: 'Mudah',
    imageAsset: 'assets/images/produk3.png',
    description:
        '- Bahan : \n'
        '1.	Jamur kuping, potong sesuai selera - 50 gram \n'
        '2.	Dada ayam, potong dadu - 75 gram \n'
        '3.	Wortel - 1 buah \n'
        '4.	Bunga kol, potong kuntumnya – 1/4 bonggol \n'
        '5.	Seledri, cincang kasar - 1 tangkai \n'
        '6.	Bihun (sekitar 50 gram) – 1/2 bungkus \n'
        '7.	Air – 500 ml \n'
        '8.	Bawang bombay, cincang kasar - 1/4 buah \n'
        '9.	Bawang putih, cincang halus - 1 siung \n'
        '10.	Merica bubuk - 1/4 sdt \n'
        '11.	Minyak goreng - secukupnya \n'
        '12.	Garam – 1/2 sdt \n'
        '13.	Gula pasir - 1/2 sdt \n \n'
        '- Langkah: \n'
        '1.	Rebus bihun hingga lunak, lalu angkat dan tiriskan. \n'
        '2.	Rebus 1 liter air sampai mendidih. Masukkan daging ayam, rebus dengan api sedang hingga mendidih dan kaldunya keluar. Bersihkan kotoran yang mengapung dengan sendok. \n'
        '3.	Panaskan sedikit minyak di wajan, tumis bawang putih dan bawang bombay sampai harum. Masukkan tumisan bawang ke dalam rebusan ayam. \n'
        '4.	Masukkan wortel, lalu bunga kol dan jamur kuping. Ketiganya bergantian dan beri jeda agar matangnya seimbang. \n'
        '5.	Bumbui dengan merica bubuk, garam, dan gula sesuai selera hingga rasanya pas. \n'
        '6.	Masak hingga semua sayuran matang dan empuk. \n'
        '7.	Sebelum api dimatikan, masukkan bihun dan seledri, aduk rata lalu matikan api. Sup jamur hangat siap disajikan. \n \n',
  ),
  makanan(
    name: 'Nasi Goreng Aceh',
    rate: 'Mudah',
    imageAsset: 'assets/images/produk4.png',
    description:
        '- Bahan : \n'
        '1.	Nasi putih dan kecap manis, campur hingga rata - 1 piring  \n'
        '2.	Saus tiram – 1/2 sdm \n'
        '3.	Minyak untuk menggoreng - 2 sdm \n'
        '4.	Garam – 1/2 sdt \n  \n'
        '- Bumbu Halus :  \n'
        '1.	Bawang merah - 2 siung \n'
        '2.	Bawang putih - 1 siung \n'
        '3.	Cabe merah keriting – 3 buah \n'
        '4.	Kemiri - 1 butir \n'
        '5.	Merica - 1/4 sdt \n'
        '6.	Terasi - seujung sendok \n'
        '7.	Pala - sedikit \n \n'
        '- Pelengkap : \n'
        '1.	Telur mata sapi - 1 buah \n'
        '2.	Irisan tomat - secukupnya \n'
        '3.	Kerupuk - secukupnya \n'
        '4.	Acar bawang - secukupnya \n'
        '5.	Irisan daun seledri dan daun bawang - secukupnya \n \n'
        '- Bahan Pelengkap Bawang : \n'
        '1.	Bawang merah - 1 siung \n'
        '2.	Cabe rawit merah - 1 buah \n'
        '3.	Gula – 1/2 sdt \n'
        '4.	Cuka – 1/2 sdt \n'
        '5.	Air hangat – sedikit \n \n'
        '- Langkah : \n'
        '1.	Haluskan semua bahan bumbu halus, lalu tumis hingga wangi. \n'
        '2.	Tambahkan saus tiram kemudian aduk lagi hingga wangi dan rata. \n'
        '3.	Kemudian masukkan nasi yang sudah dicampur dengan kecap, aduk merata. \n'
        '4.	Lalu tambahkan daun seledri dan daun bawang, aduk merata. \n'
        '5.	Garam dimasukkan terakhir kali dan sesuaikan rasanya. \n'
        '6.	Angkat dan hidangkan dengan telur ceplok, kerupuk, irisan tomat dan acar bawang. \n \n'
        '- Cara Membuat acar bawang : \n'
        '1.	Potong-potong bawang merah dan cabe rawit merah. \n'
        '2.	Campurkan ke gula, cuka, dan air hangat. \n'
        '3.	Kemudian aduk dengan merata dan siap disajikan. \n \n',
  ),
  makanan(
    name: 'Tempe Teriyaki',
    rate: 'Mudah',
    imageAsset: 'assets/images/produk4.png',
    description:
        '-	Bahan: \n'
        '1.	Tempe, 2 papan - 300 gram \n'
        '2.	Bawang bombay, iris lebar - 1/2 buah \n'
        '3.	Bawang putih, cincang - 4 siung \n'
        '4.	Cabai merah, iris serong - 3 buah \n'
        '5.	Kecap manis - 1 sdm \n'
        '6.	Saus teriyaki - 2 sdm \n'
        '7.	Daun bawang, potong-potong - 2 tangkai \n'
        '8.	Garam - secukupnya \n'
        '9.	Gula - secukupnya \n'
        '10.	Wijen sangrai, untuk taburan - secukupnya \n'
        '11.	Minyak goreng – secukupnya \n \n'
        '-	Langkah : \n'
        '1.	Potong-potong tempe kecil memanjang kemudian goreng setengah matang. Angkat dan tiriskan. \n'
        '2.	Tumis bawang putih, bawang bombay, dan cabai merah sampai harum. Masukkan tempe aduk rata. \n'
        '3.	Tambahkan kecap manis, saus teriyaki, garam dan gula. Masak sampai bumbu meresap, koreksi rasanya lalu angkat. \n'
        '4.	Sajikan dengan taburan wijen sangrai dan irisan daun bawang. \n \n',

  ),
];

class minuman{
  String name;
  String rate;
  String imageAsset;
  String description;

  minuman({
    required this.name,
    required this.description,
    required this.rate,
    required this.imageAsset,
  });
}

var minumanList = [
  minuman(
    name: 'Cappucino Cincau',
    rate: 'Mudah',
    imageAsset: 'assets/images/produk6.png',
    description:
        '-	Bahan : \n'
        '1.	Kopi cappucino instan - 1 saset \n'
        '2.	Air hangat - 50 ml \n'
        '3.	Gula pasir - 1 sdm \n'
        '4.	Susu cair - 100 ml \n'
        '5.	Es batu - 50 gram \n'
        '6.	Cincau hitam - 70 gram \n \n'
        '-	Langkah: \n'
        '1.	Potong kecil cincau hitam, sisihkan \n'
        '2.	Seduh kopi cappucino dan gula pasir dengan air hangat, aduk sampai larut. \n'
        '3.	Siapkan gelas saji, beri es batu, cappucino yang sudah diseduh, cincau, kemudian tuang susu cair di atasnya. Sajikan segera. \n \n'
        '-	Tips: \n'
        '1.	Gunakan susu cair dalam kondisi dingin untuk hasil yang lebih dingin. \n'
        '2.	Gula pasir bisa diganti gula palem jika suka. \n \n',

  ),
/*  minuman(
    name: 'Sepatu Pria',
    rate: 'Rp 280.000',
    imageAsset: 'assets/images/produk7.png',
    description:
        'Bahan Kampas Motif Sablon Tidak Mudah Luntur Sol Bawah Tidak Licin Paking Pakai Dus Size 39-43',
  ),
  minuman(
    name: 'Jaket Pria Hitam',
    rate: 'Rp 120.000',
    imageAsset: 'assets/images/produk8.png',
    description:
        'Cocok untuk segala Aktifitas Adem di Pakai Menyerap keringat Nyaman di pakai sehari-hari Warna sesuai GAMBAR Tahan Lama (AWET) Harga sangat terjangkau',
  ),
  minuman(
    name: 'Jaket Pria Putih',
    rate: 'Rp 150.000',
    imageAsset: 'assets/images/produk9.png',
    description:
        'Jacket Bary series jacket terbaik yang satu-satunya menggunakan material anti mainstream, yaitu Baby Terry 24s, yang super lembut, tebal, adem, tidak berbulu, & sangat nyaman dipakai seharian.',
  ),
  minuman(
    name: 'Sepatu Pria',
    rate: 'Rp 230.000',
    imageAsset: 'assets/images/produk5.png',
    description:
        'Bahan Kampas Motif Sablon Tidak Mudah Luntur Sol Bawah Tidak Licin Paking Pakai Dus Size 39-43',
  ),
  minuman(
    name: 'Sweter Pria',
    rate: 'Rp 120.000',
    imageAsset: 'assets/images/produk3.png',
    description:
        'Jahitan Kerah Rapi ( Tidak Mudah Melar ) Jahitan 2 Benang ( Semakin Kencang dan Rapat ) Jahitan Rapih dan Rapat ( Bukan Benang Murahan ) Bahan babyterry Sangat Populer Di Asia Cocok Untuk Kegiatan Sehari-hari',
  ),
  minuman(
    name: 'Sweter Wanita',
    rate: 'Rp 100.000',
    imageAsset: 'assets/images/produk2.png',
    description:
        'Sweater yang cocok untuk sista yang selalu mengikuti trend kekinian dan juga fashionable karna bahan lembut juga tidak mudah kusut tentunya menambah kesan rapih',
  ),*/
];
