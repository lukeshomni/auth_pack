
import 'package:flutter/material.dart';

import '../../../../core/styles/theme.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/shared_widgets/white_button.dart';

class SplashScreen extends StatelessWidget {
  static String tag = '/landing_screen';
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 50, right: 50),
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(),
              _buildImage(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }
}

Widget _buildTitle() {
  return Text(
    Constants.landingTitle,
    style: headlineLarge,
  );
}

Widget _buildImage() {
  return Image.asset(Assets.landingImage);
}

Widget _buildButton() {
  return WhiteButton(
    onPressed: () {
    },
    text: 'Get Started',
  );
}
