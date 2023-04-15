import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:nova_sport_app/page/login/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/image/nova_sport-remov.png',
        fit: BoxFit.contain,
      ),
      logoWidth: 100.0,
      backgroundColor: Colors.yellow,
      showLoader: true,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(fontSize: 10),
      ),
      navigator: LoginPage(),
      durationInSeconds: 5,
    );
  }
}
