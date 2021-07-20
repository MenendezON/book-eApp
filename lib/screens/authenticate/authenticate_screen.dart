import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bookeapp/common/constants.dart';
import 'package:bookeapp/common/loading.dart';
import 'package:bookeapp/services/authentication.dart';
import 'package:bookeapp/common/strings.dart';

class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool showSignIn = true;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      nameController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    int randomNumber = random.nextInt(3);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            /*appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text(showSignIn ? 'Sign in to Water Social' : 'Register to Water Social'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(showSignIn ? "Register" : 'Sign In',
                style: TextStyle(color: Colors.white)),
            onPressed: () => toggleView(),
          ),
        ],
      ),*/
            body: Container(
              //height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 40.0, right: 40.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg$randomNumber.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _formKey,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2.0,
                    sigmaY: 2.0,
                  ),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/ebook_logo.png',
                          fit: BoxFit.fitWidth,
                        ),
                        !showSignIn
                            ? TextFormField(
                                controller: nameController,
                                decoration: textInputDecoration.copyWith(
                                    hintText: Strings().fieldName),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? Strings().fieldName
                                        : null,
                              )
                            : Container(),
                        //!showSignIn ? SizedBox(height: 5.0) : Container(),
                        TextFormField(
                          controller: emailController,
                          decoration: textInputDecoration.copyWith(
                              hintText: Strings().fieldEmail),
                          validator: (value) => value == null || value.isEmpty
                              ? Strings().fieldEmail
                              : null,
                        ),
                        //SizedBox(height: 5.0),
                        TextFormField(
                          controller: passwordController,
                          decoration: textInputDecoration.copyWith(
                              hintText: Strings().fieldPwd),
                          obscureText: true,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? Strings().fieldPwdExtra
                                  : null,
                        ),
                        SizedBox(height: 5.0),
                        ElevatedButton(
                          child: Text(
                            showSignIn
                                ? Strings().txtConnection
                                : Strings().txtRegister,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() => loading = true);
                              var password = passwordController.value.text;
                              var email = emailController.value.text;
                              var name = nameController.value.text;

                              dynamic result = showSignIn
                                  ? await _auth.signInWithEmailAndPassword(
                                      email, password)
                                  : await _auth.registerWithEmailAndPassword(
                                      name, email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = Strings().validEmail;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        ),
                        TextButton(
                          onPressed: () => toggleView(),
                          child: Text(
                            showSignIn
                                ? Strings().txtBtnSignOut
                                : Strings().txtBtnSignIn,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
