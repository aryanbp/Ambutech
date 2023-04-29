// import 'dart:html';

import 'package:ambulance_tracker/services/MapUtils.dart';
import 'package:ambulance_tracker/services/current_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PatientPage extends StatefulWidget {
  final String email;
  const PatientPage(this.email, {Key? key}) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState(email);
}

String currLoc = "";
var details = [];
String date_time = "", address = "";
var loc = [];

class _PatientPageState extends State<PatientPage> {
  final String email;
  _PatientPageState(this.email);

  @override
  void initState() {
    super.initState();
    currentLoc();
  }

  @override
  Widget build(BuildContext context) {
    currentLoc();


    try {
      loc[0];
    } catch (e) {
      currentLoc();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
        ),
        backgroundColor: const Color.fromRGBO(222, 224, 252, 1),
        body: Center(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
              ElevatedButton(
                  child: const Text("Refresh location"),
                  onPressed: () async {
                    currentLoc();

                    date_time = currLoc.split("{}")[0];
                    address = currLoc.split("{}")[2];
                    loc = currLoc.split("{}")[1].split(" , ");

                    setState(() {
                      currLoc;
                      date_time;
                      address;
                      loc;
                    });
                  }),
              Card(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Date: " + date_time),
                    Text("Address: " + address),
                    //Text("Location: " + loc[0] + ", " + loc[1]),
                  ],
                ),
              ),
              ElevatedButton(
                  child: const Text("See nearby hospitals"),
                  onPressed: () async {
                    MapUtils.openMap(
                        double.parse(loc[0]), double.parse(loc[1]));
                  }),
              ElevatedButton(
                  child: const Text("See nearby ambulance"),
                      onPressed: () async {
                    print(loc.toString());
                        MapUtils.openMap2(
                            double.parse(loc[0]), double.parse(loc[1]));
                      }),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: getHosps(email),
                  ),
                ),
              )
            ])));
  }

  void currentLoc() async {
    currLoc = await getLoc();
    date_time = currLoc.split("{}")[0];
    address = currLoc.split("{}")[2];
    loc = currLoc.split("{}")[1].split(" , ");
  }

  List<Widget> getHosps(email) {
    List<Widget> lst = [];
    for (int i = 1; i <= 4; i++) {
      lst.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 7,
            child: Card(
              child: Column(children: [
                Text(
                  "Hospital " + i.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text("Hospital Location"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          print("Name....");

                          QuerySnapshot querysnap=await FirebaseFirestore.instance.collection('users').where("email",isEqualTo: email).get();
                          DocumentSnapshot docsnap=querysnap.docs.first;
                          Map jsonData = docsnap.data() as Map<String, dynamic>;
                          debugPrint(jsonData["name"]);
                          await FirebaseFirestore.instance.collection('users').doc(jsonData["id"]).update(
                              {
                                'hospital':true,
                                'location':'https://www.google.com/maps/search/${loc[0]},${loc[1]}',
                              });
                          Fluttertoast.showToast(
                              msg:
                                  "Hospital chosen, you'll be notified about the ambulance",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }),
                    IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () async {

                          QuerySnapshot querysnap=await FirebaseFirestore.instance.collection('users').where("email",isEqualTo: email).get();
                          DocumentSnapshot docsnap=querysnap.docs.first;
                          Map jsonData = docsnap.data() as Map<String, dynamic>;
                          debugPrint(jsonData["name"]);
                          await FirebaseFirestore.instance.collection('users').doc(jsonData["id"]).update(
                              {
                                'hospital':false,
                                'location':'',
                              });
                          Fluttertoast.showToast(
                              msg:
                              "Hospital rejected",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }),
                    const Icon(Icons.location_on)
                  ],
                )
              ]),
            )),
      ));
    }

    return lst;
  }
}
