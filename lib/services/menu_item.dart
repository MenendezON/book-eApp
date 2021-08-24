import 'package:bookeapp/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemProfile,
    itemShare,
    itemSettings,
  ];

  static const List<MenuItem> itemsSecond = [
    itemSignOut,
  ];

  static const itemProfile = MenuItem (
    text: 'Profil',
    icon: Icons.account_circle_rounded,
  );

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
