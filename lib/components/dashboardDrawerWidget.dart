import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_text_recognititon/components/noteLayoutDialogWidget.dart';
import 'package:flutter_text_recognititon/homePage.dart';
import 'package:flutter_text_recognititon/screens/changeAppPasswordScreen.dart';
import 'package:flutter_text_recognititon/screens/changeMasterPasswordScreen.dart';
import 'package:flutter_text_recognititon/screens/subscriptionReminderListScreen.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/common.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:flutter_text_recognititon/utils/stringConstants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class DashboardDrawerWidget extends StatefulWidget {
  static String tag = '/DashboardDrawerWidget';

  @override
  DashboardDrawerWidgetState createState() => DashboardDrawerWidgetState();
}

class DashboardDrawerWidgetState extends State<DashboardDrawerWidget> {
  late String name;
  String? userEmail;
  String? imageUrl;

  late int crossAxisCount;
  late int fitWithCount;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    name = getStringAsync(USER_DISPLAY_NAME);
    userEmail = getStringAsync(USER_EMAIL);
    imageUrl = getStringAsync(USER_PHOTO_URL);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name, style: primaryTextStyle(size: 18), overflow: TextOverflow.ellipsis),
              accountEmail: Text(userEmail.validate(), style: secondaryTextStyle(size: 14), overflow: TextOverflow.ellipsis),
              currentAccountPicture: commonCacheImageWidget(imageUrl, imageRadius, fit: BoxFit.cover).cornerRadiusWithClipRRect(60).paddingBottom(8),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: scaffoldSecondaryDark))),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Row(
                    children: [
                      appStore.isDarkMode ? Icon(Icons.brightness_2) : Icon(Icons.wb_sunny_rounded),
                      16.width,
                      Text(dark_mode, style: primaryTextStyle(size: 14)).expand(),
                      Switch(
                        value: appStore.isDarkMode,
                        activeTrackColor: scaffoldSecondaryDark,
                        inactiveThumbColor: scaffoldColorDark,
                        inactiveTrackColor: scaffoldSecondaryDark,
                        onChanged: (val) async {
                          appStore.setDarkMode(val);
                          await setValue(IS_DARK_MODE, val);
                        },
                      ),
                    ],
                  ).paddingOnly(left: 16, top: 4, right: 16, bottom: 4).onTap(() async {
                    if (getBoolAsync(IS_DARK_MODE)) {
                      appStore.setDarkMode(false);
                      await setValue(IS_DARK_MODE, false);
                    } else {
                      appStore.setDarkMode(true);
                      await setValue(IS_DARK_MODE, true);
                    }
                    finish(context);
                    Home().launch(context);
                  }),
                  Row(
                    children: [
                      Icon(Icons.notifications_active_outlined),
                      16.width,
                      Text(sub_reminder, style: primaryTextStyle(size: 14)).expand(),
                    ],
                  ).paddingAll(16).onTap(() {
                    finish(context);
                    SubscriptionReminderListScreen().launch(context);
                  }),
                  Row(
                    children: [
                      Icon(Icons.lock_outline_rounded),
                      16.width,
                      Text(change_app_pwd, style: primaryTextStyle(size: 14)).expand(),
                    ],
                  ).paddingAll(16).onTap(() {
                    finish(context);
                    ChangeAppPasswordScreen().launch(context);
                  }).visible(getStringAsync(LOGIN_TYPE) == LoginTypeApp),
                  Row(
                    children: [
                      getLayoutTypeIcon(),
                      16.width,
                      Text(change_screen_note_oriantation, style: primaryTextStyle(size: 14)).expand(),
                    ],
                  ).paddingAll(16).onTap(() {
                    noteLayoutDialog();
                  }),
                  Row(
                    children: [
                      Icon(Icons.lock_outline_rounded),
                      16.width,
                      Text(change_master_pwd, style: primaryTextStyle(size: 14)).expand(),
                    ],
                  ).paddingAll(16).onTap(() {
                    finish(context);
                    ChangeMasterPasswordScreen().launch(context);
                  }),
                  Row(
                    children: [
                      Icon(Icons.logout),
                      16.width,
                      Text(sign_out, style: primaryTextStyle(size: 14)).expand(),
                    ],
                  ).paddingAll(16).onTap(() async {
                    bool? res = await showConfirmDialog(context, sign_out_text, positiveText: sign_out, buttonColor: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark);
                    if (res ?? false) {
                      service.signOutFromEmailPassword(context);
                    }
                  }),
                ],
              ),
            ).expand(),
          ],
        ),
      ),
    );
  }


  noteLayoutDialog() {
    return showInDialog(
      context,
      contentPadding: EdgeInsets.zero,
      titleTextStyle: primaryTextStyle(size: 20),
      title: Text(select_layout).paddingBottom(16),
      child: NoteLayoutDialogWidget(onLayoutSelect: (fitCount, crossCount) async {
        await setValue(FIT_COUNT, fitCount);
        await setValue(CROSS_COUNT, crossCount);
        setState(() {
          fitWithCount = fitCount;
          crossAxisCount = crossCount;
        });
      }),
    );
  }

}
