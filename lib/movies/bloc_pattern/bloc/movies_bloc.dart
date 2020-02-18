import 'dart:async';

import 'package:flutter_course/movies/bloc_pattern/model/movie.dart';
import 'package:flutter_course/movies/bloc_pattern/repository/repository.dart';

import 'bloc.dart';

class MoviesBloc implements Bloc {
  final _moviesRepo = Repository();
  final _controller = StreamController<List<Movie>>();

  Stream<List<Movie>> get stream => _controller.stream;

  fetchMoviesByYear(String year) async {
    final List<Movie> model = await _moviesRepo.moviesByTheYear(year);
    _controller.sink.add(model);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
