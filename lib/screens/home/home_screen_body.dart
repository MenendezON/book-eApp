import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/models/user.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/services/database.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:bookeapp/widgets/CategorieContainer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bookeapp/services/data.dart';
import 'package:bookeapp/widgets/ContinueWatchingContainer.dart';
import 'package:bookeapp/widgets/MainContainer.dart';
import 'package:bookeapp/widgets/MyListContainer.dart';
import 'package:provider/provider.dart';

import '../settingspage.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
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
        //backgroundColor: Color(0xff333333),
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {}),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            height: 40,
            child: Image.asset('assets/images/ebook_logo.png'),
          ),
          centerTitle: true,
          actions: <Widget>[
            /*IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),*/
            PopupMenuButton<MenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(buildItem).toList(),
                PopupMenuDivider(),
                ...MenuItems.itemsSecond.map(buildItem).toList(),
              ],
              icon: Icon(Icons.more_vert, color: Colors.black),
            ),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: mainList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          MovieOrSeries movieOrSeries = mainList[index];
                          return MainContainer(
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
                        'Catégories',
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
                          MovieOrSeries movieOrSeries = continueWatching[index];
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
}
