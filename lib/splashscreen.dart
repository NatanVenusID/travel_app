import 'package:aplikasi_wisata/menupage.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: 
      Container(
        padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250 ,
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/venustravel.png"))),
              ),
              SizedBox(height: 20,),
              Text("Travel Is Healthiest Addiction", style: TextStyle(fontSize: 20, color: Colors.white),),
              Container(
                width: 250,
                height: 40,
                color: Colors.amber,
                margin: EdgeInsets.only(top: 100, bottom: 19),
                child: RaisedButton(
                  child: Text(
                    "Addiction Now!!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MenuPage()));
                  },
                ),
              ),
             
            ],
          )),
    );
  }
}
