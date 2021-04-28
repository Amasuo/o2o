import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider extends ChangeNotifier {
  bool error = false;
  bool loading = false;
  String errorMsg = "";
  SiyouLocation location;

  Future<void> getcurrentLocantionAndadrees(BuildContext context) async {
    try {
      loading = true;
      final String loc = await getUserLocation();
      if (loc != null && loc.isNotEmpty) {
        print(loc);
        //this.location = SiyouLocation.fromJson(jsonDecode(loc));
        loading = false;
        notify();
      } else {
        print("geting user current location...");
        final postion = await currentLocation();
        List<Placemark> placemarks =
            await placemarkFromCoordinates(postion.latitude, postion.longitude);
        Placemark placeMark = placemarks[0];
        this.location = SiyouLocation(
            placeMark.country,
            placeMark.isoCountryCode,
            placeMark.locality,
            postion.latitude,
            postion.longitude);
        // saveUserLocation(location);
        loading = false;
        notify();
      }
    } catch (e) {
      error = true;
      errorMsg = e.toString();
      notify();
    }
  }

  Future<void> changecurrentLocantionAndadrees(
      BuildContext context, LocationResult locationresult) async {
    try {
      loading = true;
      this.location = SiyouLocation(
          locationresult.country.name,
          locationresult.country.shortName,
          locationresult.city.name,
          locationresult.latLng.latitude,
          locationresult.latLng.longitude);
      loading = false;
      notify();
    } catch (e) {
      error = true;
      errorMsg = e.toString();
      notify();
    }
  }

  Future<Position> currentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, timeLimit: Duration(seconds: 5));
  }

  Future<void> saveUserLocation(SiyouLocation location) async {
    final pref = await SharedPreferences.getInstance();
    final String loc = jsonEncode(location);
    pref.setString("loaction", loc);
  }

  Future<String> getUserLocation() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('loaction');
  }

  void notify() {
    try {
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

class SiyouLocation {
  String isoCountry;
  String countryName;
  String loacality;
  double lat;
  double long;

  SiyouLocation(
      this.countryName, this.isoCountry, this.loacality, this.lat, this.long);

  SiyouLocation.fromJson(Map<String, dynamic> json) {
    countryName = json['countryName'];
    isoCountry = json['isoCountry'];
    loacality = json['loacality'];
    lat = json['lat'];
    long = json['long'];
  }

  static Map<String, dynamic> toMap(SiyouLocation loaction) => {
        'isoCountry': loaction.isoCountry,
        'countryName': loaction.countryName,
        'loacality': loaction.loacality,
        'lat': loaction.lat,
        'long': loaction.long,
      };
}
