import 'package:flutter/material.dart';

class PageDetail extends StatelessWidget {
  String placename, description, map;
  PageDetail(
      {this.placename,
      this.description,
      this.map
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Travel'),
        ),
      body: Container( padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nama Lokasi   : $placename',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Deskripsi Lokasi     : $description',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Peta Lokasi     : $map',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
