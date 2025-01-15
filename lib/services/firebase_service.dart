import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:society_management/core/app_export.dart';
// import 'package:society_management/repos/user_repo.dart';
import 'package:society_management/services/app_preferences.dart';

import '../helpers/app_helper.dart';

Future<void> _firebaseMessagingdHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class FirebaseService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _getChannel() => const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

  init() async {
    // Get Notification permission on startup
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (Platform.isAndroid) {
      // Android related permission
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_getChannel());
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      _initializeLocalNotification();
      _getToken();
      _startListeningMessages();
      setupInteractedMessage();
    }
  }

  _initializeLocalNotification() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  _getToken() {
    messaging.getToken().then((token) {
      if (token != null) {
        AppHelper.handleFirebaseToken(token);
        print("_getToken $token");
      }
    }).catchError((e) {
      print(e);
    });
  }

  _startListeningMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNofication(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingdHandler);
  }

  _showNofication(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    print("_showNofication ${message.data} ${message.notification}");
    // _handleMessage(message.data, notification: message.notification);

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      var channel = _getChannel();
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description ?? "",

              icon: '@mipmap/ic_launcher',
              // other properties...
            ),
          ),
          payload: message.data.isNotEmpty
              ? jsonEncode(message.data)
              : jsonEncode(
                  {"title": notification.title, "body": notification.body}));
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage.data);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleMessage(message.data));
  }

  void _clearNotification(int id) {
    Future.delayed(const Duration(seconds: 1))
        .then((_) => flutterLocalNotificationsPlugin.cancel(0));
  }

  void _handleMessage(Map<String, dynamic> data,
      {RemoteNotification? notification, bool? isResponse}) async {
    var user = AppPreferences.getLogin();
    if (user == null) return;
    log("_handleMessage ${jsonEncode(data)}");

    // var appttCtrl = Get.find<AppointmentController>();
    // var homeCtrl = Get.find<HomeController>();
    // var singleton = Singleton.instance;
    // switch (data["type"]) {
    //   case "sessionStarted":
    //     if (appttCtrl.isWaitingForDoctor.value) {
    //       appttCtrl.isWaitingForDoctor.value = false;
    //     }
    //     singleton.session = data;
    //     AppPreferences.setData(AppPreferences.session, {
    //       ...data,
    //       'sessionStartedAt': DateTime.now().millisecondsSinceEpoch
    //     });

    //     Get.offNamedUntil(Routers.homeScreen, (route) => false);
    //     Get.to(VideoCallingScreen());
    //     homeCtrl.ongoingSession.value = data;
    //     if (notification != null) _clearNotification(notification.hashCode);
    //     break;
    //   case "sessionFinished":
    //     AppPreferences.removeData(AppPreferences.session);
    //     if (isResponse == true) {
    //       BottomNavigationBar navigationBar =
    //           homeCtrl.bottomWidgetKey.currentWidget as BottomNavigationBar;
    //       navigationBar.onTap!(1);
    //     } else {
    //       SnackbarUtil.info(message: "Your session has been ended");
    //       Get.offNamedUntil(Routers.homeScreen, (route) => false);
    //       singleton.session = data;
    //       homeCtrl.ongoingSession.value.clear();
    //       Future.delayed(Duration(seconds: 1)).then((value) {
    //         Get.toNamed(Routers.reviewScreen);
    //         homeCtrl.ongoingSession.value.clear();
    //       });
    //     }

    //     break;
    // }
    // var body = notification?.body ?? data["body"];
    // if (body != null) {
    //   if (body.toString().toLowerCase().contains("status changed")) {
    //     homeCtrl.getUpcomingAppts();
    //     return;
    //   }
    //   RegExp regex = RegExp(r'sessionId=([^&$]+)');
    //   RegExp drRegex = RegExp(r'doctorName=([^&$]+)');
    //   var input = body;
    //   var match = regex.firstMatch(input.toString());
    //   var drMatch = drRegex.firstMatch(input.toString());

    //   if (match != null) {
    //     String? sessionId = match.group(1);
    //     var cachedSession = AppPreferences.getData(AppPreferences.session);
    //     if (notification != null) _clearNotification(notification.hashCode);
    //     if (cachedSession.isNotEmpty &&
    //         cachedSession['sessionId'] == sessionId) {
    //       Singleton.instance.session = cachedSession;
    //       homeCtrl.ongoingSession.value = cachedSession;
    //     } else {
    //       var session = {
    //         "requestedBy": AppPreferences.getUserData()!.name,
    //         "sessionId": sessionId,
    //         "doctorName": drMatch != null ? drMatch.group(1) : "Dr.",
    //         "patientName": AppPreferences.getUserData()!.name,
    //         'sessionStartedAt': DateTime.now().millisecondsSinceEpoch
    //       };
    //       AppPreferences.setData(AppPreferences.session, session);
    //       Singleton.instance.session = session;
    //       homeCtrl.ongoingSession.value = session;
    //     }

    //     Get.to(() => VideoCallingScreen());
    //     print('Session ID: $sessionId');
    //   } else {
    //     print('Session ID not found');
    //   }
    // }
  }

  onDidReceiveNotificationResponse(NotificationResponse details) {
    if (details.payload != null) {
      _handleMessage(jsonDecode(details.payload!), isResponse: true);
    }
  }
}
