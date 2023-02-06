// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location? location = Location();
    try {
      await location.getCurrentLocation();
    } catch (e) {
      location = null;
    }

    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location?.latitude}&lon=${location?.longitude}&appid=$kAppID&units=metric',
    );
    var data;
    try {
      if (location?.longitude == null || location?.latitude == null) {
        data = null;
      }
      data = await networkHelper.getData();
    } catch (e) {
      data = null;
    }
    return data;
  }

  Future<dynamic> getLocationWeatherByName(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$kAppID&units=metric',
    );
    var data;
    try {
      data = await networkHelper.getData();
    } catch (e) {
      data = null;
    }
    return data;
  }

  Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return Icon(
        FontAwesomeIcons.cloudSunRain,
        size: 110,
        color: Color(0xff9bb3d9),
      );
    } else if (condition < 400) {
      return Icon(
        FontAwesomeIcons.cloudRain,
        size: 110,
        color: Color(0xff7a87e0),
      );
    } else if (condition < 600) {
      return Icon(
        FontAwesomeIcons.umbrella,
        size: 110,
        color: Color(0xff7655f5),
      );
    } else if (condition < 700) {
      return Icon(
        FontAwesomeIcons.snowman,
        size: 110,
        color: Color(0xffc3e9ff),
      );
    } else if (condition < 800) {
      return Icon(
        Icons.clear_all_rounded,
        size: 110,
        color: Color(0xff8da2ce),
      );
    } else if (condition == 800) {
      return Icon(
        Icons.sunny,
        size: 110,
        color: Colors.yellowAccent[400],
      );
    } else if (condition <= 804) {
      return Icon(
        Icons.cloud,
        size: 110,
        color: Color(0xffc7fdf7),
      );
    } else {
      return Icon(
        Icons.error,
        size: 110,
        color: Colors.red[400],
      );
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s Ice cream time';
    } else if (temp > 20) {
      return 'Time for spring clothes and T-shirts';
    } else if (temp < 10) {
      return 'You\'ll need scarf and gloves';
    } else {
      return 'Bring a Jacket just in case';
    }
  }
}
