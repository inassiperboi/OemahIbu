import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tokodia/base_url.dart';
import './detail_populer.dart';
import './detail_rekomendasi.dart';
import './profile.dart';
import './favorite.dart';
import './login.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeToko extends StatefulWidget {
  @override
  _HomeTokoState createState() => _HomeTokoState();
}

class _HomeTokoState extends State<HomeToko> {
  int keranjangCount = 0;
  List<dynamic> foodData = [];
  List<dynamic> filteredFoodData = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFoodData();
  }

  Future<void> fetchFoodData() async {
    var url = Uri.parse(baseUrl + 'api/food');
    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      if (jsonData['code'] == 0) {
        setState(() {
          foodData = jsonData['data'];
          filteredFoodData = foodData; // Initially, all data is shown.
        });
      } else {
        print('Error fetching data: ${jsonData['info']}');
      }
    } catch (e) {
      print('Failed to connect to the API: $e');
    }
  }

  void updateSearchQuery(String query) {
    if (query.isNotEmpty) {
      List<dynamic> tmpList = [];
      for (var item in foodData) {
        if (item['nama'].toLowerCase().contains(query.toLowerCase())) {
          tmpList.add(item);
        }
      }
      setState(() {
        filteredFoodData = tmpList;
      });
    } else {
      setState(() {
        filteredFoodData = foodData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat Datang"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile())),
            icon: Icon(Icons.person),
          ),
          if (keranjangCount > 0)
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(right: 10),
              decoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Text(keranjangCount.toString(),
                  style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ListView(
          children: [
            headerSection(),
            SizedBox(height: 10),
            searchField(),
            categorySection(),
            foodList("Makanan"),
            foodList("Minuman"),
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Cari seleramu disini . . .",
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        hintStyle: TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onChanged: updateSearchQuery,
    );
  }

  Widget foodList(String jenis) {
    List<dynamic> filteredList =
        filteredFoodData.where((item) => item['jenis'] == jenis).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
          child: Text(jenis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredList.isEmpty ? 10 : filteredList.length,
            itemBuilder: (context, index) {
              if (filteredList.isEmpty) {
                return buildShimmerEffect();
              }
              var item = filteredList[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(foodId: item['food_id'])),
                ),
                child: Card(
                  child: Container(
                    height: 227,
                    width: 158,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(1, 1)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildImage(
                              item['images']), // Gunakan fungsi buildImage
                          SizedBox(height: 5),
                          Text(item['nama'],
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text(item['kesulitan'],
                              style:
                                  TextStyle(color: Colors.red, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget headerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/images/toko.png"),
        IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => FavoritePage())),
          icon: Icon(Icons.favorite),
        ),
      ],
    );
  }

  Widget categorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kategori",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              InkWell(
                onTap: () {
                  // Functionality to be implemented, such as navigating to a view all categories page
                  print('View all categories');
                },
                child: Text("View all",
                    style: TextStyle(color: Colors.green, fontSize: 10)),
              ),
            ],
          ),
        ),
        categoryList(), // Calling categoryList here to show under the header
      ],
    );
  }

  Widget categoryList() {
    // This can be improved to load dynamically if there are more categories
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            2, // Consider making this dynamic based on the number of categories
        itemBuilder: (context, index) {
          String category = (index == 0) ? "Makanan" : "Minuman";
          String asset = (index == 0)
              ? "assets/images/logo1.png"
              : "assets/images/logo2.png";
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(1, 1)),
                    ],
                  ),
                  child: IconButton(
                    iconSize: 35,
                    onPressed: () {
                      setState(() {
                        keranjangCount++; // Consider what this affects and whether it should trigger here
                      });
                    },
                    icon: Image.asset(asset),
                  ),
                ),
                SizedBox(height: 5),
                Text(category, style: TextStyle(fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 158,
        width: 158,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(1, 1)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 150, color: Colors.grey[300]),
            SizedBox(height: 5),
            Container(height: 10, width: 100, color: Colors.grey[300]),
            SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: baseUrl + imageUrl,
      height: 150,
      width: 158,
      fit: BoxFit.cover,
      placeholder: (context, url) => buildShimmerEffect(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
