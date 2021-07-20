import 'package:flutter/material.dart';

const appColor = Color.fromRGBO(56, 174, 173, 1);

const textInputDecoration = InputDecoration(
  //fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.blueGrey, width:1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.blue, width:1.0),
  ),
);