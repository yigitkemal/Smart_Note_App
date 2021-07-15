import 'package:flutter/material.dart';
import 'package:flutter_text_recognititon/homePage.dart';
import 'package:flutter_text_recognititon/main.dart';
import 'package:flutter_text_recognititon/screens/DashboardScreen.dart';
import 'package:flutter_text_recognititon/screens/SignInScreen.dart';
import 'package:flutter_text_recognititon/screens/walkThroughScreen.dart';
import 'package:flutter_text_recognititon/utils/Colors.dart';
import 'package:flutter_text_recognititon/utils/Common.dart';
import 'package:flutter_text_recognititon/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : PrimaryColor,
      statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark,
      delayInMilliSeconds: 100,
    );
    await Future.delayed(Duration(seconds: 1));
    if (getBoolAsync(IS_FIRST_TIME, defaultValue: true)) {
      WalkThroughScreen().launch(context, isNewTask: true);
    } else if (appStore.isLoggedIn.validate()) {
      Home().launch(context, isNewTask: true);
    } else {
      SignInScreen().launch(context, isNewTask: true);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : PrimaryBackgroundColor,
      statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark,
      delayInMilliSeconds: 100,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkMode ? scaffoldColorDark : PrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          commonCacheImageWidget(getBoolAsync(IS_DARK_MODE, defaultValue: false) ? dark_mode_image : light_mode_image, 150, fit: BoxFit.cover),
          Text(mAppName, style: boldTextStyle(size: 32)),
        ],
      ).center(),
    );
  }
}
