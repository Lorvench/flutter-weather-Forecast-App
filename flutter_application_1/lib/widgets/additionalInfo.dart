import 'package:flutter/material.dart';

// ignore: camel_case_types
class additionalInfo extends StatelessWidget {
  const additionalInfo(
      {super.key,
      required this.addinfoIcon,
      required this.addinfoRate,
      required this.addinfoTemp});
  final IconData addinfoIcon;
  final String addinfoRate;
  final String addinfoTemp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 150,
      child: Card(
        elevation: 0,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Icon(
            addinfoIcon,
            size: 50,
          ),
          Text(
            addinfoRate,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            addinfoTemp,
            style: const TextStyle(fontSize: 20),
          )
        ]),
      ),
    );
  }
}
