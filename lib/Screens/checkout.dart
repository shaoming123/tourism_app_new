//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourismapp/Screens/failure.dart';
import 'package:tourismapp/Screens/successful.dart';
import 'package:tourismapp/models/tourism_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Checkout extends StatefulWidget {
  final countryIndex, index;

  Checkout({Key key, this.countryIndex, this.index}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User _user;
  Razorpay _razorpay;
  int amount;
  int initalPrice;
  String package = "";
  String date = "";
  String hotel = "";
  String country = "";
  String destination = "";
  String transport = "airplane";
  String user_id = "";
  String package_id = "";

  //hotel quantity
  int _itemCount = 1;
  int _hotel_3 = 1;
  int _hotel_4 = 0;
  int _hotel_5 = 0;
  int _hotelTotal;

  //hotel price
  int hotel3_price;
  int hotel4_price;
  int hotel5_price;

  int hotel_type;

  int package_price;

  //User data
  String _username;
  String _phone;
  String _email;

  @override
  void initState() {
    _user = _auth.currentUser;
    _razorpay = Razorpay();

    firestore.collection("users").doc(_user.uid).get().then((value) {
      setState(() {
        _username = value.data()['username'];
        _phone = value.data()['phone'];
        _email = value.data()['email'];
      });
    });

    _hotelTotal = _hotel_3 + _hotel_4 + _hotel_5;
    amount = (int.parse(tourism[int.parse(widget.countryIndex)]
            .priceStart[int.parse(widget.index)])) +
        (int.parse(tourism[int.parse(widget.countryIndex)].hotelPrice[0]));
    initalPrice = int.parse(tourism[int.parse(widget.countryIndex)]
        .priceStart[int.parse(widget.index)]);
    package_price = int.parse(tourism[int.parse(widget.countryIndex)]
        .priceStart[int.parse(widget.index)]);

    //hotel price
    hotel3_price =
        int.parse(tourism[int.parse(widget.countryIndex)].hotelPrice[0]);
    hotel4_price =
        int.parse(tourism[int.parse(widget.countryIndex)].hotelPrice[1]);
    hotel5_price =
        int.parse(tourism[int.parse(widget.countryIndex)].hotelPrice[2]);

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void totalAmount() {
    setState(() {
      package_price = (initalPrice * _itemCount);

      amount = (initalPrice * _itemCount) +
          (hotel3_price * _hotel_3) +
          (hotel4_price * _hotel_4) +
          (hotel5_price * _hotel_5);
    });
  }

  void openCheckout(totalAmount) {
    var options = {
      'key': 'rzp_test_HrKYY6mdiMRJLt',
      'amount': (double.parse(totalAmount.toString()) * 100.roundToDouble())
          .toString(),
      'name': _username,
      'description': 'Buy Tourism Package',
      'prefill': {'contact': _phone, 'email': _email},
      'external': {
        'wallets': ['']
      },
      'currency': 'MYR'
    };

    try {
      _razorpay.open(options);
      // totala(total);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  // void totala(total) {
  //   double test = (double.parse(_controller.text));
  //   double word = double.parse(total);
  //   total = word + test;
  //   print(total);
  // }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    addToDb();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SuccessfulPage()),
      (Route<dynamic> route) => false,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // ignore: deprecated_member_use
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => FailurePage()),
      (Route<dynamic> route) => false,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("EXTERNAL_WALLET: " + response.walletName)));
  }

  void addToDb() {
    String transaction_id =
        _user.uid + DateTime.now().millisecondsSinceEpoch.toString();

    try {
      firestore.collection("transaction").doc(transaction_id).set({
        "transaction_id": transaction_id,
        "uid": _user.uid,
        'country': tourism[int.parse(widget.countryIndex)].countryName,
        'destination': tourism[int.parse(widget.countryIndex)]
            .stateName[int.parse(widget.index)],
        'total_amount': amount.toString(),
        'package_date': tourism[int.parse(widget.countryIndex)]
            .package[int.parse(widget.index)],
        'date': tourism[int.parse(widget.countryIndex)]
            .date[int.parse(widget.index)],
        'package_quantity': _itemCount,
        'transport': transport,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          content: Text(""),
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
      floatingActionButton: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width - 50,
        height: 56,
        child: RaisedButton(
          onPressed: () => {
            _hotelTotal != _itemCount
                ? _scaffoldKey.currentState.showSnackBar(
                    const SnackBar(
                      content: Text("Please select your hotel !"),
                    ),
                  )
                : openCheckout(amount.toString())
          },
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Pay: RM " + amount.toString(),
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
              // height: MediaQuery.of(context).size.height * 10,
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
                  SizedBox(height: 100),
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
                                        "RM " + package_price.toString(),
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
                                                onPressed: () {
                                                  setState(() {
                                                    _itemCount--;
                                                    _hotelTotal = _hotel_3 +
                                                        _hotel_4 +
                                                        _hotel_5;
                                                  });

                                                  totalAmount();
                                                },
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
                                          onPressed: () {
                                            setState(() {
                                              _itemCount++;
                                              _hotelTotal = _hotel_3 +
                                                  _hotel_4 +
                                                  _hotel_5;
                                            });
                                            totalAmount();
                                          },
                                        )
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
              height: MediaQuery.of(context).size.height - 100.0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: Column(
                    children: [
                      hotellist(
                        tourism[int.parse(widget.countryIndex)].hotelImage[0],
                        tourism[int.parse(widget.countryIndex)].hotelName[0],
                        tourism[int.parse(widget.countryIndex)].hotelRoom[0],
                        tourism[int.parse(widget.countryIndex)].hotelStar[0],
                        tourism[int.parse(widget.countryIndex)].hotelPrice[0],
                        hotel_type = 3,
                      ),
                      hotellist(
                        tourism[int.parse(widget.countryIndex)].hotelImage[1],
                        tourism[int.parse(widget.countryIndex)].hotelName[1],
                        tourism[int.parse(widget.countryIndex)].hotelRoom[1],
                        tourism[int.parse(widget.countryIndex)].hotelStar[1],
                        tourism[int.parse(widget.countryIndex)].hotelPrice[1],
                        hotel_type = 4,
                      ),
                      hotellist(
                        tourism[int.parse(widget.countryIndex)].hotelImage[2],
                        tourism[int.parse(widget.countryIndex)].hotelName[2],
                        tourism[int.parse(widget.countryIndex)].hotelRoom[2],
                        tourism[int.parse(widget.countryIndex)].hotelStar[2],
                        tourism[int.parse(widget.countryIndex)].hotelPrice[1],
                        hotel_type = 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]))),
    );
  }

  hotellist(String img, String place, String room, String star, String price,
      int hotel_type) {
    final children = <Widget>[];
    for (var i = 0; i < int.parse(star); i++) {
      children.add(
        Icon(Icons.star, size: 14, color: Color(0xff5A6C64)),
      );
    }
    return Container(
      height: 130,
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
        padding: EdgeInsets.only(left: 5, top: 18),
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
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.13,
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
                            _itemCount > 0 &&
                                    (_hotel_3 >= 0 &&
                                        _hotel_4 >= 0 &&
                                        _hotel_5 >= 0)
                                ? IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 14,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (hotel_type == 3) {
                                          _hotel_3--;
                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        } else if (hotel_type == 4) {
                                          _hotel_4--;
                                          if (_hotel_4 == 0) {
                                            _hotel_4 = 0;
                                          }
                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        } else if (hotel_type == 5) {
                                          _hotel_5--;
                                          if (_hotel_5 == 0) {
                                            _hotel_5 = 0;
                                          }
                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        }

                                        if (_hotel_3.isNegative) {
                                          _hotel_3 = 0;

                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        } else if (_hotel_4.isNegative) {
                                          _hotel_4 = 0;

                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        } else if (_hotel_5.isNegative) {
                                          _hotel_5 = 0;

                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        }
                                      });
                                      totalAmount();
                                    })
                                : IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 14,
                                    ),
                                    onPressed: () {}),
                            if (hotel_type == 3) ...[
                              Text(
                                _hotel_3.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ] else if (hotel_type == 4) ...[
                              Text(
                                _hotel_4.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ] else if (hotel_type == 5) ...[
                              Text(
                                _hotel_5.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                            _hotelTotal < _itemCount
                                ? IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 14,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _hotelTotal =
                                            _hotel_3 + _hotel_4 + _hotel_5;
                                        if (hotel_type == 3) {
                                          _hotel_3++;
                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        } else if (hotel_type == 4) {
                                          _hotel_4++;
                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        } else if (hotel_type == 5) {
                                          _hotel_5++;
                                          _hotelTotal =
                                              _hotel_3 + _hotel_4 + _hotel_5;
                                        }
                                      });
                                      totalAmount();
                                    })
                                : IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 14,
                                    ),
                                    onPressed: () {
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Hotel Room Quantity is enough !")));
                                    }),
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
