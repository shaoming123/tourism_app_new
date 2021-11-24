//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourismapp/Screens/checkout.dart';
import 'package:tourismapp/Screens/selected_details.dart';
import 'package:tourismapp/models/tourism_model.dart';
import 'package:tourismapp/widgets/bottom_navigation_bar.dart';

import 'details_page.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> countryList = [];
  List<String> stateList = [];
  User _user;
  @override
  void initState() {
    _user = _auth.currentUser;
    firestore.collection("cart").get().then((value) {
      for (var v in value.docs) {
        if (_user.uid == v["uid"]) {
          setState(() {
            countryList.add(v["countryNum"]);
            stateList.add(v["stateNum"]);
          });
        }
      }
    });
    super.initState();
  }

  void removeData(country, state) {
    firestore.collection("cart").get().then((value) {
      for (var v in value.docs) {
        if (_user.uid == v["uid"]) {
          if (country == v['countryNum'] && state == v["stateNum"]) {
            firestore.collection("cart").doc(v['cartId']).delete();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ),
            );
          }
        }
      }
    });
  }

  listItem(countryNum, stateNum) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Checkout(countryIndex: countryNum, index: stateNum),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
        child: Container(
            child: Stack(
          children: <Widget>[
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: AssetImage(tourism[int.parse(countryNum)]
                        .stateImage[int.parse(stateNum)]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.darken)),
              ),
            ),
            Container(
              height: 100.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tourism[int.parse(countryNum)].countryName,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            tourism[int.parse(countryNum)]
                                .stateName[int.parse(stateNum)],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        key: Key('icon'),
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // print(
                          //     firestore.collection("favorite").doc().delete());
                          removeData(countryNum, stateNum);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: BottomNavigationBarTravel(),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 40.0, right: 15.0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'MY CART',
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: countryList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        listItem(countryList[index], stateList[index]),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
