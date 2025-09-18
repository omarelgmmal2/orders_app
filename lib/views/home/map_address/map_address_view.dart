import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vegetable_orders_project/core/utils/app_images.dart';

class MapAddressView extends StatefulWidget {
  const MapAddressView({super.key});

  @override
  State<MapAddressView> createState() => _MapAddressViewState();
}

class _MapAddressViewState extends State<MapAddressView> {
  final googleMapController = Completer<GoogleMapController>();
  String mapStyle = "";
  Set<Marker> markers = {};
  StreamSubscription<Position>? positionStream;
  bool isPermissionGranted = false;
  LatLng? currentLocation;

  Future<BitmapDescriptor> customIcon(String assets) async {
    return await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48.h, 48.h)),
      assets,
    );
  }

  void loadMapStyle() async {
    final String style = await DefaultAssetBundle.of(
      context,
    ).loadString("assets/map/map_style.json");
    setState(() {
      mapStyle = style;
    });
  }

  checkPermissionRequest() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        isPermissionGranted = true;
      });
      getUserLocation();
    } else {}
  }

  void getUserLocation() async {
    if (!isPermissionGranted) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              currentLocation ?? LatLng(31.074867870903972, 31.40560927615312),
          zoom: 14,
        ),
      ),
    );

    startTracking();
  }

  void startTracking() async {
    positionStream =
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
        ).listen((Position position) {
          setState(() {
            currentLocation = LatLng(position.latitude, position.longitude);
          });
          googleMapController.future.then((value) {
            value.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target:
                      currentLocation ??
                      LatLng(31.074867870903972, 31.40560927615312),
                  zoom: 14,
                ),
              ),
            );
          });
        });
  }

  @override
  void initState() {
    loadMapStyle();
    checkPermissionRequest();
    super.initState();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: isPermissionGranted,
          style: mapStyle,
          initialCameraPosition: CameraPosition(
            target: LatLng(31.040791289214454, 31.380437392354203),
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController controller) async {
            googleMapController.complete(controller);
            final BitmapDescriptor carIcon = await customIcon(AppImages.car);
            setState(() {
              markers.addAll({
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(31.040791289214454, 31.380437392354203),
                  infoWindow: InfoWindow(
                    title: "Marker 1",
                    snippet: "Mansoura",
                  ),
                  icon: carIcon,
                ),
              });
            });
          },
          markers: markers,
        ),
      ),
    );
  }
}
