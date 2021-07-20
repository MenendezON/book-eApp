import 'package:bookeapp/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemSettings,
    itemShare,
  ];

  static const List<MenuItem> itemsSecond = [
    itemSignOut,
  ];

  static const itemSettings = MenuItem (
    text: 'Paramètres',
    icon: Icons.settings,
  );
  static const itemShare = MenuItem (
    text: 'Share',
    icon: Icons.share,
  );
  static const itemSignOut = MenuItem(
    text: 'Sign Out',
    icon: Icons.logout,
  );
}
