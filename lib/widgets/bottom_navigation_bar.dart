//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourismapp/Screens/favorite.dart';
import 'package:tourismapp/Screens/home.dart';
import 'package:tourismapp/Screens/profile_page.dart';
import 'package:tourismapp/Screens/sign_in.dart';

int selectedItem = 0;

class BottomNavigationBarTravel extends StatefulWidget {
  const BottomNavigationBarTravel({Key key}) : super(key: key);
  @override
  _BottomNavigationBarTravelState createState() =>
      _BottomNavigationBarTravelState();
}

class _BottomNavigationBarTravelState extends State<BottomNavigationBarTravel> {
  User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // List children = [
  //   Home(),
  //   Favorite(),
  //   Home(),
  //   Profile(),
  // ];
  @override
  void initState() {
    _user = _auth.currentUser;
    super.initState();
  }

  void _onItemTapped(int currentIndex) {
    setState(() {
      selectedItem = currentIndex;
      switch (selectedItem) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          Navigator.pushNamed(context, '/favorite');
          break;
        case 2:
          Navigator.pushNamed(context, '/order');
          break;
        default:
          Navigator.pushNamed(context, '/profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      currentIndex: selectedItem,
      elevation: 0,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: selectedItem == 0
                ? Icon(
                    Icons.home,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  )
                : Icon(
                    Icons.home,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
            label: 'Home'),
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: selectedItem == 1
                ? Icon(
                    Icons.favorite,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  )
                : Icon(
                    Icons.favorite,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
            label: 'Home'),
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: selectedItem == 2
                ? Icon(
                    Icons.history,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  )
                : Icon(
                    Icons.history,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
            label: 'Home'),
        BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: selectedItem == 3
                ? Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  )
                : Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 29,
                  ),
            label: 'Home'),
      ],
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
