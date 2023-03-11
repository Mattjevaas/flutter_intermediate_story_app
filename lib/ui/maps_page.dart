import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/provider/maps_provider.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatelessWidget {
  final double lat;
  final double lon;

  const MapsPage({
    Key? key,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapsProvider>(
      create: (context) => MapsProvider(startLat: lat, startLon: lon),
      builder: (ctx, child) {
        return WillPopScope(
          onWillPop: () async {
            context.pop(ctx.read<MapsProvider>().currLatLon);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Ubah Lokasi"),
            ),
            body: SafeArea(
              child: Center(
                child: Consumer<MapsProvider>(
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(lat, lon),
                            zoom: 15,
                          ),
                          markers: value.markers,
                          onMapCreated: (controller) {
                            value.mapController = controller;
                          },
                          onTap: (argument) {
                            value.setNewMarker(
                              lat: argument.latitude,
                              lon: argument.longitude,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              controller: value.addressController,
                              enabled: false,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
