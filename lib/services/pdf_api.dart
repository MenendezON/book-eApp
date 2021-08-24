import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';


class PDFApi {
  static Future<File?> loadFirebase(String url) async{
    try{
      final refPDF = FirebaseStorage.instance.ref().child(url);
      final bytes = await refPDF.getData();

      return _storeFile(url,  bytes!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future downloadFile(Reference ref) async{
    final dir = await getApplicationDocumentsDirectory();
    final downloadFileTo = File('${dir.path}/${ref.name}');
    
    await ref.writeToFile(downloadFileTo);
  }

  static UploadTask? uploadFile(String destination, File file) {
    try{
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e){
      print(e.toString());
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try{
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putData(data);
    } on FirebaseException catch (e){
      print(e.toString());
      return null;
    }
  }
}