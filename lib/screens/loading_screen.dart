// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weatherModel = WeatherModel();

  void printLocation() async {
    var data = await weatherModel.getLocationWeather();

    /*  Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(data);
    }));
*/
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LocationScreen(data)),
        (Route<dynamic> route) => false);
    //Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    printLocation();
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage image = DecorationImage(
      fit: BoxFit.fitHeight,
      image: AssetImage('images/load_screen.jpeg'),
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: image,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              radius: 1.15,
              colors: [
                Color(0x22180E2F),
                Color(0xff000000),
              ],
              //stops: [0.0, 1.0],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SpinKitThreeBounce(
                color: Color(0xe7e4d3ff),
              ),
/*              child: ProgressIndicatorTheme(
                data: ProgressIndicatorThemeData(
                  color: Color(0xff52396e),
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),*/
            ),
          ),
        ),
      ),
    );
  }
}
