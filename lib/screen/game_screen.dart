import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int startCoin = 10;
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/bg.jpg"),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 60,
              child: SizedBox(
                height: 330,
                width: 330,
                child: Image.asset(
                  "assets/images/trees.png",
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 50,
                      color: Colors.black,
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
}
