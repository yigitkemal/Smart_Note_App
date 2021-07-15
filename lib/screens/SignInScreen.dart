import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_text_recognititon/homePage.dart';
import 'package:flutter_text_recognititon/screens/DashboardScreen.dart';
import 'package:flutter_text_recognititon/screens/forgotPasswordScreen.dart';
import 'package:flutter_text_recognititon/screens/signUpScreen.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/common.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:flutter_text_recognititon/utils/stringConstants.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../main.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignInScreen';

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : Colors.white,
      statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark,
      delayInMilliSeconds: 100,
    );

    if (isIos) {
      TheAppleSignIn.onCredentialRevoked!.listen((_) {
        log("Credentials revoked");
      });
    }
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.only(top: 32),
        decoration: BoxDecoration(
          gradient: appStore.isDarkMode ? LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.deepPurple]) : LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.blueGrey.withOpacity(0.4)]),
        ),
        child: Stack(
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    SignUpScreen().launch(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerRight,
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    onPrimary: Colors.white70,
                                  ),
                                  child: Text(
                                    "Sign Up",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        fontSize: 30,
                                        color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: RotatedBox(
                                quarterTurns: -1,
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 40,
                                        color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Naber,",
                                  style: GoogleFonts.montserrat(
                                   textStyle:  TextStyle(
                                       fontSize: 25,
                                       color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                                       fontFamily: "Montserrat",
                                       fontWeight: FontWeight.bold),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "seni yeniden\ngörmek güzel\nburalarda çok durma\niçeri bekliyoruz...",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      ///commonCacheImageWidget(getBoolAsync(IS_DARK_MODE, defaultValue: true) ? dark_mode_image : light_mode_image, 150, fit: BoxFit.cover),
                      ///Text(mAppName, style: boldTextStyle(size: 30)),
                      32.height,
                      AppTextField(
                        controller: emailController,
                        focus: emailNode,
                        nextFocus: passwordNode,
                        textStyle: primaryTextStyle(),
                        textFieldType: TextFieldType.EMAIL,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: appStore.isDarkMode ? Colors.white : scaffoldColorDark,
                        decoration: appTextFieldInputDeco(hint: 'Email'),
                        errorInvalidEmail: 'Enter valid email',
                        errorThisFieldRequired: errorThisFieldRequired,

                      ).paddingBottom(16),
                      AppTextField(
                        controller: passController,
                        focus: passwordNode,
                        textStyle: primaryTextStyle(),
                        textFieldType: TextFieldType.PASSWORD,
                        suffixIconColor: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                        cursorColor: appStore.isDarkMode ? Colors.white : scaffoldColorDark,
                        decoration: appTextFieldInputDeco(hint: 'Password'),
                        errorThisFieldRequired: errorThisFieldRequired,
                        onFieldSubmitted: (s) {
                          signIn();
                        },
                      ),
                      16.height,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot password?', style: primaryTextStyle(), textAlign: TextAlign.end).paddingSymmetric(vertical: 8, horizontal: 4).onTap(() {
                          ForgotPasswordScreen().launch(context);
                        }),
                      ),
                      32.height,
                      AppButton(
                        height: 60,
                        width: context.width(),
                        color: PrimaryBackgroundColor,
                        text: 'Sign In',
                        textStyle: TextStyle(color: appStore.isDarkMode ? splashBgColor : scaffoldColorDark),
                        onTap: () {
                          signIn();
                        },
                      ),
                      16.height,
                      Row(
                        children: [
                          Divider(thickness: 1, endIndent: 10, indent: 10,color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,).expand(),
                          Text(with_social_media, style: primaryTextStyle(size: 12,color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark)),
                          Divider(thickness: 1, endIndent: 10, indent: 10,color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,).expand(),
                        ],
                      ),
                      16.height,
                      IconButton(onPressed: (){
                        appStore.setLoading(true);
                        service.signInWithGoogle().then((value) async {
                          await addNotification();

                          appStore.setLoading(false);
                          Home().launch(context, isNewTask: true);
                        }).catchError((error) {
                          appStore.setLoading(false);

                          toast(error.toString());
                        });
                      }, icon: Icon(FontAwesome.google,size: 30,color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,),
                      ),
                      16.height,
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: boxDecorationRoundedWithShadow(30, backgroundColor: appStore.isDarkMode ? scaffoldColorDark : Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/ic_apple.png', width: 23, height: 23, color: appStore.isDarkMode ? white : black),
                            16.width,
                            Text(continue_with_apple, style: primaryTextStyle(size: 18)),
                          ],
                        ).center(),
                      ).onTap(() async {
                        hideKeyboard(context);

                        appStore.setLoading(true);
                        await service.appleLogIn().then((value) {
                          Home().launch(context, isNewTask: true);
                        }).catchError((e) {
                          toast(e.toString());
                        });
                        appStore.setLoading(false);
                      }).visible(isIos),
                    ],
                  ),
                ),
              ),
            ).center(),
            Observer(builder: (_) => Loader(color: appStore.isDarkMode ? scaffoldColorDark : PrimaryColor).visible(appStore.isLoading)),
          ],
        ),
      ),
    );
  }

  signIn() async {
    hideKeyboard(context);

    if (formKey.currentState!.validate()) {
      appStore.setLoading(true);
      service.signInWithEmailPassword(email: emailController.text.trim(), password: passController.text.trim()).then((value) async {
        await addNotification();

        await setValue(PASSWORD, passController.text.trim());

        appStore.setLoading(false);

        Home().launch(context, isNewTask: true);
      }).catchError((error) {
        appStore.setLoading(false);

        toast(error.toString());
      });
    }
  }

  Future<void> addNotification() async {
    await subscriptionService.getSubscription().then((value) async {
      value.forEach((element) async {
        if (element.notificationDate != null) {
          if (element.notificationDate!.isAfter(DateTime.now())) {
            await manager.showScheduleNotification(
              scheduledNotificationDateTime: element.notificationDate!,
              id: element.notificationId!,
              title: element.name,
              description: element.amount,
            );
          }
        }
      });
    }).catchError((error) {
      toast(error.toString());
    });
  }
}
