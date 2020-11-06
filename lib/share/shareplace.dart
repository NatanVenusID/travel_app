import 'package:aplikasi_wisata/geolocation.dart';
import 'package:aplikasi_wisata/homepage.dart';

import 'package:aplikasi_wisata/menupage.dart';
import 'package:aplikasi_wisata/share/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'dbhelper.dart';

class FormTravel extends StatefulWidget {
  final ModelTravel modelTravel;
  String alamatTujuan;
  FormTravel({this.alamatTujuan, this.modelTravel});

  @override
  _FormTravelState createState() => _FormTravelState();
}

class _FormTravelState extends State<FormTravel> {
  File _image;
  String _imagepath;
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _namaLokasiControler;
  TextEditingController _deskripsiLokasiControler;
  TextEditingController _petaLokasiControler;

  @override
  void initState() {
    super.initState();
    _namaLokasiControler =
        new TextEditingController(text: widget.modelTravel?.namalokasi ?? "");
    _deskripsiLokasiControler = new TextEditingController(
        text: widget.modelTravel?.deskripsilokasi ?? "");
    _petaLokasiControler =
        new TextEditingController(text: widget.modelTravel?.petalokasi ?? "");
    loadImage();
  }

  Future _getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future saveImage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", path);
  }

  Future loadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Travel'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _namaLokasiControler,
            decoration: InputDecoration(
                labelText: 'Nama Lokasi  ',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _deskripsiLokasiControler,
            maxLines: 5,
            decoration: InputDecoration(
                labelText: 'Deksripsi Lokasi',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _petaLokasiControler,
            maxLines: 2,
            decoration: InputDecoration(
                labelText: 'Peta Lokasi',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.map,
                  ),
                  iconSize: 30,
                  color: Colors.black,
                  onPressed: () async {
                    var resultAddress =
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailMap(
                                  tosave: context,
                                )));
                    if (resultAddress != null) {
                      _petaLokasiControler.text = resultAddress;
                    }
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(
            height: 5,
          ),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: <Widget>[
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  color: Colors.black12,
                  child: _image == null ? Icon(Icons.add) : Image.file(_image),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.black12,
                  child: Icon(Icons.add),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.black12,
                  child: Icon(Icons.add),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.black12,
                  child: Icon(Icons.add),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.black12,
                  child: Icon(Icons.add),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.black12,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          RaisedButton(
              color: Colors.black,
              child: (widget.modelTravel?.id != null)
                  ? Text(
                      'Update',
                      style: TextStyle(color: Colors.amber),
                    )
                  : Text(
                      'Add',
                      style: TextStyle(color: Colors.amber),
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                if (widget.modelTravel?.id != null) {
                  db
                      .updateTravel(ModelTravel.fromMap({
                    'id': widget.modelTravel.id,
                    'namalokasi': _namaLokasiControler.text,
                    'deskripsilokasi': _deskripsiLokasiControler.text,
                    'petalokasi': _petaLokasiControler.text,
                    'gambarlokasi': _image.path,
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .saveTravel(
                    ModelTravel(
                        _namaLokasiControler.text,
                        _deskripsiLokasiControler.text,
                        _petaLokasiControler.text,
                        _image.path),
                  )
                      .then((_) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuPage()));
                  });
                }
              })
        ],
      ),
    );
  }
}
