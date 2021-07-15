import 'package:flutter/material.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/common.dart';
import 'package:flutter_text_recognititon/utils/stringConstants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String tag = '/ForgotPasswordScreen';

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotEmailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(forgot_pwd),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You forgot your password?', style: boldTextStyle(size: 22)),
                4.height,
                Text('Enter your email address. We will send you and email to reset your password.', style: primaryTextStyle(size: 14)),
                16.height,
                AppTextField(
                  controller: forgotEmailController,
                  textFieldType: TextFieldType.EMAIL,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: appStore.isDarkMode ? Colors.white : scaffoldColorDark,
                  decoration: appTextFieldInputDeco(hint: 'Email'),
                  errorInvalidEmail: 'Enter valid email',
                  errorThisFieldRequired: errorThisFieldRequired,
                ),
                16.height,
                AppButton(
                  child: Text(reset_pwd, style: boldTextStyle(color: appStore.isDarkMode ? scaffoldColorDark : Colors.white)),
                  color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                  width: context.width(),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      service.forgotPassword(email: forgotEmailController.text.trim()).then((value) {
                        toast('Reset password link has sent your mail');
                        finish(context);
                      }).catchError((error) {
                        toast(error.toString());
                      });
                    }
                  },
                ),
              ],
            ),
          ).center(),
        ),
      ),
    );
  }
}
