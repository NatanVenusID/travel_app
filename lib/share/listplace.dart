import 'package:aplikasi_wisata/share/detailpage.dart';
import 'package:aplikasi_wisata/share/model.dart';
import 'package:aplikasi_wisata/share/shareplace.dart';
import 'package:flutter/material.dart';
import 'dbhelper.dart';

class ListTravel extends StatefulWidget {
  final ModelTravel modelTravel;
  String alamatTujuan;
  ListTravel({this.modelTravel, this.alamatTujuan});

  @override
  _ListTravelState createState() => _ListTravelState();
}

class _ListTravelState extends State<ListTravel> {
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
    return ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.only(left: 16),
            title: Text(
              '${items[index].namalokasi} ${items[index].deskripsilokasi} ${items[index].petalokasi}',
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepOrangeAccent),
            ),
            subtitle: Text(
              '${items[index].deskripsilokasi}',
            ),
            onTap: () {
              _navigateToTravel(context, items[index]);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                AlertDialog hapus = AlertDialog(
                  backgroundColor: Colors.amber,
                  title: Text('Information'),
                  content: Container(
                    color: Colors.amber,
                    height: 100.0,
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Apakah anda yakin ingin hapus data ${items[index].namalokasi}')
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Yes!',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _deleteTravel(context, items[index], index);

                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'No!',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                    ),
                  ],
                );
                showDialog(context: context, child: hapus);
              },
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageDetail(
                              placename: items[index].namalokasi,
                              description: items[index].deskripsilokasi,
                              map: items[index].petalokasi,
                              
                            )));
              },
              icon: Icon(Icons.visibility),
            ),
          );
        });
  }

  _deleteTravel(BuildContext context, ModelTravel travel, int position) {
    db.deleteTravel(travel.id).then((travels) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToTravel(BuildContext context, ModelTravel travel) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormTravel(
                  modelTravel: travel,
                )));
    if (result == 'update') {
      db.getAllTravel().then((travels) {
        setState(() {
          items.clear();
          travels.forEach((travel) {
            items.add(ModelTravel.fromMap(travel));
          });
        });
      });
    }

   
    void _createNewTravel(BuildContext context) async {
      String result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FormTravel(modelTravel: ModelTravel("","","",""))));
      if (result == 'save') {
        db.getAllTravel().then((travels) {
          setState(() {
            items.clear();
            travels.forEach((travel) {
              items.add(ModelTravel.fromMap(travel));
            });
          });
        });
      }
    }
  }
}
