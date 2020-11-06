import 'package:aplikasi_wisata/share/model.dart';
import 'package:aplikasi_wisata/share/shareplace.dart';
import 'package:flutter/material.dart';
import 'dbhelper.dart';

class ShareDashboard extends StatefulWidget {
  @override
  _ShareDashboardState createState() => _ShareDashboardState();
}

class _ShareDashboardState extends State<ShareDashboard> {
  List<ModelTravel> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.getAllTravel().then((travels) {
      setState(() {
        travels.forEach((travel) {
          items.add(ModelTravel.fromMap(travel));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/venustravel.png"))),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Sharing is a wonderful thing!!",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Container(
                width: 250,
                height: 58,
                margin: EdgeInsets.only(top: 50, bottom: 19),
                child: FloatingActionButton(
                    child: Icon(
                      Icons.share,
                      color: Colors.amber,
                      size: 40,
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) =>FormTravel()));}
                   
              )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Share Now",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          )),
    );
  }
}

//   void _createNewTravel(BuildContext context) async {
//     String result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => FormTravel(ModelTravel('', '', ''))));
//     if (result == 'save') {
//       db.getAllTravel().then((travels) {
//         setState(() {
//           items.clear();
//           travels.forEach((travel) {
//             items.add(ModelTravel.fromMap(travel));
//           });
//         });
//       });
//     }
//   }
// }
