import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                'assets/images/welcomebg.png',
                width: 380.0,
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
          ],
        ),
        const Text(
          "Selamat Datang!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kPrimaryColor,
          ),
        ),
        Container(
          child: Text(
            "Mudah top-up hanya dengan KlikTopup!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: "sans-serif",
              color: kPrimaryColor,
            ),
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
