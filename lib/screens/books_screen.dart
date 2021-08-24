import 'dart:io';
import 'package:bookeapp/models/book.dart';
import 'package:bookeapp/models/menu_item.dart';
import 'package:bookeapp/services/menu_item.dart';
import 'package:bookeapp/services/pdf_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bookeapp/common/constants.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bookeapp/services/book_database.dart';
import 'package:path/path.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  UploadTask? task;
  UploadTask? taskpdf;
  File? file;
  File? filepdf;

  final BookDatabaseService bookService = BookDatabaseService();

  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final isbnController = TextEditingController();
  final titreController = TextEditingController();
  final auteurController = TextEditingController();
  final maisonEditionController = TextEditingController();
  final anneeEditonController = TextEditingController();
  final paysEditionController = TextEditingController();
  final pubdateController = TextEditingController();
  final illustrationController = TextEditingController();
  final descriptionController = TextEditingController();

  final filePickerController = TextEditingController();

  String langue = 'Français';
  String categorie = 'Economie';

  String urlBook = "";
  String urlIllustration = "";

  @override
  void dispose() {
    isbnController.dispose();
    titreController.dispose();
    auteurController.dispose();
    maisonEditionController.dispose();
    anneeEditonController.dispose();
    paysEditionController.dispose();
    pubdateController.dispose();
    illustrationController.dispose();
    descriptionController.dispose();
    filePickerController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      isbnController.text = '';
      titreController.text = '';
      auteurController.text = '';
      maisonEditionController.text = '';
      anneeEditonController.text = '';
      paysEditionController.text = '';
      pubdateController.text = '';
      illustrationController.text = '';
      descriptionController.text = '';
      filePickerController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    //CollectionReference books = FirebaseFirestore.instance.collection('books');
    final fileName =
        file != null ? basename(file!.path) : 'Select an image file';
    final fileNamePdf =
        filepdf != null ? basename(filepdf!.path) : 'Select a PDF file';
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.3;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => BooksScreen()));
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
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          IconButton(
                            onPressed: selectCover,
                            icon: Icon(Icons.upload_file, color: Colors.white,),
                          ),
                          Expanded(
                            child: Text(fileName, style: TextStyle(color: Colors.white),),
                          ),
                          Container(
                            height: 40,
                            width: 60,
                            color: Colors.transparent,
                            child: task != null
                                ? buildUploadStatus(task!, 'jpg')
                                : Text('0.00', style: TextStyle(color:Colors.white),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: selectBook,
                            icon: Icon(Icons.upload_file, color: Colors.white,),
                          ),
                          Expanded(
                            child: Text(fileNamePdf, style: TextStyle(color: Colors.white),),
                          ),
                          Container(
                            height: 40,
                            width: 60,
                            color: Colors.transparent,
                            child: taskpdf != null
                                ? buildUploadStatus(taskpdf!, 'pdf')
                                : Text('0.00', style: TextStyle(color:Colors.white),),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: isbnController,
                        keyboardType: TextInputType.number,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'ISBN',
                          fillColor: Colors.white,
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'ISBN' : null,
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        controller: titreController,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Titre du document',
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Titre du document'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        controller: auteurController,
                        decoration: textInputDecoration.copyWith(
                          hintText: "Nom de l'auteur",
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Titre du document'
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Langue du livre : ',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          DropdownButton<String>(
                            value: langue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (String? newValue) {
                              setState(() {
                                langue = newValue!;
                              });
                            },
                            items: <String>[
                              'Allemand',
                              'Anglais',
                              'Créole',
                              'Espagnol',
                              'Français'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Catégorie du livre : ',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          DropdownButton<String>(
                            value: categorie,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (String? newValue) {
                              setState(() {
                                categorie = newValue!;
                              });
                            },
                            items: <String>[
                              'Economie',
                              'Géographie',
                              'Histoire',
                              'Poésie',
                              'Politique',
                              'Roman',
                              'Technologie'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        controller: maisonEditionController,
                        decoration: textInputDecoration.copyWith(
                          hintText: "Maison d'édition",
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Maison d'édition"
                            : null,
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: halfMediaWidth,
                            child: TextFormField(
                              controller: anneeEditonController,
                              keyboardType: TextInputType.number,
                              decoration: textInputDecoration.copyWith(
                                hintText: "Année d'édition",
                                fillColor: Colors.white,
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Année d'édition"
                                      : null,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            width: halfMediaWidth,
                            child: TextFormField(
                              controller: paysEditionController,
                              decoration: textInputDecoration.copyWith(
                                hintText: "Pays d'édition",
                                fillColor: Colors.white,
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Pays d'édition"
                                      : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: textInputDecoration.copyWith(
                          hintText: "Description du livre",
                          fillColor: Colors.white,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Maison d'édition"
                            : null,
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        child: Text(
                          'Ajouter',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() == true) {
                            setState(() => loading = true);

                            uploadFile();
                            uploadFilePDF();

                            var isbn = isbnController.value.text;
                            var titre = titreController.value.text;
                            var auteur = auteurController.value.text;
                            var maison = maisonEditionController.value.text;
                            var annee = anneeEditonController.value.text;
                            var pays = paysEditionController.value.text;
                            var datepub = Timestamp.fromDate(DateTime.now());
                            var desc = descriptionController.value.text;

                            bookService.addBook(Book(
                                isbn,
                                titre,
                                langue,
                                categorie,
                                auteur,
                                maison,
                                int.parse(annee),
                                pays,
                                datepub,
                                desc,
                                0,
                                urlIllustration,
                                urlBook));
                          }
                        },
                      ),
                      task != null
                          ? buildUploadStatus(task!, 'jpg')
                          : Container(),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
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
      case MenuItems.itemShare:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BooksScreen()));
        break;
      case MenuItems.itemSettings:
        break;
      case MenuItems.itemSignOut:
        await _auth.signOut();
        break;
    }
  }

  Future selectCover() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path!));

    //uploadFile();
  }

  Future selectBook() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;
    final path = result.files.single.path;

    setState(() => filepdf = File(path!));

    //uploadFilePDF();
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'img/$fileName';

    task = PDFApi.uploadFile(destination, file!);
    //setState(() {});
    if (task == null) return;
    // ici c'est le lien du fichier charger
    final snapshot = await task!.whenComplete(() {});
    setState(() async {
      urlIllustration = await snapshot.ref.getDownloadURL();
    });
  }

  Future uploadFilePDF() async {
    if (filepdf == null) return;

    final fileName = basename(filepdf!.path);
    final destination = 'pdf/$fileName';

    taskpdf = PDFApi.uploadFile(destination, filepdf!);
    //setState(() {});
    if (taskpdf == null) return;
    // ici c'est le lien du fichier charger
    final snapshot = await taskpdf!.whenComplete(() {});
    setState(() async {
      urlBook = await snapshot.ref.getDownloadURL();
    });
  }

  Widget buildUploadStatus(UploadTask uploadTask, String ext) {
    switch (ext) {
      case 'pdf':
        return StreamBuilder<TaskSnapshot>(
            stream: taskpdf!.snapshotEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!;
                final progress = snap.bytesTransferred / snap.totalBytes;
                final percentage = (progress * 100).toStringAsFixed(2);

                return Text(
                  '$percentage %',
                );
              } else {
                return Container();
              }
            });
      default:
        return StreamBuilder<TaskSnapshot>(
            stream: task!.snapshotEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!;
                final progress = snap.bytesTransferred / snap.totalBytes;
                final percentage = (progress * 100).toStringAsFixed(2);

                return Text(
                  '$percentage %',
                );
              } else {
                return Container();
              }
            });
    }
  }
}
