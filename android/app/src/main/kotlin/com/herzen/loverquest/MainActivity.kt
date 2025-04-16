package com.herzen.loverquest

import android.media.AudioAttributes
import android.media.MediaPlayer
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.herzen.loverquest/audio"  // questo è il nome del canale Flutter→Android

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "playAlarm") {
                playAlarmSound()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun playAlarmSound() {
        val afd = assets.openFd("audio/timer_alarm.mp3")
        val player = MediaPlayer()
        player.setDataSource(afd.fileDescriptor, afd.startOffset, afd.length)
        player.setAudioAttributes(
            AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_ALARM)
                .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                .build()
        )
        player.prepare()

        player.setVolume(1f, 1f)

        player.start()
    }
}
