import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Selamat datang! Silahkan login",
          style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor, fontSize: 20, fontFamily: "sans-serif"),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
              'assets/images/loginbg.jpg',
              width: 380.0,
              height: 230.0,
              fit: BoxFit.cover,
            ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
