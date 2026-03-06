import 'package:flutter/services.dart';

class AudioController {
  static const _channel = MethodChannel("sound");

  static Future<void> getCoin() async {
    await _channel.invokeMethod("coin");
  }

  static Future<void> jump() async {
    await _channel.invokeMethod("jump");
  }

  static Future<void> gameOver() async {
    await _channel.invokeMethod("gameOver");
  }

  static Future<void> startBGM() async {
    await _channel.invokeMethod("startBGM");
  }

  static Future<void> endBGM() async {
    await _channel.invokeMethod("endBGM");
  }
}
