import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_course/movies/bloc_pattern/bloc/bloc_provider.dart';
import 'package:flutter_course/movies/bloc_pattern/bloc/movies_bloc.dart';
import 'package:flutter_course/movies/bloc_pattern/model/movie.dart';
import '../../movie_app/movies_main.dart';

class MovieScreen extends StatefulWidget {
  final List<Movie> movies;

  const MovieScreen({this.movies});
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  static String selectedYear = "2020";
  static int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return moviesListing(context, widget.movies);
  }

  Widget moviesListing(BuildContext context, final List<Movie> movies) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.movies == null ? 0 : widget.movies.length,
        itemBuilder: (context, index) {
          return MovieTile(widget.movies, index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: selectedIndex == 0
                ? Icon(
                    Icons.movie,
                    color: Colors.deepPurple,
                  )
                : Icon(Icons.movie),
            title: Text('2020'),
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1
                ? Icon(
                    Icons.movie,
                    color: Colors.deepPurple,
                  )
                : Icon(Icons.movie),
            title: Text('2019'),
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 2
                ? Icon(
                    Icons.movie,
                    color: Colors.deepPurple,
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
      widget.movies.clear();
      BlocProvider.of<MoviesBloc>(context).fetchMoviesByYear(selectedYear);
    });
  }
}

class MovieTile extends StatelessWidget {
  final List<Movie> movies;
  final index;

  const MovieTile(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 2;
    final screenHeight = MediaQuery.of(context).size.height / 4;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
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
                            image: movies[index].poster_path != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        MoviesProvider.imagePathPrefix +
                                            movies[index].poster_path),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: NetworkImage(
                                        "https://github.com/ptyagicodecamp/openmedia/raw/master/images/animals/cat.jpg"),
                                    fit: BoxFit.cover,
                                  ),
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
      ),
    );
  }
}
