import 'dart:async';

import 'package:codeformary/screens/noInternetConnectivity.dart';
import 'package:codeformary/screens/webview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _networkTimer;

  bool isOnline = true;
  Connectivity connectivity = Connectivity();
  String res = "";

  @override
  void initState() {
    super.initState();
    _networkTimer = Timer(const Duration(milliseconds: 300), () async {
      ConnectivityResult result = await connectivity.checkConnectivity();
      connectivity.onConnectivityChanged.listen((result) async {
        if (result == ConnectivityResult.none) {
          setState(() {
            isOnline = false;
          });
        } else {
          Response response = await get(Uri.parse('https://www.google.com'));
          if (response.body.isEmpty) {
            setState(() {
              isOnline = false;
            });
          } else {
            setState(() {
              isOnline = true;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isOnline ? MyWebView() : NoInternet(),
      ),
    );
  }
}
