// @dart=2.9

import 'package:ambulance_tracker/Animation/FadeAnimation.dart';
import 'package:ambulance_tracker/screens/patient_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'all_drivers.dart';
import 'driver_page.dart';
import 'hospital_page.dart';

class ChoicePage extends StatelessWidget {
  final String email;
  const ChoicePage(this.email, {Key key}) : super(key: key);
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
                        height: 300,
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
                        height: 250,
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
                        height: 250,
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
                                  "Role",
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
                  padding: const EdgeInsets.all(20.0),
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
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PatientPage(email)));
                                  },
                                  child: const Text(
                                    "User",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
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
                                    QuerySnapshot _myDoc =
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .get();
                                    List<DocumentSnapshot> _myDocCount =
                                        _myDoc.docs;
                                    List<Widget> lst = [];

                                    var it = _myDocCount.iterator;
                                    print("--->");
                                    while (it.moveNext()) {
                                      var dosnap = it.current.id;

                                      QuerySnapshot querysnap =
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .where("id", isEqualTo: dosnap)
                                              .get();
                                      DocumentSnapshot docsnap =
                                          querysnap.docs.first;
                                      Map jsonData = docsnap.data()
                                          as Map<String, dynamic>;
                                      debugPrint(jsonData["name"]);

                                      if (jsonData["hospital"].toString() ==
                                          'true') {
                                        lst.add(_buildRequestsCard(
                                          title: "Name: ${jsonData['name']}",
                                          subject: "Location",
                                          text: "${jsonData['location']}",
                                          image: Image.asset(
                                              'images/background.png'),
                                        ));
                                      }
                                      print(docsnap);
                                    }
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HospitalPage(email, lst)));
                                  },
                                  child: const Text(
                                    "Hospital Reception",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
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
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DriverPage(email)));
                                  },
                                  child: const Text(
                                    "Driver",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          )),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildItemCard(
      {String title,
      String total,
      int totalNum,
      Color color,
      IconData icon,
      GestureTapCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                children: [
                  WidgetSpan(
                      child: FaIcon(
                    icon,
                    color: color,
                    size: 40,
                  )),
                ],
              )),
              const SizedBox(height: 25),
              RichText(
                  text: TextSpan(
                      text: title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ))),
              const SizedBox(height: 20),
              const Divider(
                thickness: 1,
              ),
              RichText(
                  text: TextSpan(
                      text: total,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ))),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestsCard({
    String title,
    String subject,
    String text,
    Image image,
  }) {
    return TextButton(onPressed: (){
    }, child:Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: subject,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ),
    );
  }
}
