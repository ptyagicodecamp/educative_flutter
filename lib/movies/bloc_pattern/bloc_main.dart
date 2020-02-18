import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/movies_bloc.dart';
import 'ui/main_screen.dart';

void main() => runApp(MovieApp());

class MovieApp extends StatelessWidget {
  final MoviesBloc bloc = MoviesBloc();
  @override
  Widget build(BuildContext context) {
    bloc.fetchMoviesByYear("2020");
    return BlocProvider<MoviesBloc>(
      bloc: bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Popular Movies',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: MoviesMainScreen(),
      ),
    );
  }
}
