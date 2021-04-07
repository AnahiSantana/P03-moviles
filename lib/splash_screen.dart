import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0884cc),
            Color(0xff04476e),
          ],
        ),
      ),
      child: Center(
        child: Text("News App"),
        //child: Image.asset("assets/app_icon.png"),
      ),
    );
  }
}
