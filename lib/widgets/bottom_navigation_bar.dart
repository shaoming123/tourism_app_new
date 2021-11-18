import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourismapp/Screens/profile_page.dart';
import 'package:tourismapp/Screens/home.dart';

class BottomNavigationBarTravel extends StatefulWidget {
  const BottomNavigationBarTravel({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarTravelState createState() =>
      _BottomNavigationBarTravelState();
}

class _BottomNavigationBarTravelState extends State<BottomNavigationBarTravel> {
  int _selectedIndex = 0;

  void _onItemTapped(int currentIndex) {
    setState(() {
      _selectedIndex = currentIndex;
    });
  }

  var bottomNavStyle =
      GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w500);
  final List _children = [
    Home(),
    Home(),
    Home(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? SvgPicture.asset('Assets/svg/icon_home_colored.svg')
                : SvgPicture.asset('Assets/svg/icon_home.svg'),
            label: 'Home'),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1
              ? SvgPicture.asset('Assets/svg/icon_heart_colored.svg')
              : SvgPicture.asset('Assets/svg/icon_heart.svg'),
          label: 'Heart',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2
              ? SvgPicture.asset('Assets/svg/icon_notification_colored.svg')
              : SvgPicture.asset('Assets/svg/icon_notification.svg'),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 3
              ? SvgPicture.asset('Assets/svg/icon_user_colored.svg')
              : SvgPicture.asset('Assets/svg/icon_user.svg'),
          label: 'User',
        )
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    );
  }
}
