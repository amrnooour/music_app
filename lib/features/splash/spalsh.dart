import 'package:flutter/material.dart';
import 'package:music_app/features/all_songs/all_songs.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AllSongs(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(
            "assets/splash.png",
          ),
        ),
      ),
    );
  }
}
