package net.ldcealumni

import android.app.Service
import android.content.*
import android.content.ContentValues.TAG
import android.os.IBinder
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MyBrodcastRecieverService : Service() {
    var br_ScreenOffReceiver: BroadcastReceiver? = null
    var receiver2: BroadcastReceiver? = null
    private val myChannel = "LDCE_NOTIFICATION"
    private lateinit var methodChannel: MethodChannel
    private lateinit var engine: FlutterEngine


    override fun onBind(arg0: Intent?): IBinder? {
        return null
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        engine = FlutterEngine(applicationContext)

        Log.d("onStartCommand", "SERVICE STARTED")
        methodChannel = MethodChannel(engine!!.dartExecutor.binaryMessenger, myChannel)

        val filter2 = IntentFilter()
        filter2.addAction("net.ldalumni.NOTIFICATION")
        // receiver2 = MyReceiver()
        // registerReceiver(receiver2, filter2)
        methodChannel.setMethodCallHandler { call, result ->

            // check Invoked method name that was requested from main.dart file and response to it.
            when {

                call.method.equals("testMethodFromFlutter") -> {

                    val args = call.arguments as HashMap<*, *>
                    Log.d("testMethodFromFlutter","It Works!")
                    Log.d("testMethod DATA",call.arguments.toString())
//                    val greetings = showCustomNotification(args)
                    result.success(1)

                }
            }

        }
        return START_STICKY
    }
    override  fun onCreate() {
        Log.d("Service OnCreate", "SERVICE STARTED")

//        registerScreenOffReceiver()
    }

    override  fun onDestroy() {
        unregisterReceiver(receiver2)
        receiver2 = null
    }


}
