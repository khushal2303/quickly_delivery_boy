import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/screens/login/login_screen.dart';
import 'package:quickly_delivery/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashScreen());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return const LoginScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ConstantImages.splashIcon),
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                  // child: Image.asset(
                  //   ConstantImages.splashIcon,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
