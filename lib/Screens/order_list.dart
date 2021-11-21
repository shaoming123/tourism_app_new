import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourismapp/widgets/bottom_navigation_bar.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: const BottomNavigationBarTravel(),
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
                      'ORDER LIST',
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100.0,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) => listItem(
                        'Assets/images/japan.jpg',
                        'Malaysia,',
                        'Kuala Lumpur',
                        'Japan,',
                        'Tokyo'),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  listItem(String img, String orginCountry, String originState,
      String destinationCountry, String destinationState) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Container(
          child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 55,
                  height: 160,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Color(0xffE9F4F9),
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 55,
                            ),
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Color(0xffD5E6F2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(
                                  Icons.airplanemode_active,
                                  size: 25,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Airplane",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff5A6C64)),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orginCountry,
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
                                  originState,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
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
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5A6C64)),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  size: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  destinationCountry,
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
                                  destinationState,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Date: ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff5A6C64)),
                                  ),
                                  Text(
                                    "18.1.2022 - 21.1.2022",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff5A6C64)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Seat No. ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff5A6C64)),
                                  ),
                                  Text(
                                    "L2230",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff5A6C64)),
                                  ),
                                ],
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
        ],
      )),
    );
  }
}
