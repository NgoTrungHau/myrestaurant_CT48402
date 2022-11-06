import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color c = Color.fromRGBO(76, 255, 204, 0);
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 54.0,
      ),
      transform: Matrix4.rotationZ(0 * pi / 180)..translate(0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 255, 30, 30),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black26,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(
        'MyRestaurant',
        style: TextStyle(
          color: Colors.orange,
          // color: Theme.of(context).textTheme.headline6?.color,
          fontSize: 35,
          fontFamily: 'Anton',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
