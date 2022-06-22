package net.ldcealumni

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.*
import android.graphics.BitmapFactory
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import android.util.Log
import android.view.View


import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition

class MainActivity: FlutterActivity() {
    private val channel = "flutter.native/helper"
    private val myChannel = "LDCE_NOTIFICATION"
    private lateinit var methodChannel: MethodChannel
    private lateinit var methodChannel1: MethodChannel
    var receiver: BroadcastReceiver? = null
    var receiver2: BroadcastReceiver? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        Log.d("TAG", "Oncreat: My Corea Received")
        methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, channel)
        methodChannel1 = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, myChannel)
        methodChannel.invokeMethod("testMethod","")
        methodChannel.setMethodCallHandler { call, result ->

            // check Invoked method name that was requested from main.dart file and response to it.
            when {

                call.method.equals("showCustomNotificationFromNative") -> {

                    val args = call.arguments as HashMap<*, *>

                    val greetings = showCustomNotification(args)
                    result.success(greetings)

                }
            }

        }
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, myChannel).setMethodCallHandler { call, result ->

            // check Invoked method name that was requested from main.dart file and response to it.
            when {

                call.method.equals("showCustomNotificationFromNative") -> {

                    val args = call.arguments as HashMap<*, *>

                    val greetings = showCustomNotification(args)
                    result.success(greetings)

                }
            }

        }
//        configureReceiver()
}

    override fun onPause() {
        super.onPause()
        Log.d("MainActivity","onPause")
        methodChannel1.invokeMethod("testMethod","")
    }

    override fun onStop() {
        super.onStop()
        Log.d("MainActivity","onStop")
//        val intent = Intent(context, MyBrodcastRecieverService::class.java)
        if (context != null) {
//            context.startService(intent)
//            Log.d("OnStop", "Main SERVICE STARTED")
//            unregisterReceiver(receiver)
//            unregisterReceiver(receiver2)
        }

    }
    override fun onDestroy() {
        super.onDestroy()
//         unregisterReceiver(receiver)
//         unregisterReceiver(receiver2)
        // to start a service
// Intent service = new Intent(context, MyBrodcastRecieverService.class);
// context.startService(service);
 val intent = Intent(context, MyBrodcastRecieverService::class.java)
 if (context != null) {
//      context.startService(intent)
     Log.d("onDestrop", "Main SERVICE STARTED")

 }
        Log.d("onDestrop", " Main SERVICE STARTED")

    }
    private fun configureReceiver() {
        val filter = IntentFilter()
        filter.addAction("net.ldalumni.NOTIFICATION")
        // receiver = MyReceiver()
        // registerReceiver(receiver, filter)
        val filter2 = IntentFilter()
        filter2.addAction("com.google.android.c2dm.intent.RECEIVE")
        receiver2 = MyFCMReceiver()
        registerReceiver(receiver2, filter2)
    }
    private fun showCustomNotification(args: HashMap<*, *>):String {
        val myIntent = Intent()
        myIntent.action = "net.ldalumni.NOTIFICATION"
        // myIntent.flags = Intent.FLAG_INCLUDE_STOPPED_PACKAGES
        Log.d("Title Main",args["title"].toString())
        myIntent.putExtra("title", args["title"].toString());
//        sendBroadcast(myIntent)
        methodChannel1.invokeMethod("testMethod","")
        val notificationLayout = RemoteViews(packageName, R.layout.notification_large)


        //Set TextView Value
        // notificationLayout.setTextViewText(R.id.name_view, args["name"].toString())
        notificationLayout.setTextViewText(R.id.tv_notification_msg, args["title"].toString())
        // notificationLayout.setTextViewText(R.id.gender_view, args["gender"].toString())
        // notificationLayout.setTextViewText(R.id.time_view, args["current_time"].toString())

        //Set a click listener for the flutter logo
        val pendingIntent = PendingIntent.getBroadcast(this, 0, myIntent, PendingIntent.FLAG_UPDATE_CURRENT)
        notificationLayout.setOnClickPendingIntent(R.id.iv_notification_logo, pendingIntent)


        //val notificationLayoutExpanded = RemoteViews(packageName, R.layout.notification_large)

        val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        lateinit var notificationChannel: NotificationChannel
        lateinit var builder: NotificationCompat.Builder
        val channelId = "i.apps.custom.notification"
        val description = "Custom Notification"


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            notificationChannel = NotificationChannel(channelId, description, NotificationManager.IMPORTANCE_HIGH)
            notificationChannel.enableLights(true)
            notificationChannel.lightColor = Color.GREEN
            notificationChannel.enableVibration(false)

            notificationManager.createNotificationChannel(notificationChannel)
            builder = NotificationCompat.Builder(this, channelId)
                    .setCustomContentView(notificationLayout)
                    .setCustomHeadsUpContentView(notificationLayout)
                    .setLargeIcon(BitmapFactory.decodeResource(this.resources, R.mipmap.ic_launcher))
                    // .setStyle(NotificationCompat.BigPictureStyle()
                    // .bigPicture(BitmapFactory.decodeResource(this.resources, R.mipmap.ic_launcher))
                    // .bigLargeIcon(null))
                    // .setCustomBigContentView(notificationExpandedLayout)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentIntent(pendingIntent)
//                   ?  val futureTarget = Glide.with(this)
//         .asBitmap()
//         .load("https://www.ldcealumni.net/Content/News/Cover/1-02052022102857.png")
//         .submit()

// val bitmap = futureTarget.get()
// builder.setLargeIcon(bitmap)

// Glide.with(this).clear(futureTarget)
            // GlideApp.with(applicationContext)
            //         .asBitmap()
            //         .load(args["coverPhoto"].toString())
            //         .into(object : CustomTarget<Bitmap>() {
            //             override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
            //                 builder.setLargeIcon(resource)
            //                 builder.setStyle(NotificationCompat.BigPictureStyle().bigPicture(resource).bigLargeIcon(null))
            //                 val notification = builder.build()
            //                 notificationManager.notify(1234, notification)
            //             }

            //             override fun onLoadCleared(placeholder: Drawable?) {

            //             }
            //         })

// val futureTarget = Glide.with(this)
//         .asBitmap()
//         .load( args["coverPhoto"].toString())
//         .submit()
// val bitmap = futureTarget.get()
// builder.setStyle(NotificationCompat.BigPictureStyle().bigPicture(bitmap).bigLargeIcon(null))
// builder.setLargeIcon(bitmap)
// Glide.with(this).clear(futureTarget)
            // val imageUrl = "https://www.ldcealumni.net/Content/News/Cover/1-02052022102857.png"

// Glide.with(applicationContext)
//     .asBitmap()
//     .load(imageUrl)
//     .into(object : CustomTarget<Bitmap>() {
//          fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
//             builder.setLargeIcon(resource)
//             val notification = builder.build()
//             notificationManager.notify(1234, notification)
//         }


//     })
        } else {

            //Builder class & setContent is deprecated. I will Fix it later.
            builder = NotificationCompat.Builder(this)
                    .setContent(notificationLayout)
                    //.setCustomBigContentView(notificationLayoutExpanded)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setPriority(Notification.PRIORITY_MAX)
            //.setContentIntent(pendingIntent)
        }

        // notificationManager.notify(1234, builder.build())

        return "Success"

    }
}
