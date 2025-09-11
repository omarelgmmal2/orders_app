import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/logic/cache_helper.dart';
import '../../../../../features/address/set_address/set_address_bloc.dart';

class CustomGoogleMap extends StatefulWidget {
  final bool isAddTitle;
  final double? lat;
  final double? lng;

  const CustomGoogleMap({
    super.key,
    required this.isAddTitle,
    this.lat,
    this.lng,
  });

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  final bloc = KiwiContainer().resolve<SetUpdateAddressBloc>();
  GoogleMapController? googleMapController;
  final Set<Marker> markers = {};
  late BitmapDescriptor customIcon;

  LatLng? currentPosition;
  final LatLng defaultPosition = const LatLng(30.0444, 31.2357); // القاهرة

  @override
  void initState() {
    super.initState();
    _initMarker();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // GPS service
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationDialog(
        "خدمة الموقع مغلقة",
        "من فضلك فعّل خدمة الموقع (GPS) من الإعدادات",
      );
      return;
    }

    // Permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationDialog(
          "الإذن مرفوض",
          "من فضلك فعّل إذن الموقع من الإعدادات لاستخدام الخريطة",
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationDialog(
        "الإذن مرفوض نهائياً",
        "من فضلك فعّل إذن الموقع من الإعدادات يدويًا",
      );
      return;
    }

    // لو كل حاجة تمام → هات الموقع
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
      });
    }
  }

  void _initMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/marker.png',
    );

    if (!widget.isAddTitle && widget.lat != null && widget.lng != null) {
      markers.add(
        Marker(
          icon: customIcon,
          markerId: const MarkerId("1"),
          position: LatLng(widget.lat!, widget.lng!),
        ),
      );
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  void goToLocation({
    required double latitude,
    required double longitude,
  }) async {
    if (googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 15),
      );
    }

    markers.clear();
    markers.add(
      Marker(
        icon: customIcon,
        markerId: const MarkerId('1'),
        position: LatLng(latitude, longitude),
      ),
    );

    bloc.lat = latitude.toString();
    bloc.lng = longitude.toString();
    CacheHelper.setLat(latitude.toString());
    CacheHelper.setLng(longitude.toString());

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        var myPlace = placemarks.first;
        CacheHelper.setLocation(myPlace.street ?? "Unknown location");
        bloc.location = myPlace.street ?? "Unknown location";
      } else {
        CacheHelper.setLocation("Unknown location");
        bloc.location = "Unknown location";
      }
    } catch (e) {
      debugPrint("Geocoding error: $e");
      CacheHelper.setLocation("Unknown location");
      bloc.location = "Unknown location";
    }

    if (mounted) setState(() {});
  }

  void _showLocationDialog(String title, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("إغلاق"),
              onPressed: () => Navigator.pop(ctx),
            ),
            TextButton(
              child: const Text("الإعدادات"),
              onPressed: () {
                Geolocator.openAppSettings();
                Geolocator.openLocationSettings();
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: GoogleMap(
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: currentPosition ?? defaultPosition,
          zoom: 15,
        ),
        onTap: (argument) {
          goToLocation(
            latitude: argument.latitude,
            longitude: argument.longitude,
          );
        },
        gestureRecognizers: {
          Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
        },
      ),
    );
  }
}
