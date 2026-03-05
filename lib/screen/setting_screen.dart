import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_skiing/screen/home_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double hue = 0;
  Color selectColor = jacketColor.value == Color(0xffF87373)
      ? Color(0xffF87373)
      : jacketColor.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/skiing_person.png",
            width: 250,
            color: selectColor,
            colorBlendMode: BlendMode.modulate,
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 90),
            child: Slider(
              min: 0,
              max: 360,
              activeColor: Colors.blue,
              value: hue,
              onChanged: (value) {
                setState(() {
                  hue = value;
                  selectColor = HSLColor.fromAHSL(1, value, 1, 0.5).toColor();
                });
              },
            ),
          ),
          SizedBox(height: 60),
          GestureDetector(
            onTap: () {
              log("$selectColor");
              jacketColor.value = selectColor;
              Navigator.of(context).pop();
            },
            child: Container(
              width: 140,
              color: Color(0xff9DD4FA),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              alignment: Alignment.center,
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
