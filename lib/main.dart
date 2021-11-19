import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourismapp/Screens/profile_page.dart';
import 'package:tourismapp/store/theme_management.dart';
import 'package:tourismapp/widgets/bottom_navigation_bar.dart';

import 'Screens/favorite.dart';
import 'Screens/home.dart';
import 'Screens/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((event) => updateUserState(event));

    super.initState();
  }

  updateUserState(event) {
    setState(() {
      user = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(builder: (context, theme, child) {
        return MaterialApp(
          home: user != null ? const Home() : const SignIn(),
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          routes: {
            '/home': (context) => const Home(),
            '/favorite': (context) => const Favorite(),
            '/profile': (context) => const Profile(),
          },
        );
      }),
    );
  }
}
