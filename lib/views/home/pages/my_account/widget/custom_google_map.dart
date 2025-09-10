import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/logic/cache_helper.dart';
import '../../../../../features/address/get_location.dart';
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
  @override
  void initState() {
    super.initState();

    _determinePosition();
    _initMarker();
  }

  Future<void> _determinePosition()async{
    if (GetLocation.initialPosition == null) {
      await GetLocation.determinePosition();
      setState(() {
      });
    }
  }

  late BitmapDescriptor customIcon;
  void _initMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/marker.png');
    if (!widget.isAddTitle) {
      markers.add(
        Marker(
          icon: customIcon,
          markerId: const MarkerId("1"),
          position: LatLng(widget.lat!, widget.lng!),
        ),
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (googleMapController != null) {
      googleMapController!.dispose();
    }
  }

  void goToLocation(
      {required double latitude, required double longitude}) async {
    if (googleMapController != null) {
      googleMapController!.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(latitude, longitude),
              15,
          ),
      );
      markers.clear();
      markers.add(
        Marker(
          icon: customIcon,
          markerId: const MarkerId('1'),
          position: LatLng(latitude, longitude),
        ),
      );
    }

    bloc.lat = (latitude.toString());
    bloc.lng = (longitude.toString());
    CacheHelper.setLat(latitude.toString());
    CacheHelper.setLng(longitude.toString());
    List<Placemark> placemarks =
    await placemarkFromCoordinates(latitude, longitude);
    var myPlace = placemarks.first;
    CacheHelper.setLocation(myPlace.street ?? "");
    bloc.location = myPlace.street;
  }

  @override
  Widget build(BuildContext context) {
    return GetLocation.initialPosition == null
        ? Center(
      child: Text(
        'loading map...',
        style: TextStyle(
            fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
      ),
    )
        : ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: GoogleMap(
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
        },
        initialCameraPosition:
        CameraPosition(target: GetLocation.initialPosition!, zoom: 15),
        onTap: (argument) {
          goToLocation(
              latitude: argument.latitude, longitude: argument.longitude);
          setState(() {});
        },
        gestureRecognizers: {}..add(Factory<EagerGestureRecognizer>(
                () => EagerGestureRecognizer())),
      ),
    );
  }
}
