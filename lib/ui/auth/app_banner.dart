import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 40.0,
          ),
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chef1.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        // Positioned(
        //     child: Container(
        //   margin: const EdgeInsets.all(50),
        //   child: const Center(
        //     child: Text(
        //       "My Restaurant",
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 40,
        //           fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // )),
      ],
    );
  }
}
