import 'package:bookeapp/common/strings.dart';
import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/screens/app/home_screen.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/common/loading.dart';
import 'package:bookeapp/models/user.dart';
import 'package:bookeapp/screens/home/user_list.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/services/database.dart';
import 'package:provider/provider.dart';

import '../settingspage.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) throw Exception("user not found");
    final database = DatabaseService(user.uid);

    return StreamProvider<List<AppUserData>>.value(
      initialData: [],
      value: database.users,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(230, 236, 236, 1),
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
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
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
        body: Center(
          child: Text("texte"),
        ),
        
        //UserList(),//HomeScreenApp(),
      ),
    );


  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.black, size: 20),
            SizedBox(width:10),
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

/*void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }*/

}
