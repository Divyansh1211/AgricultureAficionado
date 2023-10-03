import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatelessWidget {
  static const String id = 'weather_screen';
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat.yMMMMd().format(currentDate);

    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50), bottom: Radius.circular(60)),
                  color: Color(0xFFFFDB70),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '$formattedDate',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontFamily: 'SourceSans3'),
                        ),
                      ),
                      FutureBuilder<Map<String, dynamic>>(
                        future: fetchWeatherData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            final place = snapshot.data?['location']['region'];
                            return Text(
                              "$place",
                              style: TextStyle(
                                  fontSize: 60,
                                  fontFamily: 'SourceSans3',
                                  color: Colors.black),
                            );
                          }
                        },
                      ),
                      Expanded(
                        flex: 10,
                        child: Image(
                          image: AssetImage('images/sunnyy.png'),
                          height: 500,
                          width: 300,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: FutureBuilder<Map<String, dynamic>>(
                          future: fetchWeatherData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else {
                              double temperature =
                                  snapshot.data?['current']['temp_c'];
                              int temp = temperature.toInt();
                              return Text(
                                " $temp°",
                                style: TextStyle(
                                    fontSize: 110,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.w600,
                                    fontFamily: 'Work Sans'),
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFDB70),
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<Map<String, dynamic>>(
                                  future: fetchWeatherData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else {
                                      final wind =
                                          snapshot.data?['current']['humidity'];
                                      return Text(
                                        "  $wind%",
                                        style: TextStyle(
                                            fontFamily: 'SourceSans3',
                                            color: Colors.black,
                                            fontSize: 15),
                                      );
                                    }
                                  },
                                ),
                                Icon(
                                  Ionicons.water_outline,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Humidity',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3',
                                      color: Colors.black,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                  fontSize: 100,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<Map<String, dynamic>>(
                                  future: fetchWeatherData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else {
                                      final wind =
                                          snapshot.data?['current']['wind_kph'];
                                      return Text(
                                        "$wind km/h",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SourceSans3',
                                            color: Colors.black),
                                      );
                                    }
                                  },
                                ),
                                Icon(
                                  WeatherIcons.windy,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Wind',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3',
                                      color: Colors.black,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            Text(
                              '|',
                              style: TextStyle(
                                  fontSize: 100,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<Map<String, dynamic>>(
                                  future: fetchWeatherData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text("Error: ${snapshot.error}");
                                    } else {
                                      final ppt = snapshot.data?['current']
                                          ['precip_mm'];
                                      return Text(
                                        "  $ppt mm",
                                        style: TextStyle(
                                            fontFamily: 'SourceSans3',
                                            color: Colors.black,
                                            fontSize: 15),
                                      );
                                    }
                                  },
                                ),
                                Icon(
                                  WeatherIcons.sprinkle,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Precipitation',
                                  style: TextStyle(
                                      fontFamily: 'SourceSans3',
                                      color: Colors.black,
                                      fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Location location = Location();

LocationData? _locationData;

Future<void> getLocation() async {
  try {
    _locationData = await location.getLocation();
  } catch (e) {
    print("Error getting location: $e");
  }
}

Future<Map<String, dynamic>> fetchWeatherData() async {
  final apiKey = "8c5560cb2d3c40a6bca185246231909";
  final latitude = _locationData?.latitude;
  final longitude = _locationData?.longitude;
  final apiUrl =
      "https://api.weatherapi.com/v1/current.json?key=$apiKey&q=28.7197355,77.0663015";

  final response = await http.get(Uri.parse(apiUrl));
  debugPrint('$latitude,$longitude');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Failed to load weather data");
  }
}