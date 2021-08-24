import 'package:bookeapp/screens/categoryPage.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/services/data.dart';

class CategoryContainer extends StatelessWidget {
  final MovieOrSeries movieOrSeries;

  const CategoryContainer({Key? key, required this.movieOrSeries})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0.1,
              offset: Offset(0, 0),
              blurRadius: 2,
            )
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: 300,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(movieOrSeries.coverUrl),
              )),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black54,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${movieOrSeries.title}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print('Catégorie : ${movieOrSeries.title}');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CategoryPage(titleCateg: movieOrSeries.title)));
      },
    );
  }
}
