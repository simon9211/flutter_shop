import 'package:flutter/material.dart';

// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong/latlong.dart';

class CustomMapView extends StatefulWidget {
  final String title;

  const CustomMapView({Key key, this.title}) : super(key: key);

  @override
  _CustomMapViewState createState() => _CustomMapViewState();
}

class _CustomMapViewState extends State<CustomMapView> {
  @override
  Widget build(BuildContext context) {
    //   return FlutterMap(
    //     options: MapOptions(
    //       center: LatLng(51.5, -0.09),
    //       zoom: 13.0,
    //     ),
    //     layers: [
    //       TileLayerOptions(
    //         urlTemplate:
    //             "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
    //         additionalOptions: {
    //           'subscriptionKey': '<YOUR_AZURE_MAPS_SUBSCRIPTON_KEY>'
    //         },
    //       ),
    //       MarkerLayerOptions(
    //         markers: [
    //           Marker(
    //             width: 80.0,
    //             height: 80.0,
    //             point: LatLng(51.5, -0.09),
    //             builder: (ctx) => Container(
    //               child: FlutterLogo(),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Text('data'));
  }
}

// class LatLng {
//   double x, y;
//   LatLng(this.x, this.y);
// }
