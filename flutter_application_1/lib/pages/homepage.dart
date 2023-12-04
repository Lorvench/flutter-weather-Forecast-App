import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/additionalInfo.dart';
import 'package:flutter_application_1/widgets/hourly_forcast_cards.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Future<Map<String, dynamic>?> getWeather() async {
    final res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=c2f01fcf3ee97715811eff3f8ef5f514"));

    final data = jsonDecode(res.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          widthFactor: double.infinity,
          child: Text(
            'Weather Forcast',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return const Text("An error has occured");
          }
          final data = snapshot.data;
          final repet = data?['list'][0];
          final currentTemp = repet["main"]["temp"];
          final currentsky = repet["weather"][0]['main'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Card(
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            currentTemp.toString(),
                            style: const TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            repet["weather"][0]['main'] == "Cloud"
                                ? Icons.cloud
                                : Icons.water_drop,
                            size: 70,
                          ),
                          Text(
                            currentsky,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Hourly Forcast",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          hourlyForcastCard(
                              hourTime: data?['list'][i + 1]["dt_txt"],
                              hourIcon: data?['list'][i + 1]["weather"][0]
                                          ['main'] ==
                                      "Cloud"
                                  ? Icons.cloud
                                  : Icons.water_drop,
                              hourTemp: data!['list'][i + 1]["main"]["temp"]
                                  .toString()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      additionalInfo(
                          addinfoIcon: Icons.water_drop,
                          addinfoRate: "Humidity",
                          addinfoTemp: "500"),
                      additionalInfo(
                          addinfoIcon: Icons.wind_power,
                          addinfoRate: "Wind Speed",
                          addinfoTemp: "34.5"),
                      additionalInfo(
                          addinfoIcon: Icons.cloud,
                          addinfoRate: "pressure",
                          addinfoTemp: "700"),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
