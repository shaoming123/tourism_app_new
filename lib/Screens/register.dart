//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourismapp/Screens/sign_in.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

final auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _RegisterState extends State<Register> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController email;
  TextEditingController password;
  TextEditingController username;
  TextEditingController phone;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    username = TextEditingController();
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          // Container(
          //   decoration: const BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage('Assets/image1.png'),
          //           fit: BoxFit.fitWidth,
          //           alignment: Alignment.topCenter)),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            // margin: EdgeInsets.only(top: 270),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(23),
                  child: ListView(
                    children: <Widget>[
                      const Text("SIGN Up",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Container(
                          color: Color(0xfff5f5f5),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'SFUIDisplay'),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email Address',
                                prefixIcon: Icon(Icons.person_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                            controller: email,
                            validator: (val) => val.isNotEmpty
                                ? null
                                : "Please enter a email address",
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'SFUIDisplay'),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.lock_outline),
                              labelStyle: TextStyle(fontSize: 15)),
                          controller: username,
                          validator: (val) =>
                              val.isNotEmpty ? null : "Please enter a username",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Container(
                          color: Color(0xfff5f5f5),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'SFUIDisplay'),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone number',
                                prefixIcon: Icon(Icons.lock_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                            controller: phone,
                            validator: (val) => val.isNotEmpty
                                ? null
                                : "Please enter your phone number",
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          obscureText: true,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'SFUIDisplay'),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              labelStyle: TextStyle(fontSize: 15)),
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value.length < 8) {
                              return 'Password should be at least 8 characters';
                            }

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              addUser();
                            }
                          }, //since this is only a UI app
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color(0xffff2d55),
                          elevation: 0,
                          minWidth: 400,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: Column(
                            children: [
                              RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                      text: "Do have an account?",
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                ]),
                              ),
                              FlatButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: RichText(
                                      text: const TextSpan(children: [
                                    TextSpan(
                                        text: "sign in",
                                        style: TextStyle(
                                          fontFamily: 'SFUIDisplay',
                                          color: Color(0xffff2d55),
                                          fontSize: 15,
                                        ))
                                  ])),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignIn()));
                                  })
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addUser() async {
    try {
      final User user = (await auth.createUserWithEmailAndPassword(
              email: email.text, password: password.text))
          .user;
      if (user != null) {
        firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          'username': username.text,
          'email': email.text,
          'phone': phone.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignIn()));
      } else {
        _scaffoldKey.currentState.showSnackBar(
          const SnackBar(
            content: Text("Account has been created already"),
          ),
        );
      }
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          content:
              Text("The email address is already in use by another account"),
        ),
      );
    }
  }
}
