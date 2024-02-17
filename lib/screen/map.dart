import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  TextEditingController mapSearch = TextEditingController();

  final LatLng _center = const LatLng(
    37.540853,
    127.078971,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
        ),
        TextField(
  style: TextStyle(fontSize: 22),
  textAlign: TextAlign.left,
  controller: mapSearch,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    errorStyle: TextStyle(fontSize: 10),
    contentPadding: EdgeInsets.zero,
    hintText: ' 입력해주세요.',
    border: OutlineInputBorder(),
  ),
),
      ],
    );
  }
}
