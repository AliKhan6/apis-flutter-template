import 'package:antonx_flutter_template/core/enums/view_state.dart';
import 'package:antonx_flutter_template/core/others/base_view_model.dart';
import 'package:antonx_flutter_template/core/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinLocationViewModel extends BaseViewModel {
  late GoogleMapController controller;
  late CameraPosition initialCameraPosition;
  var currentLocationIcon;
  Set<Marker> markers = Set<Marker>();
  late LatLng markerPosition;
  final _locationService = LocationService();
  LatLng? currentLoc;
  LatLng? selectedLocation;

  PinLocationViewModel() {
    init();
  }

  init() async {
    setState(ViewState.busy);
    markerPosition = LatLng(34.045253, 71.593056); // Peshawar pin
    this.initialCameraPosition =
        CameraPosition(target: markerPosition, zoom: 10);
    _setupCustomMarkers();
    setState(ViewState.idle);
  }

  _setupCustomMarkers() async {
    currentLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/static_images/current-location.png');
  }

  addMarker(LatLng markerLocation) {
    selectedLocation = markerLocation;
    markers.clear();
    markers.add(
      Marker(
        position: markerLocation,
        markerId: MarkerId('pin_location'),
        infoWindow: InfoWindow(title: 'Your selected location'),
      ),
    );
    notifyListeners();
  }

  getAndAnimateToCurrentLocation() async {
    final loc = await _locationService.getCurrentLocation();
    if (loc != null) {
      currentLoc = LatLng(loc.latitude, loc.longitude);
      markers.add(Marker(
        markerId: MarkerId('current_location'),
        position: currentLoc!,
        infoWindow: InfoWindow(title: 'Current Location'),
        icon: currentLocationIcon,
      ));
      notifyListeners();
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLoc!, zoom: 10)));
    }
  }

  // launchUrl() async {
  //   if (await canLaunch((_googleMapsUrl))) {
  //     debugPrint('$_googleMapsUrl');
  //     await launch(_googleMapsUrl);
  //   } else {
  //     print('Exception @launchUrl: Can\'t luanch $_googleMapsUrl');
  //   }
  // }
}
