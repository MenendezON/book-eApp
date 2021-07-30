import 'package:flutter/material.dart';
import 'package:bookeapp/services/data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryContainer extends StatelessWidget {
  final MovieOrSeries movieOrSeries;



  const CategoryContainer({Key? key, required this.movieOrSeries})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
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
        Fluttertoast.showToast(
            msg: 'Catégorie : ${movieOrSeries.title}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }
}