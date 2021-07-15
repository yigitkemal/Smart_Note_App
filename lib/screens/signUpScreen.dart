import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_text_recognititon/homePage.dart';
import 'package:flutter_text_recognititon/screens/DashboardScreen.dart';
import 'package:flutter_text_recognititon/screens/SignInScreen.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/common.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:flutter_text_recognititon/utils/stringConstants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class SignUpScreen extends StatefulWidget {
  static String tag = '/SignUpScreen';

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  FocusNode usernameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passNode = FocusNode();
  FocusNode confPassNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
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
                key: formState,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
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
                                    SignInScreen().launch(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerRight,
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    onPrimary: Colors.white70,
                                  ),
                                  child: Text(
                                    "Sign In",
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
                                  "Sign Up",
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
                                  "Hoşgeldin,",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "farklı bir deneyime\nhazır değilsen\nuygulamayı kapatıp\nsilebilirsin...",
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
                      ///Text('Create Account', style: boldTextStyle(size: 30)),
                      30.height,
                      AppTextField(
                        autoFocus: true,
                        controller: usernameController,
                        focus: usernameNode,
                        nextFocus: emailNode,
                        textFieldType: TextFieldType.NAME,
                        textCapitalization: TextCapitalization.none,
                        textStyle: primaryTextStyle(),
                        keyboardType: TextInputType.text,
                        cursorColor: appStore.isDarkMode
                            ? Colors.white
                            : scaffoldColorDark,
                        decoration: appTextFieldInputDeco(hint: 'Username'),
                        errorInvalidEmail: 'Enter valid email',
                      ),
                      16.height,
                      AppTextField(
                        controller: emailController,
                        focus: emailNode,
                        nextFocus: passNode,
                        textFieldType: TextFieldType.EMAIL,
                        textCapitalization: TextCapitalization.none,
                        textStyle: primaryTextStyle(),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: appStore.isDarkMode
                            ? Colors.white
                            : scaffoldColorDark,
                        decoration: appTextFieldInputDeco(hint: 'Email'),
                        errorInvalidEmail: 'Enter valid email',
                        errorThisFieldRequired: errorThisFieldRequired,
                      ),
                      16.height,
                      AppTextField(
                        controller: passController,
                        focus: passNode,
                        nextFocus: confPassNode,
                        textFieldType: TextFieldType.PASSWORD,
                        textStyle: primaryTextStyle(),
                        suffixIconColor: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                        cursorColor: appStore.isDarkMode
                            ? Colors.white
                            : scaffoldColorDark,
                        decoration: appTextFieldInputDeco(hint: 'Password'),
                        errorThisFieldRequired: errorThisFieldRequired,
                      ),
                      16.height,
                      AppTextField(
                        controller: confirmController,
                        focus: confPassNode,
                        textFieldType: TextFieldType.PASSWORD,
                        textStyle: primaryTextStyle(),
                        suffixIconColor: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                        cursorColor: appStore.isDarkMode
                            ? Colors.white
                            : scaffoldColorDark,
                        decoration:
                            appTextFieldInputDeco(hint: 'Confirm Password'),
                        errorThisFieldRequired: errorThisFieldRequired,
                        onFieldSubmitted: (s) {
                          signUp();
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty)
                            return errorThisFieldRequired;
                          if (value.trim().length < passwordLengthGlobal)
                            return 'Minimum password length should be $passwordLengthGlobal';
                          return passController.text == value.trim()
                              ? null
                              : pwd_not_match;
                        },
                      ),
                      32.height,
                      AppButton(
                        height: 60,
                        width: context.width(),
                        color: PrimaryBackgroundColor,
                        text: 'Sign Up',
                        textColor: appStore.isDarkMode ? splashBgColor : scaffoldColorDark,
                        onTap: () {
                          signUp();
                        },
                      ),
                    ],
                  ),
                ),
              ).center(),
              IconButton(
                icon: Icon(Icons.arrow_back,color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,),
                onPressed: () {
                  finish(context);
                },
              ),
              Observer(
                  builder: (_) => Loader(
                          color: appStore.isDarkMode
                              ? scaffoldColorDark
                              : PrimaryColor)
                      .visible(appStore.isLoading)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (formState.currentState!.validate()) {
      appStore.setLoading(true);

      await service
          .signUpWithEmailPassword(
              email: emailController.text.trim(),
              password: passController.text.trim(),
              displayName: usernameController.text.trim())
          .then((value) async {
        appStore.setLoading(false);

        await setValue(PASSWORD, passController.text.trim());

        Home().launch(context, isNewTask: true);
      }).catchError((error) {
        appStore.setLoading(false);

        toast(error);
      });
    }
  }
}
