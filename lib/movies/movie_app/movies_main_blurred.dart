import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

//Model + backdrop blurred
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

class MovieModel {
  final int id;
  final num popularity;
  final int vote_count;
  final bool video;
  final String poster_path;
  final String backdrop_path;
  final bool adult;
  final String original_language;
  final String original_title;
  final List<dynamic> genre_ids;
  final String title;
  final num vote_average;
  final String overview;
  final String release_date;

  MovieModel(
      {this.id,
      this.popularity,
      this.vote_count,
      this.video,
      this.poster_path,
      this.backdrop_path,
      this.adult,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.title,
      this.vote_average,
      this.overview,
      this.release_date});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        popularity: json['popularity'],
        vote_count: json['vote_count'],
        video: json['video'],
        poster_path: json['poster_path'],
        adult: json['adult'],
        original_language: json['original_language'],
        original_title: json['original_title'],
        genre_ids: json['genre_ids'],
        title: json['title'],
        vote_average: json['vote_average'],
        overview: json['overview'],
        release_date: json['release_date']);
  }
}

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  var moviesData;
  List<MovieModel> movies = List<MovieModel>();

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    setState(() {
      moviesData = data['results'];

      List<dynamic> results = data['results'];
      results.forEach((element) {
        movies.add(MovieModel.fromJson(element));
      });
    });
  }

//  @override
//  void initState() {
//    super.initState();
//    fetchMovies();
//  }

  @override
  Widget build(BuildContext context) {
    fetchMovies();

    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: movies == null ? 0 : movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(context, index),
          );
        },
      ),
    );
  }

  Widget ListTile(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: MovieTile(movies, index),
    );
  }
}

class MovieTile extends StatelessWidget {
  final List<MovieModel> movies;
  final index;

  const MovieTile(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.network(
            MoviesProvider.imagePathPrefix + movies[index].poster_path,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(MoviesProvider.imagePathPrefix +
                            movies[index].poster_path),
                        fit: BoxFit.cover),
//                    boxShadow: [
//                      BoxShadow(
//                          color: Colors.grey,
//                          blurRadius: 3.0,
//                          offset: Offset(1.0, 3.0)),
//                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 8.0, right: 8.0, bottom: 8),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movies[index].title,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movies[index].overview,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Sriracha',
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
