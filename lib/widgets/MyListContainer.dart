import 'package:bookeapp/screens/home/MovieScreen.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/services/data.dart';

class MyListContainer extends StatelessWidget {
  final MovieOrSeries movieOrSeries;

  const MyListContainer({Key? key, required this.movieOrSeries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 300,
        width: 150,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(movieOrSeries.coverUrl),
            )),
      ),
      onTap: () {},
    );
  }
}