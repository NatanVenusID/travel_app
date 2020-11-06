import 'package:aplikasi_wisata/carousel.dart';
import 'package:aplikasi_wisata/homepage.dart';
import 'package:aplikasi_wisata/share/sharedashboard.dart';

import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  TabBar myTabBar = TabBar(
    indicator: BoxDecoration(
        color: Colors.black,
        border: Border(
            top: BorderSide(
          color: Colors.amber,
          width: 5,
        ))),
    tabs: <Widget>[
      Tab(
        icon: Icon(Icons.home, color: Colors.amber),
        text: "Home",
      ),
      Tab(
        icon: Icon(Icons.share, color: Colors.amber),
        text: "Sharing",
      ),
      Tab(
        icon: Icon(
          Icons.location_on,
          color: Colors.amber,
        ),
        text: "Location",
      ),
      Tab(
        icon: Icon(Icons.account_circle, color: Colors.amber),
        text: "Account",
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Color(0xFFE9E7DA),
              resizeToAvoidBottomPadding: false,
              appBar: new AppBar(
                title: Center(
                  child: new Text(
                    "Venus Travel Addicted",
                    style: new TextStyle(color: Colors.amber),
                  ),
                ),
                backgroundColor: Colors.black,
                bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(myTabBar.preferredSize.height),
                    child:
                        Container(color: Colors.blueAccent, child: myTabBar)),
              ),
              body: TabBarView(
                children: <Widget>[
                  Center(child: CarouselDemo()),
                  Center(child: ShareDashboard()),
                  Center(child: MyApp()),
                  Center(child: Text("coming soon")),
                ],
              ),
            )));
  }
}
