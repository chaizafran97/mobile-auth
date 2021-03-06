import 'package:flutter/material.dart';
import 'package:flutter_movie_app/movie%20by%20year/movie_details.dart';
import 'package:flutter_movie_app/movie%20by%20year/movie_details_api.dart';
import 'movie_popularity.dart';
import 'movie_popularity_api.dart';

class MoviePopularityCustomCard extends StatefulWidget {
  MoviePopularityCustomCard({Key? key}) : super(key: key);

  @override
  _MoviePopularityCustomCardState createState() =>
      _MoviePopularityCustomCardState();
}

class _MoviePopularityCustomCardState extends State<MoviePopularityCustomCard> {
  late List<MoviePopularity> _moviePopularity;
  late List<MovieDetails> _movieDetails;
  bool _isLoading = true;
  //late List<bool> boolList
  List foo = [];

  @override
  void initState() {
    super.initState();
    getMovieYear();
  }

  Future<void> getMovieYear() async {
    _moviePopularity = await MoviePopularityApi.geturl();
    for (var i = 0; i < _moviePopularity.length; i++) {
      _movieDetails =
          await MovieDetailsApi.getDetails(_moviePopularity[i].movie_id);
      //  _movieDetails
      //     .add(await MovieDetailsApi.getDetails(_movieYear[i].movie_id));
      foo.add(_movieDetails);
    }
    // print(_moviePopularity);
    // print(foo);
    setState(() {
      _isLoading = false;
    });
  }

  // changeisPressed(_isPressed) {
  //   setState(() {
  //     if (_isPressed == false) {
  //       _isPressed = true;
  //     } else {
  //       _isPressed = false;
  //     }
  //   });
  // }

  // Future<void> getMovieDetails() async {
  //   //= await MovieDetailsApi.getDetails(_movieYear[index].movie_id);
  //   for (var i = 0; i < _movieYear.length; i++) {
  //     _movieDetails = await MovieDetailsApi.getDetails(_movieYear[i].movie_id);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _moviePopularity.length,
            itemBuilder: (context, index) {
              bool _isPressed = true;
              // var customText =
              //     'Title: ${foo[index][0].movieTitle.toString()}\nYear: ${foo[index][0].year.toString()}\nRating: ${foo[index][0].rating.toString()}\nContent: ${foo[index][0].pgRating.toString()}';
              return Card(
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage(foo[index][0].img.toString()),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          //Text(_movieYear[index].movie_id),
                          //Text(_moviePopularity[index].movie_id),
                          Text(
                            foo[index][0].movieTitle.toString(),
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text('Genre: ' + foo[index][0].genre.toString()),
                          Text('Rating: ' + foo[index][0].rating.toString()),
                          Text('Content: ' + foo[index][0].pgRating.toString()),
                          Text('Length: ' +
                              foo[index][0].movieLength.toString()),
                          // Container(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     customText,
                          //     //overflow: TextOverflow.ellipsis,
                          //     style: TextStyle(fontFamily: 'Arial'),
                          //   ),
                          //   padding: EdgeInsets.all(10),
                          // ),
                          IconButton(
                              onPressed: () {
                                //changeisPressed(_isPressed);
                              },
                              icon: Icon(_isPressed
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined)),
                          // //Text(foo[index][0].img.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
  }
}
