import 'package:flutter_course/movies/bloc_pattern/model/movie.dart';
import 'movies_provider.dart';

class Repository {
  final moviesAPI = MoviesProvider();

  Future<List<Movie>> moviesByTheYear(String year) =>
      moviesAPI.getBestMoviesByYear(year);
}
