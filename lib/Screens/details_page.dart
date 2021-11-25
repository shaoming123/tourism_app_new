//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:tourismapp/Screens/selected_details.dart';
import 'package:tourismapp/models/tourism_model.dart';

class DetailPage extends StatefulWidget {
  final country, img, index;
  final TourismModel tourismModel;
  const DetailPage(
      {Key key, this.country, this.img, this.tourismModel, this.index});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  listItem(String img, String place, String priceStart, String priceEnd,
      String index) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SelectedDetails(countryIndex: widget.index, index: index),
            ),
          );
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken)),
                ),
              ),
              Positioned(
                top: 120.0,
                left: 15.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      place,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          textStyle: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "RM " + priceStart + " - " + priceEnd,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          textStyle: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    widget.country.toString().toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100.0,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 10.0,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                ' Trending Attractions',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectedDetails(
                                  countryIndex: widget.index,
                                  index: (0).toString()),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Container(
                                  height: 220.0,
                                  width: 330.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          tourism[int.parse(widget.index)]
                                              .stateImage[0]),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.6),
                                          BlendMode.darken),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 150.0,
                                left: 30.0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 60.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            tourism[int.parse(widget.index)]
                                                .stateName[0],
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                )),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            tourism[int.parse(widget.index)]
                                                .package[0],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 18.0,
                                                textStyle: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          ' Weekly Highlights',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            textStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: 3,
                          padding: EdgeInsets.only(right: 15.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) =>
                              listItem(
                                  tourism[int.parse(widget.index)]
                                      .stateImage[index + 1],
                                  tourism[int.parse(widget.index)]
                                      .stateName[index + 1],
                                  tourism[int.parse(widget.index)]
                                      .priceStart[index + 1],
                                  tourism[int.parse(widget.index)]
                                      .priceEnd[index + 1],
                                  (index + 1).toString()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
