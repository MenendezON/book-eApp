import 'package:bookeapp/screens/home/MovieScreen.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/services/data.dart';
//import 'package:netflixredesign/Screens/MovieScreen.dart';

class MainContainer extends StatelessWidget {
  final MovieOrSeries movieOrSeries;

  const MainContainer({Key? key, required this.movieOrSeries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 150,
        width: 300,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(movieOrSeries.coverUrl),
            )),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MovieScreen(movieOrSeries: movieOrSeries)));
      },
    );
  }
}