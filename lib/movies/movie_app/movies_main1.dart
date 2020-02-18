import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//No Data Model
void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoviesListing(),
    );
  }
}

class MoviesProvider {
  static final String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  static Future<Map> getJson() async {
    var apiKey = "2769496ca4cfd8df18f9fea0a40d98e6";
    var apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}";
    var apiResponse = await http.get(apiEndPoint);
    return json.decode(apiResponse.body); //dart:convert
  }
}

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  var moviesData;

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    setState(() {
      moviesData = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchMovies();

    return Scaffold(
      body: ListView.builder(
        itemCount: moviesData == null ? 0 : moviesData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: MovieTile(moviesData, index),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlue.shade100,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final movies;
  final index;

  const MovieTile(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                margin: EdgeInsets.all(16.0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(MoviesProvider.imagePathPrefix +
                            movies[index]['poster_path']),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3.0,
                          offset: Offset(1.0, 3.0)),
                    ]),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movies[index]['title'],
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        movies[index]['overview'],
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
