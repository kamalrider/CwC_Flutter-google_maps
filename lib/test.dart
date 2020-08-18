import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Template());

Future fetchData() async {
  var jsonResponse;

  var response = await http.get(
      "https://nominatim.openstreetmap.org/search.php?q=seberang%20perai&polygon_geojson=1&format=jsonv2");

  if (response.statusCode == 200)
    return jsonResponse = json.decode(response.body);
}

class Template extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemplateHome(),
    );
  }
}

class TemplateHome extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<TemplateHome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(),
        builder: (context,snapshot){
          return Text(snapshot.data[0]['type']);
        },
      ),

//      Center(
//        child: Text('test'),
//      ),
    );
  }
}
