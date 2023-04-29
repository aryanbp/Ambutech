
// @dart=2.9
import 'package:ambulance_tracker/Animation/FadeAnimation.dart';
import 'package:ambulance_tracker/screens/choice_page.dart';
import 'package:ambulance_tracker/screens/patient_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final TextEditingController email=TextEditingController();
  final TextEditingController pass=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),

                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    //border: Border(bottom: BorderSide(color: Colors.grey[400]))!
                                  ),
                                  child: TextField(
                                    controller: email,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: pass,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    try{
                                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: pass.text);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ChoicePage(email.text)));
                                    }on FirebaseAuthException catch(e){
                                      Fluttertoast.showToast(
                                          msg:e.message,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          )),
                      const SizedBox(
                        height: 70,
                      ),
                      FadeAnimation(
                          1.5,
                          const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}