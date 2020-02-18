import 'package:flutter_course/movies/bloc_pattern/model/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider {
  static final String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  /// Movies listing by the year
  Future<List<Movie>> getBestMoviesByYear(String year) async {
    return await MoviesProvider.getJsonBestMovies(year);
  }

  static Stream<List<Movie>> streamFromFuture<T>(
      Future<List<Movie>> future) async* {
    var result = await future;
    yield result;
  }

  static Future<List> getJsonBestMovies(String year) async {
    var apiKey = "2769496ca4cfd8df18f9fea0a40d98e6";
    var apiEndPoint = "http://api.themoviedb.org/3/discover/movie?"
        "api_key=${apiKey}&"
        "primary_release_year=${year}&sort_by=vote_average.desc";
    var apiResponse = await http.get(apiEndPoint);
    List results = json.decode(apiResponse.body)['results']; //dart:convert

    List<Movie> movies = [];
    results.forEach((element) {
      movies.add(Movie.fromJson(element));
    });

    return movies;
  }
}
