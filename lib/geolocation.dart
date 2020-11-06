import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class DetailMap extends StatefulWidget {
  final tosave;
  DetailMap({Key key, @required this.tosave});
  // This widget is the root of your application.
  @override
  _DetailMapState createState() => _DetailMapState();
}

class _DetailMapState extends State<DetailMap> {
  Future<LocationData> _getUserLocation;
  LatLng _markerLocation;
  LatLng _userLocation;
  String _resultAddress;
  @override
  void initState() {
    super.initState();
    _getUserLocation = getUserLocation();
  }

  Future<LocationData> getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final result = await location.getLocation();
    _userLocation = LatLng(result.latitude, result.longitude);
    return result;
  }

  getSetAddress(Coordinates coordinates) async {
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _resultAddress = addresses.first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder<LocationData>(
                  future: _getUserLocation,
                  builder: (context, snapshot) {
                    switch (snapshot.hasData) {
                      case true:
                        return MyMap(
                          markerLocation: _markerLocation,
                          userLocation: _userLocation,
                          onTap: (location) {
                            setState(() {
                              _markerLocation = location;
                            });
                          },
                        );
                      default:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                  child: Icon(
                    Icons.add_location,
                    color: Colors.red,
                    size: 30,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  onPressed: () {
                    // var route = new MaterialPageRoute(
                    //     builder: (BuildContext context) => new FormTravel(
                    //           alamatTujuan: _resultAddress,
                    //         ));
                    Navigator.pop(context, _resultAddress);
                  }),
              Text("Add Location"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _resultAddress ?? "Address will be shown here",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("Get My Location Address"),
                  onPressed: () async {
                    if (_userLocation != null) {
                      getSetAddress(Coordinates(
                          _userLocation.latitude, _userLocation.longitude));
                    }
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("Get Marker Address"),
                  onPressed: () async {
                    if (_markerLocation != null) {
                      getSetAddress(Coordinates(
                          _markerLocation.latitude, _markerLocation.longitude));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  final markerLocation, userLocation, onTap;

  const MyMap({Key key, this.markerLocation, this.userLocation, this.onTap})
      : super(key: key);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.userLocation ?? LatLng(-6.930747, 110.792709),
      ),
      myLocationEnabled: true,
      markers: widget.markerLocation != null
          ? [
              Marker(
                  markerId: MarkerId("Tap Location"),
                  position: widget.markerLocation),
            ].toSet()
          : null,
      onTap: widget.onTap,
    );
  }
}
