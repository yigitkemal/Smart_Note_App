import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/common.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:flutter_text_recognititon/utils/stringConstants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class ChangeAppPasswordScreen extends StatefulWidget {
  static String tag = '/ChangeAppPasswordScreen';

  @override
  ChangeAppPasswordScreenState createState() => ChangeAppPasswordScreenState();
}

class ChangeAppPasswordScreenState extends State<ChangeAppPasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController currentPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();

  FocusNode currentNode = FocusNode();
  FocusNode newPwdNode = FocusNode();
  FocusNode confirmPwdNode = FocusNode();

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
        title: Text(reset_pwd),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                        controller: currentPwdController,
                        focus: currentNode,
                        nextFocus: newPwdNode,
                        textFieldType: TextFieldType.PASSWORD,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        cursorColor: appStore.isDarkMode ? Colors.white : scaffoldColorDark,
                        decoration: appTextFieldInputDeco(hint: 'Current password'),
                        errorThisFieldRequired: errorThisFieldRequired,
                        validator: (val) {
                          if (val!.trim() != getStringAsync(PASSWORD)) {
                            return current_pwd_invalid;
                          }
                          return null;
                        }),
                    16.height,
                    AppTextField(
                      controller: newPwdController,
                      focus: newPwdNode,
                      nextFocus: confirmPwdNode,
                      textFieldType: TextFieldType.PASSWORD,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      cursorColor: appStore.isDarkMode ? Colors.white : scaffoldColorDark,
                      decoration: appTextFieldInputDeco(hint: new_pwd),
                      errorThisFieldRequired: errorThisFieldRequired,
                    ),
                    16.height,
                    AppTextField(
                      controller: confirmPwdController,
                      focus: confirmPwdNode,
                      textFieldType: TextFieldType.PASSWORD,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      cursorColor: appStore.isDarkMode ? Colors.white : scaffoldColorDark,
                      decoration: appTextFieldInputDeco(hint: confirm_pwd),
                      errorThisFieldRequired: errorThisFieldRequired,
                      validator: (value) {
                        if (value!.trim().isEmpty) return errorThisFieldRequired;
                        if (value.trim().length < passwordLengthGlobal) return 'Minimum password length should be $passwordLengthGlobal';
                        return newPwdController.text == value.trim() ? null : pwd_not_match;
                      },
                      onFieldSubmitted: (val) {
                        resetPassword();
                      },
                    ),
                    16.height,
                    AppButton(
                      child: Text(change_pwd, style: boldTextStyle(color: appStore.isDarkMode ? scaffoldColorDark : Colors.white)),
                      color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark,
                      width: context.width(),
                      onTap: () {
                        resetPassword();
                      },
                    ),
                  ],
                ),
              ).center(),
            ),
          ),
          Observer(builder: (_) => Loader(color: appStore.isDarkMode ? PrimaryColor : scaffoldColorDark).visible(appStore.isLoading)),
        ],
      ),
    );
  }

  void resetPassword() {
    if (_formKey.currentState!.validate()) {
      appStore.setLoading(true);

      service.resetPassword(newPassword: newPwdController.text.trim()).then((value) async {
        appStore.setLoading(false);

        await setValue(PASSWORD, newPwdController.text.trim());

        finish(context);
        toast(pwd_change_successfully);
      }).catchError((error) {
        appStore.setLoading(false);
        log(error.toString());
        toast(errorSomethingWentWrong);
      });
    }
  }
}
