import 'package:flutter/material.dart';
import 'package:flutter_text_recognititon/model/walkthroughModel.dart';
import 'package:flutter_text_recognititon/screens/SignInScreen.dart';
import 'package:flutter_text_recognititon/utils/Colors.dart';
import 'package:flutter_text_recognititon/utils/Common.dart';
import 'package:flutter_text_recognititon/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

class WalkThroughScreen extends StatefulWidget {
  static String tag = '/WalkThroughScreen';

  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  PageController pageController = PageController();

  List<WalkThroughModel> list = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    list.add(WalkThroughModel(title: 'Manage Everything\non Phone', image: walkThrough1));
    list.add(WalkThroughModel(title: 'Focus on\nwhat matter most', image: walkThrough2));
    list.add(WalkThroughModel(title: 'List out\nyour workflow', image: walkThrough4));
    list.add(WalkThroughModel(title: 'Add reminders\nto help on your busy schedule', image: walkThrough3));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            controller: pageController,
            children: list.map((e) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonCacheImageWidget(e.image, 200, fit: BoxFit.cover),
                    16.height,
                    Text(e.title!, style: boldTextStyle(size: 18), textAlign: TextAlign.center),
                  ],
                ),
              ).center().paddingBottom(100);
            }).toList(),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text('skip', style: primaryTextStyle()),
                  decoration: boxDecorationRoundedWithShadow(30, backgroundColor: PrimaryColor),
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                ).onTap(() async {
                  await setValue(IS_FIRST_TIME, false);

                  SignInScreen().launch(context, isNewTask: true);
                }),
                DotIndicator(
                  pageController: pageController,
                  pages: list,
                  unselectedIndicatorColor: PrimaryColor,
                  indicatorColor: scaffoldColorDark,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
                Container(
                  child: Text(currentPage != 3 ? 'next' : 'finish', style: primaryTextStyle()),
                  decoration: boxDecorationRoundedWithShadow(30, backgroundColor: PrimaryColor),
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                ).onTap(() async {
                  if (currentPage == 3) {
                    await setValue(IS_FIRST_TIME, false);

                    SignInScreen().launch(context, isNewTask: true);
                  } else {
                    pageController.animateToPage(currentPage + 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                  }
                }),
              ],
            ).paddingOnly(left: 16, right: 16),
          )
        ],
      ),
    );
  }
}
