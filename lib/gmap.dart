import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

enum maptap { a, b }

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;
  Color circleColor = Colors.red;

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
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
    target: LatLng(37.78493, -122.42932),
//    tilt: 59.440,
    zoom: 4.5,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position));
  }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(5.472482, 100.197028));
    polygonLatLongs.add(LatLng(5.467372, 100.198886));
    polygonLatLongs.add(LatLng(5.468301, 100.203532));
    polygonLatLongs.add(LatLng(5.465513, 100.205391));
    polygonLatLongs.add(LatLng(5.459009, 100.205855));
    polygonLatLongs.add(LatLng(5.461797, 100.208178));
    polygonLatLongs.add(LatLng(5.458080, 100.212359));
    polygonLatLongs.add(LatLng(5.465513, 100.223974));
    polygonLatLongs.add(LatLng(5.463191, 100.230014));
    polygonLatLongs.add(LatLng(5.463191, 100.231872));
    polygonLatLongs.add(LatLng(5.463191, 100.234195));
    polygonLatLongs.add(LatLng(5.464584, 100.236053));
    polygonLatLongs.add(LatLng(5.464584, 100.238376));
    polygonLatLongs.add(LatLng(5.482238, 100.254172));
    polygonLatLongs.add(LatLng(5.478986, 100.267180));
    polygonLatLongs.add(LatLng(5.479916, 100.272291));
    polygonLatLongs.add(LatLng(5.472947, 100.279259));
    polygonLatLongs.add(LatLng(5.466907, 100.281118));
    polygonLatLongs.add(LatLng(5.469230, 100.293197));
    polygonLatLongs.add(LatLng(5.463655, 100.302024));
    polygonLatLongs.add(LatLng(5.464120, 100.310851));
    polygonLatLongs.add(LatLng(5.459009, 100.315032));
    polygonLatLongs.add(LatLng(5.451111, 100.314568));
    polygonLatLongs.add(LatLng(5.445072, 100.312245));
    polygonLatLongs.add(LatLng(5.444143, 100.314103));
    polygonLatLongs.add(LatLng(5.439497, 100.314103));
    polygonLatLongs.add(LatLng(5.435780, 100.315961));
    polygonLatLongs.add(LatLng(5.431134, 100.320607));
    polygonLatLongs.add(LatLng(5.430670, 100.322465));
    polygonLatLongs.add(LatLng(5.427882, 100.327111));
    polygonLatLongs.add(LatLng(5.423701, 100.333151));
    polygonLatLongs.add(LatLng(5.422307, 100.340120));
    polygonLatLongs.add(LatLng(5.420914, 100.343836));
    polygonLatLongs.add(LatLng(5.418126, 100.346624));
    polygonLatLongs.add(LatLng(5.413945, 100.346624));
    polygonLatLongs.add(LatLng(5.412551, 100.341513));
    polygonLatLongs.add(LatLng(5.406511, 100.339190));
    polygonLatLongs.add(LatLng(5.403259, 100.337797));
    polygonLatLongs.add(LatLng(5.396755, 100.330828));
    polygonLatLongs.add(LatLng(5.391180, 100.329434));
    polygonLatLongs.add(LatLng(5.390716, 100.326647));
    polygonLatLongs.add(LatLng(5.385141, 100.316890));
    polygonLatLongs.add(LatLng(5.376778, 100.317355));
    polygonLatLongs.add(LatLng(5.367951, 100.319213));
    polygonLatLongs.add(LatLng(5.356801, 100.316426));
    polygonLatLongs.add(LatLng(5.349368, 100.316426));
    polygonLatLongs.add(LatLng(5.337289, 100.313638));
    polygonLatLongs.add(LatLng(5.327532, 100.309457));
    polygonLatLongs.add(LatLng(5.325674, 100.305276));
    polygonLatLongs.add(LatLng(5.312666, 100.300166));
    polygonLatLongs.add(LatLng(5.296870, 100.297378));
    polygonLatLongs.add(LatLng(5.285255, 100.294126));
    polygonLatLongs.add(LatLng(5.278287, 100.290409));
    polygonLatLongs.add(LatLng(5.271318, 100.283441));
    polygonLatLongs.add(LatLng(5.264349, 100.283441));
    polygonLatLongs.add(LatLng(5.255987, 100.284834));
    polygonLatLongs.add(LatLng(5.252735, 100.278795));
    polygonLatLongs.add(LatLng(5.257380, 100.272755));
    polygonLatLongs.add(LatLng(5.261562, 100.270432));
    polygonLatLongs.add(LatLng(5.268530, 100.267180));
    polygonLatLongs.add(LatLng(5.272247, 100.261141));
    polygonLatLongs.add(LatLng(5.278751, 100.248132));
    polygonLatLongs.add(LatLng(5.272712, 100.243951));
    polygonLatLongs.add(LatLng(5.282468, 100.239305));
    polygonLatLongs.add(LatLng(5.284326, 100.234195));
    polygonLatLongs.add(LatLng(5.284791, 100.228620));
    polygonLatLongs.add(LatLng(5.285720, 100.224439));
    polygonLatLongs.add(LatLng(5.281539, 100.222580));
    polygonLatLongs.add(LatLng(5.278751, 100.221186));
    polygonLatLongs.add(LatLng(5.280145, 100.212824));
    polygonLatLongs.add(LatLng(5.277822, 100.207249));
    polygonLatLongs.add(LatLng(5.277357, 100.205855));
    polygonLatLongs.add(LatLng(5.276893, 100.200280));
    polygonLatLongs.add(LatLng(5.277822, 100.189130));
    polygonLatLongs.add(LatLng(5.278751, 100.188201));
    polygonLatLongs.add(LatLng(5.273176, 100.187736));
    polygonLatLongs.add(LatLng(5.265278, 100.186807));
    polygonLatLongs.add(LatLng(5.270853, 100.178909));
    polygonLatLongs.add(LatLng(5.279216, 100.178909));
    polygonLatLongs.add(LatLng(5.287114, 100.181232));
    polygonLatLongs.add(LatLng(5.289437, 100.183555));
    polygonLatLongs.add(LatLng(5.301051, 100.183555));
    polygonLatLongs.add(LatLng(5.307091, 100.185878));
    polygonLatLongs.add(LatLng(5.307555, 100.191453));
    polygonLatLongs.add(LatLng(5.306162, 100.194705));
    polygonLatLongs.add(LatLng(5.309878, 100.196099));
    polygonLatLongs.add(LatLng(5.323351, 100.196099));
    polygonLatLongs.add(LatLng(5.328926, 100.195634));
    polygonLatLongs.add(LatLng(5.340541, 100.195634));
    polygonLatLongs.add(LatLng(5.349832, 100.195170));
    polygonLatLongs.add(LatLng(5.356337, 100.190059));
    polygonLatLongs.add(LatLng(5.369809, 100.184949));
    polygonLatLongs.add(LatLng(5.379566, 100.185878));
    polygonLatLongs.add(LatLng(5.394897, 100.185878));
    polygonLatLongs.add(LatLng(5.402330, 100.185414));
    polygonLatLongs.add(LatLng(5.411622, 100.185878));
    polygonLatLongs.add(LatLng(5.416732, 100.189130));
    polygonLatLongs.add(LatLng(5.423701, 100.189130));
    polygonLatLongs.add(LatLng(5.427882, 100.187272));
    polygonLatLongs.add(LatLng(5.430205, 100.183091));
    polygonLatLongs.add(LatLng(5.432064, 100.174728));
    polygonLatLongs.add(LatLng(5.435780, 100.177051));
    polygonLatLongs.add(LatLng(5.438568, 100.180303));
    polygonLatLongs.add(LatLng(5.444143, 100.177980));
    polygonLatLongs.add(LatLng(5.449718, 100.178909));
    polygonLatLongs.add(LatLng(5.453434, 100.183555));
    polygonLatLongs.add(LatLng(5.463191, 100.182626));
    polygonLatLongs.add(LatLng(5.466907, 100.178909));
    polygonLatLongs.add(LatLng(5.467836, 100.177980));
    polygonLatLongs.add(LatLng(5.471088, 100.176586));
    polygonLatLongs.add(LatLng(5.476663, 100.177051));
    polygonLatLongs.add(LatLng(5.480380, 100.182626));
    polygonLatLongs.add(LatLng(5.480845, 100.185414));
    polygonLatLongs.add(LatLng(5.478057, 100.188666));
    polygonLatLongs.add(LatLng(5.471088, 100.188201));
    polygonLatLongs.add(LatLng(5.472482, 100.197028));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.red,
        strokeWidth: 1,
        onTap: () {
          setState(() {
            _goToPosition1();
          });
        },
      ),
    );
  }

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
      if (settap == maptap.a){
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
      } else if (settap == maptap.b){
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

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(37.77483, -122.41942),
            infoWindow: InfoWindow(
              title: "San Francsico",
              snippet: "An Interesting city",
            ),
            icon: _markerIcon),
      );
    });
  }

  void _changeColor(LatLng latLng) {
    setState(() {
      settap = maptap.b;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (settap == maptap.a)
        circleColor = Colors.red;
      else if (settap == maptap.b) circleColor = Colors.yellow;
    });

    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.77483, -122.41942),
              zoom: 12,
            ),
            markers: _markers,
            polygons: _polygons,
            onTap: (latLng) {
              setState(() {
                if (_circles.length >= 1) {
//                    _circles.add(
//                      Circle(
//                        circleId: CircleId("0"),
//                        center: LatLng(37.76493, -122.42432),
//                        radius: 1000,
//                        strokeWidth: 2,
////                        onTap: () {
////                          setState(() {
////                            settap = maptap.b;
////                          });
////                        },
//                        fillColor:  Colors.yellow,
//                      ),
//                    );
                  settap = maptap.b;
                }
                settap = maptap.b;
              });
            },
            polylines: _polylines,
            circles: _circles,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: Text("Coding with Curry"),
          )
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
