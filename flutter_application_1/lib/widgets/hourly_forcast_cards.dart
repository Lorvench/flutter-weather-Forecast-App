import 'package:flutter/material.dart';

// ignore: camel_case_types
class hourlyForcastCard extends StatelessWidget {
  const hourlyForcastCard(
      {super.key,
      required this.hourTime,
      required this.hourIcon,
      required this.hourTemp});
  final String hourTime;
  final IconData hourIcon;
  final String hourTemp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 180,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                hourTime,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Icon(
                hourIcon,
                size: 50,
              ),
              Text(
                hourTemp,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
