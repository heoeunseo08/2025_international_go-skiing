import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_skiing/controller/audio_controller.dart';
import 'package:go_skiing/screen/home_screen.dart';
import 'package:go_skiing/screen/rankings_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int startCoin = 10;
  bool isPlaying = true;
  bool gameOver = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    AudioController.startBGM();

    duration.value = Duration.zero;

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (isPlaying) {
          duration.value += Duration(seconds: 1);
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    AudioController.endBGM();
    super.dispose();
  }

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
              top: MediaQuery.of(context).size.height / 2,
              right: 0,
              left: 0,
              bottom: 0,
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

            if (!isPlaying)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                        isPlaying
                            ? AudioController.startBGM()
                            : AudioController.endBGM();
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          playerName.value,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        _coin(isPlaying),
                        SizedBox(height: 10),
                        Text("${duration.value.inSeconds} s"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height / 2,
              left: 0,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("돌아가기"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (coinCount == 0) {
                          isPlaying = !isPlaying;
                          gameOver = !gameOver;
                        }
                        coinCount.value++;
                        AudioController.getCoin();
                      });
                    },
                    child: Text("코인 더하기"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                        gameOver = !gameOver;
                      });
                      AudioController.gameOver();
                      AudioController.endBGM();
                      showDialog(
                        context: context,
                        builder: (context) => gameOverPopup(),
                        barrierColor: Colors.transparent,
                      );
                    },
                    child: Text("게임오버"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coin(bool isPlaying) {
    return Row(
      children: [
        Image.asset(
          "assets/images/coin.png",
          scale: 10,
          opacity: AlwaysStoppedAnimation(isPlaying ? 1 : 0.5),
        ),
        SizedBox(width: 10),
        Text(
          "${coinCount.value}",
          style: TextStyle(
            color: isPlaying
                ? Color(0xffF7D01C)
                : Color(0xffF7D01C).withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget gameOverPopup() {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      titlePadding: EdgeInsets.only(left: 24, top: 16),
      contentPadding: EdgeInsets.only(left: 24, bottom: 8),
      actionsPadding: EdgeInsets.zero,
      title: Text(
        "Game Over",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Player name: ${playerName.value}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                "assets/images/coin.png",
                scale: 11,
              ),
              SizedBox(width: 10),
              Text(
                "${coinCount.value}",
                style: TextStyle(color: Color(0xffF7D01C), fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "time: ${duration.value.inSeconds}s",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              isPlaying = true;
              gameOver = false;
              coinCount.value = 10;
              duration.value = Duration.zero;
            });
            AudioController.startBGM();
            Navigator.of(context).pop();
          },
          child: Text(
            "Restart",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RankingsScreen(),
              ),
            );
          },
          child: Text(
            "Go to Rankings",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
