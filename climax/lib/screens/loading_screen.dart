import "package:climax/screens/location_screen.dart";
import 'package:flutter/material.dart';
import "package:climax/services/location.dart";
import "package:climax/services/networking.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String apiKey = "5c91a1d854fba97feeb075883795e755";
  double? lat;
  double? lan;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    lan = location.longitude;
    Networking newtwork = Networking(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lan&appid=$apiKey&units=metric');

    var data = await newtwork.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationData: data,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 100.0),
      ),
    );
  }
}
