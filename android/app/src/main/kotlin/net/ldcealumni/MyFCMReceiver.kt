package net.ldcealumni

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.graphics.Color
import android.os.Build
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat


import android.util.Log
import android.content.BroadcastReceiver


import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition


class MyFCMReceiver : BroadcastReceiver() {
 
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: My FCM Broadcast Received")
        val title: String? = intent.getExtras()?.getString("title")
        val myId: String? = intent.getExtras()?.getString("id")
        val myType: String? = intent.getExtras()?.getString("type")
        val coverPhoto: String? = intent.getExtras()?.getString("image")
        val senderId: String? = intent.getExtras()?.getString("google.c.sender.id")
        Log.d("FCM Title", ""+title)
        Log.d("FCM id", ""+myId)
        Log.d("FCM type", ""+myType)
        Log.d("FCM image", ""+coverPhoto)
        val hashMap : HashMap<String,String?> = HashMap<String,String?> ()
        hashMap.put("title",title)
        hashMap.put("coverPhoto",coverPhoto)
        if(senderId == "511004081607"){
        Log.d("Collapse Key", "Matches")
       
        showCustomNotification(context,hashMap)

        }
        // Toast.makeText(context, "Broadcast Intent Detected.",
        //         Toast.LENGTH_LONG).show()
    }

    private fun showCustomNotification(context: Context,args: HashMap<*, *>):String {
        val myIntent = Intent()
        myIntent.action = "net.ldalumni.NOTIFICATION"
        // myIntent.flags = Intent.FLAG_INCLUDE_STOPPED_PACKAGES
        Log.d("Title Main",args["title"].toString())
        myIntent.putExtra("title", args["title"].toString())
        // context.sendBroadcast(myIntent)


        val notificationLayout = RemoteViews(context.packageName, R.layout.notification_large)


        //Set TextView Value
        // notificationLayout.setTextViewText(R.id.name_view, args["name"].toString())
        notificationLayout.setTextViewText(R.id.tv_notification_msg, args["title"].toString())
        // notificationLayout.setTextViewText(R.id.gender_view, args["gender"].toString())
        // notificationLayout.setTextViewText(R.id.time_view, args["current_time"].toString())

        //Set a click listener for the flutter logo
        val pendingIntent = PendingIntent.getBroadcast(context, 0, myIntent, PendingIntent.FLAG_CANCEL_CURRENT)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
            notificationLayout.setOnClickPendingIntent(R.id.iv_notification_logo, pendingIntent)
        }


        //val notificationLayoutExpanded = RemoteViews(packageName, R.layout.notification_large)

        val notificationManager: NotificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        lateinit var notificationChannel: NotificationChannel
        lateinit var builder: NotificationCompat.Builder
        val channelId = "i.apps.custom.notification"
        val description = "General Notification"


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            notificationChannel = NotificationChannel(channelId, description, NotificationManager.IMPORTANCE_HIGH)
            notificationChannel.enableLights(true)
            notificationChannel.lightColor = Color.GREEN
            notificationChannel.enableVibration(false)

            notificationManager.createNotificationChannel(notificationChannel)
            builder = NotificationCompat.Builder(context, channelId)
                    .setCustomContentView(notificationLayout)
                    .setCustomHeadsUpContentView(notificationLayout)
                    .setLargeIcon(BitmapFactory.decodeResource(context.resources, R.mipmap.ic_launcher))

                    // .setStyle(NotificationCompat.BigPictureStyle()
                    // .bigPicture(BitmapFactory.decodeResource(this.resources, R.mipmap.ic_launcher))
                    // .bigLargeIcon(null))
                    // .setCustomBigContentView(notificationExpandedLayout)
                    .setSmallIcon(R.drawable.ic_notification)
                    .setContentIntent(pendingIntent)

//                   ?  val futureTarget = Glide.with(this)
//         .asBitmap()
//         .load("https://www.ldcealumni.net/Content/News/Cover/1-02052022102857.png")
//         .submit()

// val bitmap = futureTarget.get()
// builder.setLargeIcon(bitmap)

// Glide.with(this).clear(futureTarget)
            // GlideApp.with(context)
            //         .asBitmap()
            //         .load(args["coverPhoto"].toString())
            //         .into(object : CustomTarget<Bitmap>() {
            //             override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
            //                 builder.setLargeIcon(resource)
            //                 builder.setStyle(NotificationCompat.BigPictureStyle().bigPicture(resource).bigLargeIcon(null))
            //                 val notification = builder.build()
            //                 Log.d("GLIDE","GLIDE DONE")
            //                  notificationManager.notify(1234, notification)
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
            val imageUrl = "https://www.ldcealumni.net/Content/News/Cover/1-02052022102857.png"

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
            builder = NotificationCompat.Builder(context)
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
