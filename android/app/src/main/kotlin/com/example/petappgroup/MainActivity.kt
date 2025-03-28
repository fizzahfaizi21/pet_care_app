package com.example.petappgroup

import androidx.core.app.NotificationChannelCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        val channel = NotificationChannelCompat.Builder(
            "pet_reminders_channel",
            NotificationManagerCompat.IMPORTANCE_HIGH
        ).apply {
            setName("Pet Reminders")
            setDescription("Channel for pet care reminders")
            setVibrationPattern(longArrayOf(0, 250, 250, 250))
            setLightsEnabled(true)
            setLightColor(0xFF42A5F5)
            setImportance(NotificationManagerCompat.IMPORTANCE_HIGH)
            setShowBadge(true)
        }.build()

        NotificationManagerCompat.from(this).createNotificationChannel(channel)
    }
}