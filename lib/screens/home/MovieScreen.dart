import 'dart:io';

import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:bookeapp/services/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/services/data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../readingPage.dart';
import '../settingspage.dart';

class MovieScreen extends StatefulWidget {
  final MovieOrSeries movieOrSeries;

  const MovieScreen({Key? key, required this.movieOrSeries}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff333333),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            height: 40,
            child: Image.asset('assets/images/ebook_logo.png'),
          ),
          //centerTitle: true,
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
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
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
        body: Stack(
          children: [
            ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(widget.movieOrSeries.coverUrl),
                          )),
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
                                IconButton(
                                  onPressed: () async {
                                    final url = 'pdf/ouvragebooke001.pdf';
                                    final file = await PDFApi.loadFirebase(url);
                                    final rname = widget.movieOrSeries.title;
                                    if (file == null) return;
                                    openPDF(context, file, rname);
                                  },
                                  icon: Icon(
                                    Icons.read_more,
                                    color: Colors.white,
                                  ),
                                ),
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
                                  onPressed: () {},
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
                        widget.movieOrSeries.title.toUpperCase(),
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
                            child: Text(
                              widget.movieOrSeries.categories[0],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            color: Colors.white54,
                            padding: EdgeInsets.all(5),
                            child: Text(
                              widget.movieOrSeries.categories[1],
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
                            widget.movieOrSeries.year.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.movieOrSeries.length,
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
                        widget.movieOrSeries.description,
                        style: TextStyle(
                            color: Colors.white, height: 1.5, fontSize: 13.5),
                      ),
                      SizedBox(
                        height: 10,
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
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/avatar.png'),
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  child: Text(
                                    "Texte de nom", //widget.movieOrSeries.director['name'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: Text(
                                    "Director",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
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
      case MenuItems.itemSettings:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SettingsPage()));
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
