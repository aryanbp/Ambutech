import 'package:ambulance_tracker/services/current_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/MapUtils.dart';


class DriverPage extends StatefulWidget {
  final String email;
  const DriverPage( this.email, {Key? key}) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState(email);
}

var loc = [];
String currLoc = "";
String address = "";
bool isWorking = false;
bool isAvailable = true;
String name="";
String location="";

class _DriverPageState extends State<DriverPage> {
  final String email;
  _DriverPageState( this.email);

  @override
  void initState() {
    super.initState();
    currentLoc();
  }

  @override
  Widget build(BuildContext context) {
    currentLoc();

    return Scaffold(
      appBar: AppBar(
          title: Text("Driver page"),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 8,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Image.network(
                                "https://static.wikia.nocookie.net/pokemon/images/8/88/Char-Eevee.png/revision/latest?cb=20190625223735"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Name: Chakit Dalmia"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Available: ",
                    style: TextStyle(fontSize: 20),
                  ),

                ],
              ),

            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Working: ",
                  style: TextStyle(fontSize: 28),
                ),

              ],
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 20,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              child: !isWorking
                  ? patientData()
                  : Card(
                child: Image.network(
                    "https://img.freepik.com/free-vector/lazy-raccoon-sleeping-cartoon_125446-631.jpg?size=338&ext=jpg"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget patientData() {
    return GestureDetector(
      onTap: () async {
        QuerySnapshot querysnap=await FirebaseFirestore.instance.collection('users').where("email",isEqualTo: email).get();
        DocumentSnapshot docsnap=querysnap.docs.first;
        Map jsonData = docsnap.data() as Map<String, dynamic>;
        name=jsonData["name"];
        location=jsonData["location"];

        //address = currLoc.split("{}")[2];
        //loc = currLoc.split("{}")[1].split(" , ");
        address = "Patient's address";
        loc = [0, 0];

        setState(() {
          loc;
          address;
        });
      },
      child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "$name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.network("https://www.zyrgon.com/wp-content/uploads/2019/06/googlemaps-Zyrgon.jpg"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(address),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(onPressed: (){
                  setState(() {
                    currentLoc();
                  });
                  MapUtils.openMap1(
                      location);
                }, child:Text("Location: $location") ),
              ),
            ],
          )),
    );
  }

  void currentLoc() async {
    currLoc = await getLoc();
  }
}
