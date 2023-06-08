import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../model/weather_model.dart';

class ApiResponse {
  Future<Weather> getWeather() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    Position? position = await Geolocator.getCurrentPosition();
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&APPID=cd5f4b1c7019e7c90b52c80cf859b747';
    final response = await http.get(Uri.parse(url));
    return Weather.fromJson(json.decode(response.body));
  }
}
