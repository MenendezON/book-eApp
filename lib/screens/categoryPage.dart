import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:flutter/material.dart';

import 'ProfilePage.dart';

class CategoryPage extends StatefulWidget {
  final String titleCateg;
  const CategoryPage({Key? key, required this.titleCateg}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff333333),
          elevation: 0.0,
          title: Container(
            height: 40,
            child: Image.asset('assets/images/ebook_logo.png'),
          ),
          //centerTitle: true,
          actions: <Widget>[
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
        body: Text(
          'Catégorie : ${widget.titleCateg}'
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
}
