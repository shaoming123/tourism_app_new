//@dart=2.9
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tourismapp/Screens/sign_in.dart';

import 'package:tourismapp/models/tourism_model.dart';
import 'package:tourismapp/widgets/bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'details_page.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final _pageController = PageController(viewportFraction: 0.877);

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _username;
  String _phone;

  User _user;
  @override
  void initState() {
    _user = _auth.currentUser;
    firestore.collection("users").doc(_user.uid).get().then((value) {
      setState(() {
        _username = value.data()['username'];
        _phone = value.data()['phone'];
      });
    });
    super.initState();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn()));
  }

  listItem(String img, String country, String message, String index) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
          child: Stack(
        children: <Widget>[
          Container(
            height: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.darken)),
            ),
          ),
          Container(
            height: 400.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    country,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    message,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                              img: img, country: country, index: index),
                        ),
                      );
                    },
                    child: Container(
                      height: 70.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Explore now',
                          style: GoogleFonts.montserrat(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              textStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: const BottomNavigationBarTravel(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Text(
                        'HOME',
                        style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.logout),
                            color: Colors.white,
                            onPressed: () {
                              logout();
                            })),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 150.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: ListView.builder(
                      itemCount: tourism.length,
                      itemBuilder: (BuildContext context, int index) =>
                          listItem(
                              tourism[index].countryImage,
                              tourism[index].countryName,
                              tourism[index].shortDescription,
                              index.toString()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
