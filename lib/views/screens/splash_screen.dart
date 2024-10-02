import 'dart:async';

import 'package:final_exam/main.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),() {
      Navigator.of(context).pushReplacementNamed('/home');
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.note_alt_rounded,size: 100,),),
    );
  }
}
