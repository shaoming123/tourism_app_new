//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourismapp/models/tourism_model.dart';

class Checkout extends StatefulWidget {
  final countryIndex, index;

  const Checkout({Key key, this.countryIndex, this.index}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width - 50,
        height: 56,
        child: RaisedButton(
          onPressed: () => {},
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Pay: RM 2345.00",
            overflow: TextOverflow.visible,
            style: GoogleFonts.montserrat(
              color: Theme.of(context).textTheme.bodyText2.color,
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
                        color: Theme.of(context).textTheme.bodyText2.color,
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
                "Package - " +
                    tourism[int.parse(widget.countryIndex)]
                        .package[int.parse(widget.index)],
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).textTheme.caption.color),
              ),
            ),
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Color(0xffE9F4F9),
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Image.asset(
                              tourism[int.parse(widget.countryIndex)]
                                  .stateImage[int.parse(widget.index)],
                              width: 120,
                              height: 120,
                            ),
                          ),
                          Container(
                              height: 80,
                              child: VerticalDivider(color: Colors.black)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tourism[int.parse(widget.countryIndex)]
                                            .stateName[int.parse(widget.index)],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff5A6C64)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        tourism[int.parse(widget.countryIndex)]
                                            .countryName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
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
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        _itemCount != 1
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: 14,
                                                ),
                                                onPressed: () => setState(
                                                    () => _itemCount--),
                                              )
                                            : IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: 14,
                                                ),
                                                onPressed: () {}),
                                        Text(
                                          _itemCount.toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              size: 14,
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
                  color: Theme.of(context).textTheme.caption.color,
                ),
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
                                    tourism[int.parse(widget.countryIndex)]
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
                    color: Theme.of(context).textTheme.caption.color),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 230.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Column(
                    children: [
                      hotellist(
                        tourism[int.parse(widget.countryIndex)].hotelImage[0],
                        tourism[int.parse(widget.countryIndex)].hotelName[0],
                        tourism[int.parse(widget.countryIndex)].hotelRoom[0],
                        tourism[int.parse(widget.countryIndex)].hotelStar[0],
                      ),
                      hotellist(
                        tourism[int.parse(widget.countryIndex)].hotelImage[1],
                        tourism[int.parse(widget.countryIndex)].hotelName[1],
                        tourism[int.parse(widget.countryIndex)].hotelRoom[1],
                        tourism[int.parse(widget.countryIndex)].hotelStar[1],
                      ),
                      hotellist(
                        tourism[int.parse(widget.countryIndex)].hotelImage[2],
                        tourism[int.parse(widget.countryIndex)].hotelName[2],
                        tourism[int.parse(widget.countryIndex)].hotelRoom[2],
                        tourism[int.parse(widget.countryIndex)].hotelStar[2],
                      ),
                    ],
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
        Icon(Icons.star, size: 14, color: Color(0xff5A6C64)),
      );
    }
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlue.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Container(
        padding: EdgeInsets.only(left: 5, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Image.asset(
                      img,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width - 250,
                      height: MediaQuery.of(context).size.height - 650,
                    ),
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  Container(
                      height: 80, child: VerticalDivider(color: Colors.black)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(right: 5),
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
                                      size: 14,
                                    ),
                                    onPressed: () =>
                                        setState(() => _itemCount--),
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 14,
                                    ),
                                    onPressed: () {}),
                            Text(
                              _itemCount.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 14,
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
          ],
        ),
      ),
    );
  }
}
