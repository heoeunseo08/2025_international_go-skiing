import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_skiing/screen/game_screen.dart';
import 'package:go_skiing/screen/rankings_screen.dart';
import 'package:go_skiing/screen/setting_screen.dart';

ValueNotifier<Color> jacketColor = ValueNotifier(Color(0xffF87373));
ValueNotifier<int> coinCount = ValueNotifier(0);
ValueNotifier<String> playerName = ValueNotifier("");
ValueNotifier<Duration> duration = ValueNotifier(Duration.zero);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.65),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Go Skiing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusColor: Colors.black,
                      hint: Text(
                        "Player name",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      log("게임 시ㅈ가");
                      playerName.value = controller.text;

                      controller.text.isEmpty
                          ? showDialog(
                              context: context,
                              builder: (context) => invalidPopUp(),
                            )
                          : Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => GameScreen(),
                              ),
                            );
                    },
                    child: Container(
                      width: 140,
                      color: Color(0xff9DD4FA),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Start Game",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      log("랭킬");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RankingsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      color: Color(0xff9DD4FA),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Rankings",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      log("세팅");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      color: Color(0xff9DD4FA),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Setting",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget invalidPopUp() {
    return AlertDialog(
      title: Text(
        "플레이어 이름을 입력해주세요",
        style: TextStyle(fontSize: 20),
      ),
      content: Text("게임을 시작하려면 이름을 입력해야 합니다."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("예"),
        ),
      ],
    );
  }
}
