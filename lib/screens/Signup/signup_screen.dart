// @dart=2.9
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_tracker/constants.dart';
import 'package:ambulance_tracker/screens/Login/login_screen.dart';
import 'package:ambulance_tracker/Components/already_have_an_account_acheck.dart';
import 'package:ambulance_tracker/Components/rounded_button.dart';
import 'package:ambulance_tracker/Components/rounded_input_field.dart';
import 'package:ambulance_tracker/Components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../choice_page.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
class Body extends StatelessWidget {
  Body({Key key}) : super(key: key);
  final TextEditingController email=TextEditingController();
  final TextEditingController pass=TextEditingController();
  final TextEditingController name=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: size.height * 0.03),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/hands.png",
                width: size.width * 0.7,
              ),
            ),RoundedInputField(
              hintText: "Your Name",
              onChanged: (value) {
                name.text=value;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email.text=value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                pass.text=value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                try{
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email.text, password: pass.text);
                  CollectionReference useref=FirebaseFirestore.instance.collection("users");
                  DocumentReference newuseref=useref.doc();
                  print(newuseref.id);
                  Map<String,dynamic> newUser={
                    'name':name.text,
                    'email':email.text,
                    'hospital':false,
                    'id':newuseref.id,
                    'location':'',
                  };
                  await newuseref.set(newUser);
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ChoicePage(email.text)));
                } on FirebaseAuthException catch(e){
                Fluttertoast.showToast(
                msg:e.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white,
                fontSize: 16.0);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}



class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}


