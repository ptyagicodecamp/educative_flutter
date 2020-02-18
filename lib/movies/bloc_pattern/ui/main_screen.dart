import 'package:flutter/material.dart';
import 'package:flutter_course/movies/bloc_pattern/bloc/bloc_provider.dart';
import 'package:flutter_course/movies/bloc_pattern/bloc/movies_bloc.dart';
import 'package:flutter_course/movies/bloc_pattern/model/movie.dart';
import 'movie_screen.dart';

class MoviesMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
        stream: BlocProvider.of<MoviesBloc>(context).stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MovieScreen(
              movies: snapshot.data,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
