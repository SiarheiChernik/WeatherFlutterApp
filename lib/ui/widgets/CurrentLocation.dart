import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  final String currentLocation;

  CurrentLocation({Key key, @required this.currentLocation})
      : assert(currentLocation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.location_on,
          size: 32.0,
        ),
        Text(
          currentLocation,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
