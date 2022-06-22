package net.ldcealumni

import android.app.Activity
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.systemchannels.SettingsChannel.CHANNEL_NAME
import io.flutter.plugin.common.MethodChannel

class NotificationTapActivity : FlutterActivity() {
    private lateinit var methodChannel: MethodChannel
    private  val CHANNEL_NAME = "LDCE_NOTIFICATION"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        getActionBar()!!.hide()


        methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL_NAME)
        val mresult = methodChannel.invokeMethod("testMethod","", )
        Log.d("NotificationTapActivity","NotificationTapActivityNotificationTapActivity")
    }
}