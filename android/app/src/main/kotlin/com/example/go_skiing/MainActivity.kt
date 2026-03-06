package com.example.go_skiing

import android.media.MediaPlayer
import android.media.SoundPool
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "sound"

    private lateinit var soundPool: SoundPool
    private var coinId = 0
    private var jumpId = 0
    private var gameOverId = 0

    private var mediaPlayer: MediaPlayer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        soundPool = SoundPool.Builder().setMaxStreams(5).build()

        coinId = soundPool.load(this, R.raw.coin, 1)
        jumpId = soundPool.load(this, R.raw.jump, 1)
        gameOverId = soundPool.load(this, R.raw.game_over, 1)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "coin" -> {
                    soundPool.play(coinId, 1f, 1f, 1, 0, 1f)
                }

                "jump" -> {
                    soundPool.play(jumpId, 1f, 1f, 1, 0, 1f)
                }

                "gameOver" -> {
                    soundPool.play(gameOverId, 1f, 1f, 1, 0, 1f)
                }

                "startBGM" -> {
                    if (mediaPlayer == null) {
                        mediaPlayer = MediaPlayer.create(this, R.raw.bgm)
                        mediaPlayer?.isLooping = true
                        mediaPlayer?.start()
                    }
                }

                "endBGM" -> {
                    mediaPlayer?.apply {
                        stop()
                        release()
                    }
                    mediaPlayer = null
                }
            }

            result.success(null)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        soundPool.release()
        mediaPlayer?.release()
    }
}
