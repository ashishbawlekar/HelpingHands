import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map?.dart';
// import 'package:latlong/latlong.dart';?
// import 'package:flutter_map/src/'
class TestMap extends StatefulWidget {
  @override
  _TestMapState createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
    ); 
    // FlutterMap(
    //   options: MapOptions(
    //     center: LatLng(51.5, -0.09),
    //     zoom: 13.0,
    //   ),
    //   layers: [
    //      TileLayerOptions(
    //       urlTemplate:  'https://tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=72a70a740b3f429e81a178e9115aeb08 ', //"https://api.tiles.mapbox.com/v4/"
    //           // "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
    //       // additionalOptions: {
    //       //   // 'accessToken': 'sk.eyJ1IjoiaGVscGluZ2hhbmRzNDMyMTAiLCJhIjoiY2s0NzA3ZTd1MG5zZDNsbGZrZnFhcWpncSJ9.fuzpCN4QrPBnvK4roSHEig',
    //       //   // 'id': 'mapbox.streets',
    //       // },
    //     ),
    //      MarkerLayerOptions(
    //       markers: [
    //          Marker(
    //           width: 80.0,
    //           height: 80.0,
    //           point: LatLng(51.5, -0.09),
    //           builder: (ctx) =>
    //            Container(
    //             child:  FlutterLogo(),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}