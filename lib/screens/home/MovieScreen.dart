import 'dart:io';

import 'package:bookeapp/models/book.dart';
import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:bookeapp/services/pdf_api.dart';
import 'package:bookeapp/widgets/MyListContainer.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/services/data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../ProfilePage.dart';
import '../readingPage.dart';

class MovieScreen extends StatefulWidget {
  final Book book;

  const MovieScreen({Key? key, required this.book}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final AuthenticationService _auth = AuthenticationService();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {

    /*isLoading = false;
    print(widget.book.urlBook);*/
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            height: 25,
            child: Text('Bookey'.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.star_border,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "This is Center Short Toast",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black12,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            ),
            PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(buildItem).toList(),
                PopupMenuDivider(),
                ...MenuItems.itemsSecond.map(buildItem).toList(),
              ],
              icon: Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.blueGrey.shade900, Colors.black],
              center: Alignment.center,
              radius: 3,
            ),
          ),
          child: Stack(
            children: [
              ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          widget.book.illustrator,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: Colors.black45,
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Partager',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 75,
                              ),
                              Column(
                                children: [
                                  !isLoading? IconButton(
                                    onPressed: () async {
                                      Fluttertoast.showToast(
                                          msg: "Veuillez patientez le temps du chagement du document",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black12,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      setState(() {
                                        isLoading = true;
                                      });
                                      final url = 'pdf/${widget.book.urlBook}';
                                      final file = await PDFApi.loadFirebase(url);
                                      final rname = widget.book.titre;
                                      if (file == null) return;
                                      setState(() {
                                        isLoading = false;
                                      });
                                      openPDF(context, file, rname);
                                    },
                                    icon: Icon(
                                      Icons.read_more,
                                      color: Colors.white,
                                    ),
                                  ) : Center(child: CircularProgressIndicator(),),
                                  Text(
                                    'Lecture',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 75,
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () async{},
                                    icon: Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Télécharger',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.titre.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.white54,
                              padding: EdgeInsets.all(5),
                              child: Text(widget.book.categorie,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Auteur : ${widget.book.uid}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.book.description,
                          style: TextStyle(
                              color: Colors.white, height: 1.5, fontSize: 13.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Du même auteur'.toUpperCase(), style:TextStyle(color:Colors.white)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                              itemCount: myList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                MovieOrSeries movieOrSeries = myList[index];
                                return MyListContainer(
                                  movieOrSeries: movieOrSeries,
                                );
                              }),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 10,
                right: 20,
                left: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: GNav(
                      gap: 8,
                      activeColor: Colors.white,
                      iconSize: 25,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      duration: Duration(milliseconds: 800),
                      tabBackgroundColor: Colors.black54,
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          text: 'Home',
                        ),
                        GButton(
                          icon: Icons.search,
                          text: 'Search',
                        ),
                        GButton(
                          icon: Icons.play_circle_outline,
                          text: 'explore',
                        ),
                        GButton(
                          icon: Icons.file_download,
                          text: 'download',
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.black, size: 20),
            SizedBox(width: 10),
            Text(item.text),
          ],
        ),
      );

  onSelected(BuildContext context, MenuItem item) async {
    switch (item) {
      case MenuItems.itemProfile:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
        case MenuItems.itemSettings:
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage('', '', 0)));
        break;
      case MenuItems.itemSignOut:
        await _auth.signOut();
        break;
    }
  }

  void openPDF(BuildContext context, File file, String rname) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file, realName: rname,)),
      );
}
