import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String isbn;
  final String titre;
  final String langue;
  final String categorie;
  final String uid;
  final String maisonEdition;
  final int anneeEdition;
  final String paysEdition;
  final Timestamp pubDate;
  final String urlBook;
  final int vue;
  final String illustrator;
  final String description;

  Book(
      this.isbn,
      this.titre,
      this.langue,
      this.categorie,
      this.uid,
      this.maisonEdition,
      this.anneeEdition,
      this.paysEdition,
      this.pubDate,
      this.description,
      this.vue,
      this.illustrator,
      this.urlBook);
}
