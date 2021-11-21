import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatefulWidget {
  final img, place;

  const Checkout({Key? key, this.img, this.place}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width - 80,
        height: 56,
        child: RaisedButton(
          onPressed: () => {},
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          color: Color(0xFF82B1FF),
          child: Text(
            "Total Cost:RM 2345 | Check Out",
            overflow: TextOverflow.visible,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
          child: Container(
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
                      margin: EdgeInsets.only(top: 40),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Package - 3 Days 2 Night",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff5A6C64)),
              ),
            ),
            Container(
              height: 140,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: Color(0xffE9F4F9),
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Image.asset(
                              widget.img,
                              width: 120,
                              height: 120,
                            ),
                          ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Container(
                              height: 80,
                              child: VerticalDivider(
                                  color: Colors.black, width: 20)),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            // padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.place,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff5A6C64)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Japan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff5A6C64)),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Text(
                                  "RM 200",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5A6C64)),
                                )
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.all(0),
                              child: Row(
                                children: [
                                  _itemCount != 1
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                          onPressed: () =>
                                              setState(() => _itemCount--),
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                          onPressed: () {}),
                                  Text(_itemCount.toString()),
                                  IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                      onPressed: () =>
                                          setState(() => _itemCount++))
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(
                "Flights Details",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff5A6C64)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 140,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Icon(
                                    Icons.airplanemode_active,
                                    size: 33,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  "Airplane",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5A6C64)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    size: 15),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Japan",
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
                                  "18.1.2022 - 21.1.2022",
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
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(
                "Hotel Option",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff5A6C64)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 150.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) => hotellist(
                        'Assets/images/japan.jpg',
                        'Four Seasons',
                        'Double bed rooms',
                        '4'),
                  ),
                ),
              ),
            ),
          ]))),
    );
  }

  hotellist(String img, String place, String room, String star) {
    final children = <Widget>[];
    for (var i = 0; i < int.parse(star); i++) {
      children.add(
        Icon(Icons.star, size: 14),
      );
    }
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Image.asset(
                      img,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width - 260,
                      height: MediaQuery.of(context).size.height - 640,
                    ),
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  Container(
                      height: 80,
                      child: VerticalDivider(color: Colors.black, width: 20)),
                  Container(
                    // padding: EdgeInsets.only(right: 10),
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5A6C64)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          room,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff5A6C64)),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          child: Row(children: children
                              //     // ignore: unused_local_variable
                              //     for(var i in star)
                              //  Icon(Icons.star_border, size: 14),

                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Row(
                    children: [
                      _itemCount != 1
                          ? IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 16,
                              ),
                              onPressed: () => setState(() => _itemCount--),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 16,
                              ),
                              onPressed: () {}),
                      Text(_itemCount.toString()),
                      IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 16,
                          ),
                          onPressed: () => setState(() => _itemCount++))
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
