import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './base_url.dart'; // Pastikan ini mengimpor URL basis Anda dengan benar
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  final String foodId;

  DetailScreen({required this.foodId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<FoodItem> foodDetail;
  bool isFavorite = false; // Assume initially not favorite

  @override
  void initState() {
    super.initState();
    foodDetail = fetchFoodDetails();
  }

  Future<FoodItem> fetchFoodDetails() async {
    var url = Uri.parse(baseUrl + 'api/food-detail/get-by-food-id');

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'food_id': widget.foodId}),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['code'] == 0) {
        return FoodItem.fromJson(data['data'][0]);
      } else {
        throw Exception('Failed to load food details: ${data['info']}');
      }
    } else {
      throw Exception(
          'Failed to load food details with status code: ${response.statusCode}');
    }
  }

  Future<void> toggleFavorite() async {
    final url = Uri.parse(baseUrl + 'api/favourites/create');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID tidak ditemukan.')),
      );
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'food_id': widget.foodId, 'user_id': userId}),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 && responseData['code'] == 0) {
        setState(() {
          isFavorite = !isFavorite;
        });
      } else {
        throw Exception('Failed to toggle favorite: ${responseData['info']}');
      }
    } catch (error) {
      print(error);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text('Could not mark as favorite.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<FoodItem>(
        future: foodDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            return buildFoodDetails(snapshot.data!);
          } else {
            return Center(child: buildShimmerEffect());
          }
        },
      ),
    );
  }

  Widget buildFoodDetails(FoodItem food) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: baseUrl + food.image,
                width: MediaQuery.of(context).size.width,
                height: 300, // Sesuaikan tinggi yang diinginkan
                fit: BoxFit.cover,
                placeholder: (context, url) => buildShimmerEffect(),
                errorWidget: (context, url, error) => buildShimmerEffect(),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () => toggleFavorite(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Text(
              food.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              food.rate,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              food.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        color: Colors.white,
      ),
    );
  }
}

class FoodItem {
  final String foodId;
  final String name;
  final String image;
  final String rate;
  final String description;

  FoodItem({
    required this.foodId,
    required this.name,
    required this.image,
    required this.rate,
    required this.description,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      foodId: json['food_id'] ?? '',
      name: json['nama'] ?? '',
      image: json['images'] ?? '',
      rate: json['xs1'] ?? '',
      description: json['xs2'] ?? '',
    );
  }
}
