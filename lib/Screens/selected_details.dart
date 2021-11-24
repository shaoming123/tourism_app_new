//@dart=2.9

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourismapp/Screens/checkout.dart';
import 'package:tourismapp/models/beach_model.dart';
import 'package:tourismapp/models/popular_model.dart';
import 'package:tourismapp/models/tourism_model.dart';

import 'cart.dart';

class SelectedDetails extends StatefulWidget {
  final countryIndex, index;
  const SelectedDetails({Key key, this.index, this.countryIndex})
      : super(key: key);

  @override
  State<SelectedDetails> createState() => _SelectedDetailsState();
}

class _SelectedDetailsState extends State<SelectedDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> cartList = [];
//  String uid = "";
//   String _phone = "";
//   String _email = "";
  User _user;
  @override
  void initState() {
    _user = _auth.currentUser;

    super.initState();
  }

  void addtoCart(country, state) {
    String cart_id =
        _user.uid + DateTime.now().millisecondsSinceEpoch.toString();

    try {
      firestore.collection("cart").doc(cart_id).set({
        "cartId": cart_id,
        "uid": _user.uid,
        'countryNum': country,
        'stateNum': state,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          content: Text("Tourism Package added successfully !"),
        ),
      );
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width - 200,
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () => {addtoCart(widget.countryIndex, widget.index)},
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Add to Cart",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).textTheme.bodyText2.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkout(
                          countryIndex: widget.countryIndex,
                          index: widget.index),
                    ),
                  )
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Book Now",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).textTheme.bodyText2.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    tourism[int.parse(widget.countryIndex)]
                        .stateImage[int.parse(widget.index)],
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 350,
                    color: Colors.black12,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 24,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Cart(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.shopping_cart_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 35),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tourism[int.parse(widget.countryIndex)]
                                    .stateName[int.parse(widget.index)],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    tourism[int.parse(widget.countryIndex)]
                                        .countryName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 8,
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     RatingBar(widget.rating.round()),
                              //     SizedBox(
                              //       width: 8,
                              //     ),
                              //     Text(
                              //       "${widget.rating}",
                              //       style: TextStyle(
                              //           color: Colors.white70,
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 17),
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "RM " +
                          (tourism[int.parse(widget.countryIndex)]
                              .priceStart[int.parse(widget.index)]) +
                          " - " +
                          (tourism[int.parse(widget.countryIndex)]
                              .priceEnd[int.parse(widget.index)]),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).textTheme.caption.color),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FeaturesTile(
                        icon: Icon(Icons.fastfood,
                            color: Theme.of(context).buttonColor),
                        label: "Breakfast",
                      ),
                      FeaturesTile(
                        icon: Icon(Icons.airport_shuttle,
                            color: Theme.of(context).buttonColor),
                        label: "Transport",
                      ),
                      FeaturesTile(
                        icon: Icon(Icons.airplane_ticket,
                            color: Theme.of(context).buttonColor),
                        label: "Ticket",
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: Color(0xffE9F4F9),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffD5E6F2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.card_travel,
                                        size: 33,
                                      )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Package",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5A6C64)),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        tourism[int.parse(widget.countryIndex)]
                                            .package[int.parse(widget.index)],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5A6C64)),
                                      )
                                    ],
                                  ),
                                ],
                              ),

                              // Text(
                              //   " Based on 30 reviews",
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w600,
                              //       color: Color(0xff879D95)),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: Color(0xffE9F4F9),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffD5E6F2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          Icon(Icons.hotel_outlined, size: 30)),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hotel",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5A6C64)),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "3 / 4 / 5 stars",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5A6C64)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Flight details
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Flight Details",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).textTheme.caption.color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 140,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                              color: Color(0xffE9F4F9),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Color(0xffD5E6F2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.airplanemode_active,
                                          size: 30,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        "Airplane",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5A6C64)),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Malaysia",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff5A6C64)),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "01:30 PM",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff5A6C64)),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 15),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tourism[int.parse(
                                                  widget.countryIndex)]
                                              .countryName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff5A6C64)),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "04:30 PM",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff5A6C64)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Date: ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5A6C64)),
                                      ),
                                      Text(
                                        tourism[int.parse(widget.countryIndex)]
                                            .date[int.parse(widget.index)],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff5A6C64)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      tourism[int.parse(widget.countryIndex)]
                          .description[int.parse(widget.index)],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.caption.color),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Recommanded Place",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).textTheme.caption.color),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 320,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: beaches.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ImageListTile(
                            imgUrl: beaches[index].image,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturesTile extends StatelessWidget {
  final Icon icon;
  final String label;
  FeaturesTile({this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context)
                          .textTheme
                          .caption
                          .color
                          .withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(40)),
              child: icon,
            ),
            SizedBox(
              height: 9,
            ),
            Container(
                width: 70,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.caption.color),
                ))
          ],
        ),
      ),
    );
  }
}

// class RatingBar extends StatelessWidget {
//   final int rating;
//   RatingBar(this.rating);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.star,
//           color: rating >= 1 ? Colors.white70 : Colors.white30,
//         ),
//         SizedBox(
//           width: 3,
//         ),
//         Icon(
//           Icons.star,
//           color: rating >= 2 ? Colors.white70 : Colors.white30,
//         ),
//         SizedBox(
//           width: 3,
//         ),
//         Icon(
//           Icons.star,
//           color: rating >= 3 ? Colors.white70 : Colors.white30,
//         ),
//         SizedBox(
//           width: 3,
//         ),
//         Icon(
//           Icons.star,
//           color: rating >= 4 ? Colors.white70 : Colors.white30,
//         ),
//         SizedBox(
//           width: 3,
//         ),
//         Icon(
//           Icons.star,
//           color: rating >= 5 ? Colors.white70 : Colors.white30,
//         ),
//       ],
//     ));
//   }
// }

class ImageListTile extends StatelessWidget {
  final String imgUrl;
  ImageListTile({@required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          height: 220,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
