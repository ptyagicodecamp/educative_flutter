import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Popular movies from last three years
//Use Stack, Positioned widgets
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

  static Future<Map> getJsonBestMovies(String year) async {
    var apiKey = "2769496ca4cfd8df18f9fea0a40d98e6";
    var apiEndPoint = "http://api.themoviedb.org/3/discover/movie?"
        "api_key=${apiKey}&"
        "primary_release_year=${year}&sort_by=vote_average.desc";
    var apiResponse = await http.get(apiEndPoint);
    return json.decode(apiResponse.body); //dart:convert
  }
}

enum MovieYear { YEAR_2020, YEAR_2019, YEAR_2018 }

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

var screenWidth = 100.0;
var screenHeight = 100.0;
String selectedYear = "2020";
int selectedIndex = 0;

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  var moviesData;
  List<MovieModel> movies = List<MovieModel>();

  fetchMovies(String year) async {
    var data = await MoviesProvider.getJsonBestMovies(year);

    setState(() {
      moviesData = data['results'];

      List<dynamic> results = data['results'];
      results.forEach((element) {
        movies.add(MovieModel.fromJson(element));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMovies(selectedYear);
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: selectedIndex == 0
                ? Icon(
                    Icons.movie,
                    color: Colors.purple,
                  )
                : Icon(Icons.movie),
            title: Text('2020'),
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1
                ? Icon(
                    Icons.movie,
                    color: Colors.purple,
                  )
                : Icon(Icons.movie),
            title: Text('2019'),
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 2
                ? Icon(
                    Icons.movie,
                    color: Colors.purple,
                  )
                : Icon(Icons.movie),
            title: Text('2018'),
          ),
        ],
        fixedColor: Colors.grey,
        onTap: _onYearSelected,
      ),
    );
  }

  _onYearSelected(int tabNo) {
    setState(() {
      selectedIndex = tabNo;
      if (tabNo == 0) {
        selectedYear = "2020";
      } else if (tabNo == 1) {
        selectedYear = "2019";
      } else if (tabNo == 2) {
        selectedYear = "2018";
      }
      movies.clear();
      fetchMovies(selectedYear);
    });
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
    screenWidth = MediaQuery.of(context).size.width / 2;
    screenHeight = MediaQuery.of(context).size.height / 4;

    return Stack(
      alignment: AlignmentDirectional.topStart,
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 8.0, right: 8.0, bottom: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenWidth,
                        height: screenHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                          image: DecorationImage(
                              image: NetworkImage(
                                  MoviesProvider.imagePathPrefix +
                                      movies[index].poster_path),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3.0,
                                offset: Offset(1.0, 3.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movies[index].title,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movies[index].overview,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Sriracha',
                              color: Colors.black),
                        ),
                      ),
                      Divider(color: Colors.grey.shade500),
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
