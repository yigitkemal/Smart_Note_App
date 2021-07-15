import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_text_recognititon/AppTheme.dart';
import 'package:flutter_text_recognititon/screens/DashboardScreen.dart';
import 'package:flutter_text_recognititon/screens/splashScreen.dart';
import 'package:flutter_text_recognititon/services/authService.dart';
import 'package:flutter_text_recognititon/services/notesService.dart';
import 'package:flutter_text_recognititon/services/notificationManager.dart';
import 'package:flutter_text_recognititon/services/subscriptionServices.dart';
import 'package:flutter_text_recognititon/services/userDBService.dart';
import 'package:flutter_text_recognititon/store/AppStore.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'homePage.dart';

import 'package:timezone/data/latest.dart' as tz;

AppStore appStore = AppStore();

FirebaseFirestore db = FirebaseFirestore.instance;

int adShowCount = 0;

AuthService service = AuthService();
UserDBService userDBService = UserDBService();
NotesServices notesService = NotesServices();
SubscriptionService subscriptionService = SubscriptionService();
NotificationManager manager = NotificationManager();
UserDBService userService = UserDBService();

//camera alanım için gerekli
List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  defaultRadius = 8.0;
  defaultAppButtonRadius = 30.0;

  await initialize();

  await Firebase.initializeApp().then((value) {
    MobileAds.instance.initialize();
  });
  tz.initializeTimeZones();

  if (getBoolAsync(IS_DARK_MODE, defaultValue: false)) {
    appStore.setDarkMode(true);
  } else {
    appStore.setDarkMode(false);
  }

  appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: mAppName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        builder: scrollBehaviour(),
      ),
    );
  }
}


