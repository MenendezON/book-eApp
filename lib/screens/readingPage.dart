import 'dart:io';

import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  final String realName;

  const PDFViewerPage({Key? key, required this.file, required this.realName})
      : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  final AuthenticationService _auth = AuthenticationService();
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final text = '${indexPage + 1} of $pages';
    final rname = widget.realName;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(rname),
        //centerTitle: true,
        actions: <Widget>[
          Center(
            child: Text(text),
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
        child: PDFView(
          filePath: widget.file.path,
          //swipeHorizontal: true,
          pageSnap: false,
          autoSpacing: false,
          pageFling: false,

          onRender: (pages) => setState(() => this.pages = pages!),
          onViewCreated: (controller) => setState(() => this.controller = controller),
          onPageChanged: (indexPage, _) => setState(() => this.indexPage = indexPage!),

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
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage('', '', 0)));
        break;
      case MenuItems.itemSignOut:
        await _auth.signOut();
        break;
    }
  }
}
