import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourismapp/widgets/bottom_navigation_bar.dart';

import 'details_page.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  listItem(String img, String country, String message) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
      child: Container(
          child: Stack(
        children: <Widget>[
          Container(
            height: 100.0,
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
            height: 100.0,
            child: Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25.0, right: 130, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ),
                  ),
                  IconButton(
                    key: Key('icon'),
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: () {
                      // !favoritesList.items.contains(itemNo)
                      //     ? favoritesList.add(itemNo)
                      //     : favoritesList.remove(itemNo);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(favoritesList.items.contains(itemNo)
                      //         ? 'Added to favorites.'
                      //         : 'Removed from favorites.'),
                      //     duration: const Duration(seconds: 1),
                      //   ),
                      // );
                    },
                  ),
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
                    'FAVORITE',
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
            height: MediaQuery.of(context).size.height - 150.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) =>
                      listItem('Assets/images/japan.jpg', 'Tokyo', 'Japan'),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
