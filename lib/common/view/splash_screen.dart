import 'package:flutter/material.dart';
import 'package:wagle_front/common/layout/default_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        child: Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ));
  }
}
