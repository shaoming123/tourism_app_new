//@dart=2.9
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourismapp/Screens/sign_in.dart';
import 'package:tourismapp/pallete.dart';
import 'package:tourismapp/widgets/background-image.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

final auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _RegisterState extends State<Register> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController email;
  TextEditingController password;
  TextEditingController username;
  TextEditingController phone;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    username = TextEditingController();
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            BackgroundImage(image: 'Assets/initial/register.jpg'),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: size.width * 0.1,
                    // ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),

                    Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.grey[500].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.user,
                                        size: 28,
                                        color: kWhite,
                                      ),
                                    ),
                                    hintText: 'UserName',
                                    hintStyle: kBodyText,
                                    errorStyle: TextStyle(
                                        color: Colors.red[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        height: 0.1),
                                  ),
                                  style: kBodyText,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  controller: username,
                                  validator: (val) => val.isNotEmpty
                                      ? null
                                      : "Please enter a username",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.grey[500].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.phone,
                                        size: 28,
                                        color: kWhite,
                                      ),
                                    ),
                                    hintText: 'Phone Number',
                                    hintStyle: kBodyText,
                                    errorStyle: TextStyle(
                                        color: Colors.red[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        height: 0.1),
                                  ),
                                  style: kBodyText,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  controller: phone,
                                  validator: (val) => val.isNotEmpty
                                      ? null
                                      : "Please enter your phone number",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.grey[500].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    // contentPadding:
                                    //     EdgeInsets.only(bottom: 110.0),
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.envelope,
                                        size: 28,
                                        color: kWhite,
                                      ),
                                    ),
                                    hintText: 'Email',
                                    hintStyle: kBodyText,
                                    errorStyle: TextStyle(
                                        color: Colors.red[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        height: 0.1),
                                  ),
                                  style: kBodyText,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: email,
                                  validator: (val) => val.isNotEmpty
                                      ? null
                                      : "Please enter a email address",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.grey[500].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.lock,
                                        size: 28,
                                        color: kWhite,
                                      ),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: kBodyText,
                                    errorStyle: TextStyle(
                                        color: Colors.red[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        height: 0.1),
                                  ),
                                  obscureText: true,
                                  style: kBodyText,
                                  textInputAction: TextInputAction.done,
                                  controller: password,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (value.length < 8) {
                                      return 'Password should be at least 8 characters';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kBlue,
                            ),
                            child: FlatButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  addUser();
                                }
                              },
                              child: Text(
                                'Register',
                                style: kBodyText.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: kBodyText,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignIn()));
                                },
                                child: Text(
                                  ' Login',
                                  style: kBodyText.copyWith(
                                      color: kBlue,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addUser() async {
    try {
      final User user = (await auth.createUserWithEmailAndPassword(
              email: email.text, password: password.text))
          .user;
      if (user != null) {
        firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          'username': username.text,
          'email': email.text,
          'phone': phone.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignIn()));
      } else {
        _scaffoldKey.currentState.showSnackBar(
          const SnackBar(
            content: Text("Account has been created already"),
          ),
        );
      }
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          content:
              Text("The email address is already in use by another account"),
        ),
      );
    }
  }
}
