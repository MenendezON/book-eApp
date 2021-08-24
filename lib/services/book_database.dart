import 'package:bookeapp/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookDatabaseService {

  final CollectionReference books = FirebaseFirestore.instance.collection('books');



  Future<void> addBook(Book bk) {
    // Call the user's CollectionReference to add a new user

    return books.add({
      'isbn': bk.isbn,
      'titre': bk.titre,
      'langue': bk.langue,
      'categorie': bk.categorie,
      'auteur': bk.uid,
      'maison_edition': bk.maisonEdition,
      'annee_edition': bk.anneeEdition,
      'pays_edition': bk.paysEdition,
      'pub_date': bk.pubDate,
      'url_book': bk.urlBook,
      'url_image': bk.illustrator,
      'description': bk.description
    }).then((value) => Fluttertoast.showToast(
        msg: 'Le livre a été ajouté.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0))
        .catchError((error) => print("Failed to add user: $error"));
  }




}
