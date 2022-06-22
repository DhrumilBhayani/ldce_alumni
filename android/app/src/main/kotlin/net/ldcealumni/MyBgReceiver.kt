package net.ldcealumni

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.widget.Toast
import android.util.Log
import android.content.IntentFilter
import io.flutter.plugins.GeneratedPluginRegistrant


class MyBgReceiver : BroadcastReceiver() {
 
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: My Broadcast Received")
        val title: String? = intent.getExtras()?.getString("title")
        Log.d("My Broadcast Title", ""+title)
//        private val CHANNEL = "amazon"
//
//        var methodResult: MethodChannel.Result? = null
//        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//            GeneratedPluginRegistrant.registerWith(flutterEngine);
//            val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
//
//            channel.setMethodCallHandler { call, result ->
//                methodResult = result
//                if (call.method == "s3_upload") {
//                    //Add you login here
//                    channel.invokeMethod("callBack", "data1")
//
//
//
//                }
//            }

        // Toast.makeText(context, "Broadcast Intent Detected.",
        //         Toast.LENGTH_LONG).show()
//    }
}}
