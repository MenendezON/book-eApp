import 'package:bookeapp/models/book.dart';
import 'package:bookeapp/models/firebase_file.dart';
import 'package:bookeapp/screens/home/MovieScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/services/data.dart';
import 'package:transparent_image/transparent_image.dart';

class MainContainer extends StatelessWidget {
  final Book book;

  const MainContainer({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('To read ${book.illustrator}');
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0,
              offset: Offset(0, 0),
              blurRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: 300,
              width: 200,
              padding: EdgeInsets.all(25),
              child: CachedNetworkImage(
                imageUrl: book.illustrator,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              /*child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: book.illustrator,
                  fit: BoxFit.cover,
              ),*/

              /*child: Image.network(
                book.illustrator,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : LinearProgressIndicator(
                          semanticsLabel: 'Loading',
                        );
                },
              ),*/
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieScreen(book: book)));
      },
    );
  }
}
