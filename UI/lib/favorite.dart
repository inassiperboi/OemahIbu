import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './base_url.dart'; // Ensure you have a base_url.dart that contains your API base URL
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<dynamic>> favoriteItems;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    if (userId != null) {
      favoriteItems = fetchFavoritesByUserId(userId);
      setState(() {}); // Triggers a rebuild after the favorite items are set
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No user ID found, unable to load favorites"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
  }

  Future<List<dynamic>> fetchFavoritesByUserId(String userId) async {
    var url = Uri.parse(baseUrl + 'api/favourites/by-user');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['code'] == 0 && data['data'] != null) {
        return data['data'];
      } else {
        return []; // No favorites available, return empty list
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Server error with status code: ${response.statusCode}'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
      return Future.error('Server error');
    }
  }

  Future<void> deleteFavorite(String favoriteId) async {
    var url = Uri.parse(baseUrl + 'api/favourites/delete');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'favourite_id': favoriteId}),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['code'] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Favorite deleted successfully"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ));
        loadFavorites(); // Reload the favorites after deletion
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to delete favorite: ${data['info']}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Server error with status code: ${response.statusCode}'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: favoriteItems == null
          ? Center(child: Text("No user ID found, unable to load favorites"))
          : FutureBuilder<List<dynamic>>(
              future: favoriteItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text("No favorites available"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data![index];
                      return Dismissible(
                        key: Key(item['favourite_id']),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          deleteFavorite(item['favourite_id']);
                        },
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this item?"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("DELETE")),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(item['food_name']),
                          subtitle: Text(
                              "ID: ${item['food_id']} - User: ${item['user_name']}"),
                          leading: Image.network(
                            '${baseUrl}${item['images']}',
                            width: 50,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
