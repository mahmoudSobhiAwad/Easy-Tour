import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';

class NotificationSetup{
  final FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;
  Future<bool>checkAllowingNotify()async{
    bool allowed=false;
    await AwesomeNotifications().isNotificationAllowed().then((allowed){
      if(!allowed){
        allowed= false;
      }
      else{
        allowed=true;
      }
    });
    return allowed;
  }
  Future<void>configurePushNotification()async{
    checkAllowingNotify();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage((message)async {
      return await myBackGroundMessageHandler(message);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      if(message.notification !=null){
        NotificationSetup().createOrderNotification(message.notification?.title, message.notification?.body, requestNotificationChannel);
      }
    });
  }
  Future<void>initAwesomeNotification()async{
   await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: requestNotificationChannel,
              channelName: 'Request Trip',
              channelDescription: 'Notification channel for basic tests',
              importance: NotificationImportance.Max,
              vibrationPattern: highVibrationPattern,
              defaultColor:const Color(0xFF9D50DD),
              ledColor:const Color(0xffffffff),
          ),
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: chatNotificationChannel,
            channelName: 'chat notification',
            channelDescription: 'Notification channel for basic tests',
            importance: NotificationImportance.Max,
            vibrationPattern: highVibrationPattern,
            defaultColor:const Color(0xFF9D50DD),
            ledColor:const Color(0xffffffff),
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true
    );
  }
  Future<void>createOrderNotification(final String?title,final String? body,final String channelKey)async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(id: 10, channelKey: channelKey,title: title,body:body),
    );
  }
}
@pragma("vm:entry-point")
Future<dynamic>myBackGroundMessageHandler(RemoteMessage message)async{
  await Firebase.initializeApp();}