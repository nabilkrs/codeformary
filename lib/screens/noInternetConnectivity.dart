import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/no_internet.gif")),
    );
  }
}
