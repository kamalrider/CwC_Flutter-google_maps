import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:CWCFlutter/polygon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

Future<http.Response> _loadCoordinate() {
  return http.get(
      "https://nominatim.openstreetmap.org/search.php?q=seberang%20perai&polygon_geojson=1&format=jsonv2");
}

enum maptap { a, b }

enum malaysiaMap { malaysia, penang }

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;
  Color circleColor = Colors.red;
  Color _testColor = Color.fromRGBO(102, 51, 153, .5);
  List<LatLng> listPolygonPenang;
  List<LatLng> listTest;
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  malaysiaMap selectmap = malaysiaMap.malaysia;
  Map _result = new Map();

  @override
  void initState() {
    super.initState();
    listPolygonPenang = PolygonCountry.penang();
    listTest = PolygonCountry.seberangPerai();
    _setMarkerIcon();
    _setPolylines();
    _setCircles();
//    circleColor = Colors.red;
  }

  maptap settap = maptap.a;

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/noodle_icon.png');
  }

  void _toggleMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    if (_showMapStyle) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _position = CameraPosition(
    bearing: 0.0,
    target: LatLng(4.2105, 101.9758),
//    tilt: 59.440,
    zoom: 4.5,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position));
  }

  Color _polygonColor = Color.fromRGBO(102, 51, 153, .5);

  void _setPolylines() {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(37.74493, -122.42932));
    polylineLatLongs.add(LatLng(37.74693, -122.41942));
    polylineLatLongs.add(LatLng(37.74923, -122.41542));
    polylineLatLongs.add(LatLng(37.74923, -122.42582));

    _polylines.add(
      Polyline(
          polylineId: PolylineId("0"),
          points: polylineLatLongs,
//        color: Colors.purple,
          color: settap == maptap.a ? Colors.purple : Colors.yellow,
          width: 1,
          onTap: () {
            setState(() {
              settap = maptap.b;
              _setPolylines();
            });
          }),
    );
  }

  void _setCircles() {
    setState(() {
      if (settap == maptap.a) {
        _circles.add(
          Circle(
            circleId: CircleId("0"),
            center: LatLng(37.76493, -122.42432),
            radius: 1000,
            strokeWidth: 2,
//            onTap: () {
//              setState(() {
//                settap = maptap.b;
//              });
//            },
            fillColor: Colors.red,
          ),
        );
      } else if (settap == maptap.b) {
        _circles.add(
          Circle(
            circleId: CircleId("0"),
            center: LatLng(37.76493, -122.42432),
            radius: 1000,
            strokeWidth: 2,
//              onTap: () {
//                setState(() {
//                  settap = maptap.b;
//                });
//              },
            fillColor: Colors.yellow,
          ),
        );
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

//    setState(() {
//      _markers.add(
//        Marker(
//            markerId: MarkerId("0"),
//            position: LatLng(5.285153, 100.456238),
//            infoWindow: InfoWindow(
//              title: "San Francsico",
//              snippet: "An Interesting city",
//            ),
//            icon: _markerIcon),
//      );
//    });
  }

  void _changeColor(LatLng latLng) {
    setState(() {
      settap = maptap.b;
    });
  }

  List<LatLng> coordinate = null;
  String teststring = "test";
  var apijson;


  loadSeberangPerai() async {
    var jsonResponse = null;
    var response = await http.get(
        "https://nominatim.openstreetmap.org/search.php?q=seberang%20perai&polygon_geojson=1&format=jsonv2");
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      apijson = jsonResponse;

    }
  }

  Future<http.Response> _loadSP(){
      return http.get("https://nominatim.openstreetmap.org/search.php?q=seberang%20perai&polygon_geojson=1&format=jsonv2");

  }

  @override
  Widget build(BuildContext context) {
    String apitest;

    loadSeberangPerai();
    
    _loadSP().then((response) {
        var jsonResponse =json.decode(response.body);
        _result = jsonResponse;
    });

    print(_result);

    setState(() {
      if (settap == maptap.a)
        circleColor = Colors.red;
      else if (settap == maptap.b) circleColor = Colors.yellow;
    });

    Set<Polygon> _polygons = HashSet<Polygon>();
    Set<Polygon> _testpolygon = HashSet<Polygon>();

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: listPolygonPenang,
        fillColor: _polygonColor,
        strokeWidth: 1,
        consumeTapEvents: true,
        onTap: () {
          setState(() {
            _polygonColor = Color.fromRGBO(102, 51, 153, .5);
            selectmap = malaysiaMap.penang;
//          _mapController.moveCamera(
//              CameraUpdate.newLatLng(LatLng(5.380652,100.252891),
//
//              ));
            _mapController
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(5.380652, 100.252891),
              zoom: 11,
            )));
            //_goToPosition1();
          });
        },
      ),
    );

    _polygons.add(Polygon(
      polygonId: PolygonId("1"),
      points: listTest,
      fillColor: _testColor,
      strokeWidth: 1,
      consumeTapEvents: true,
      onTap: () {
        setState(() {
//          _testColor = Colors.yellow;
          selectmap = malaysiaMap.penang;
//          _mapController.moveCamera(
//              CameraUpdate.newLatLng(LatLng(5.380652,100.252891),
//
//              ));
          _mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(5.351545, 100.455316),
                    zoom: 11,
                  )
              )
          );
          //_goToPosition1();
        });
      },
    ));

    CameraPosition position() {
      switch (selectmap) {
        case malaysiaMap.malaysia:
          return CameraPosition(
            target: LatLng(5.285153, 100.456238),
            zoom: 6.5,
          );
        case malaysiaMap.penang:
          return CameraPosition(
            target: LatLng(5.285153, 100.456238),
            zoom: 15,
          );
      }

      setState(() {});

      return CameraPosition(
        target: LatLng(5.285153, 100.456238),
        zoom: 6.5,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(teststring)),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: position(),
            markers: _markers,
            polygons: _polygons,
            onTap: (latLng) {
              // setState(() {
              //   _polygonColor = Colors.green;
              // });

//               setState(() {
//                 _polygonColor = Colors.green;
//                 if (_circles.length >= 1) {
// //                    _circles.add(
// //                      Circle(
// //                        circleId: CircleId("0"),
// //                        center: LatLng(37.76493, -122.42432),
// //                        radius: 1000,
// //                        strokeWidth: 2,
// ////                        onTap: () {
// ////                          setState(() {
// ////                            settap = maptap.b;
// ////                          });
// ////                        },
// //                        fillColor:  Colors.yellow,
// //                      ),
// //                    );
//                   settap = maptap.b;
//                 }
//                 settap = maptap.b;
//               });
            },
            polylines: _polylines,
            circles: _circles,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
//          Container(
//            alignment: Alignment.bottomCenter,
//            padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
//            child: Text(apijson[0]['category']),
//          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.map),
        onPressed: () {
          setState(() {
            _showMapStyle = !_showMapStyle;
          });

          _toggleMapStyle();
        },
      ),
    );
  }
}
