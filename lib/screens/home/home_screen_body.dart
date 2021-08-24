import 'package:bookeapp/models/book.dart';
import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/models/user.dart';
import 'package:bookeapp/screens/ProfilePage.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/services/database.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:bookeapp/widgets/CategorieContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bookeapp/services/data.dart';
import 'package:bookeapp/widgets/ContinueWatchingContainer.dart';
import 'package:bookeapp/widgets/MainContainer.dart';
import 'package:bookeapp/widgets/MyListContainer.dart';
import 'package:provider/provider.dart';

import '../books_screen.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  //final CollectionReference books = FirebaseFirestore.instance.collection('books');
  final Stream<QuerySnapshot> books =
      FirebaseFirestore.instance.collection('books').snapshots();
  final AuthenticationService _auth = AuthenticationService();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) throw Exception("user not found");
    final database = DatabaseService(user.uid);

    return StreamProvider<List<AppUserData>>.value(
      initialData: [],
      value: database.users,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            height: 25,
            child: Text(
              'Bookey'.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.library_add_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BooksScreen()));
              },
            ),
            PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(buildItem).toList(),
                PopupMenuDivider(),
                ...MenuItems.itemsSecond.map(buildItem).toList(),
              ],
              icon: Icon(Icons.more_vert),
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
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    // start test part
                    Container(
                        height: 200,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: books,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong.');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Text(
                                  'Loading...',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            final data = snapshot.requireData;
                            return ListView.builder(
                              itemCount: data.size,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Book book = Book(
                                    data.docs[index]['isbn'],
                                    data.docs[index]['titre'],
                                    data.docs[index]['langue'],
                                    data.docs[index]['categorie'],
                                    data.docs[index]['auteur'],
                                    data.docs[index]['maison_edition'],
                                    data.docs[index]['annee_edition'],
                                    data.docs[index]['pays_edition'],
                                    data.docs[index]['pub_date'],
                                    data.docs[index]['description'],
                                    data.docs[index]['vue'],
                                    data.docs[index]['url_image'],
                                    data.docs[index]['url_book']);
                                return MainContainer(book: book);
                              },
                            );
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    // end test part
                    Row(
                      children: [
                        Text(
                          'Catégories',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: categoryList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            MovieOrSeries movieOrSeries = categoryList[index];
                            return CategoryContainer(
                              movieOrSeries: movieOrSeries,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Continue watching',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: continueWatching.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            MovieOrSeries movieOrSeries =
                                continueWatching[index];
                            return ContinueWatchingContainer(
                              movieOrSeries: movieOrSeries,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'My List',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 70),
                  ],
                ),
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
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
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
      case MenuItems.itemShare:
        break;
      case MenuItems.itemSettings:
        break;
      case MenuItems.itemSignOut:
        await _auth.signOut();
        break;
    }
  }
}
