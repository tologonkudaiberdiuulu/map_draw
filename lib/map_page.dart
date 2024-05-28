import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'tile_providers.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<LatLng> coordinates = [];
  late List<Polygon> mapsPolygons;

  void tapMap(LatLng pos) {
    setState(() {
      if (coordinates.contains(pos)) {
        coordinates.remove(pos);
      } else {
        coordinates.add(pos);
      }
    });
  }

  @override
  void initState() {
    mapsPolygons = [
      Polygon(
        points: coordinates,
        borderStrokeWidth: 2,
        borderColor: Colors.black,
        color: Colors.green,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Polygons')),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(42.869867, 74.604884),
              initialZoom: 12,
              onTap: (tapPosition, point) {
                tapMap(point);
              },
            ),
            children: [
              openStreetMapTileLayer,
              if (coordinates.length > 2)
                PolygonLayer(
                  // key: UniqueKey(),
                  simplificationTolerance: 0,
                  polygons: mapsPolygons,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
