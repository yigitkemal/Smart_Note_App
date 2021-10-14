import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_text_recognititon/DetectorView/textDetectorView.dart';
import 'package:flutter_text_recognititon/components/dashboardDrawerWidget.dart';
import 'package:flutter_text_recognititon/components/filterNoteByColorDialogWidget.dart';
import 'package:flutter_text_recognititon/components/lockNoteDialogWidget.dart';
import 'package:flutter_text_recognititon/components/noteLayoutDialogWidget.dart';
import 'package:flutter_text_recognititon/components/setMasterPasswordDialogWidget.dart';
import 'package:flutter_text_recognititon/main.dart';
import 'package:flutter_text_recognititon/model/notesModel.dart';
import 'package:flutter_text_recognititon/screens/addNotesScreen.dart';
import 'package:flutter_text_recognititon/screens/addToDoScreen.dart';
import 'package:flutter_text_recognititon/store/AppStore.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/colors.dart';
import 'package:flutter_text_recognititon/utils/common.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:flutter_text_recognititon/utils/stringConstants.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController searchedTextController = new TextEditingController();

  String colorFilter = '';
  String searchedText = '';

  late int crossAxisCount;
  late int fitWithCount;

  int _selectedIndex = 0;
  static const TextStyle optionstyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0 : Home',
      style: optionstyle,
    ),
    Text(
      'Index 1 : Notes',
      style: optionstyle,
    ),
    Text(
      'Index 3 : Profil',
      style: optionstyle,
    ),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    fitWithCount = getIntAsync(FIT_COUNT, defaultValue: 1);
    crossAxisCount = getIntAsync(CROSS_COUNT, defaultValue: 2);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  title: Container(
                      child: Text(mAppName,style: TextStyle(fontSize: 24,),)),
                 /* actions: [
                    /*IconButton(
                      icon: Icon(
                        Icons.color_lens_outlined,
                      ),
                      onPressed: () {
                          filterByColor();
                      },
                    ),*/
                    ElevatedButton(
                      child: CircleAvatar(
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage('images/profilepic.png')),
                        backgroundColor: Colors.white70,
                        radius: 22,
                      ),
                      onPressed: () {
                        /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Profile()));*/
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        onPrimary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    ),
                  ],*/
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height/6,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: appStore.isDarkMode ? scaffoldColorDark : scaffoldLightColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)) ,
                     //appbar gradienti uygulamanın koyu ve açık modlarına geçişte düzgün olarak çalışmıyor.
                     /*gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: appStore.isDarkMode ? [scaffoldColorDark, splashBgColor.withOpacity(0.2)] : [PrimaryColor, blueGreyColor.withOpacity(0.2)],
                      ),*/
                    ),
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      //width: MediaQuery.of(context).size.width-100,
                                      padding: EdgeInsets.only(left: 8.0),
                                      decoration: BoxDecoration(
                                          color: appStore.isDarkMode ? scaffoldLightColor.withOpacity(0.3) : Colors.blueGrey.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8.0)),
                                      child: TextField(
                                        controller: searchedTextController,
                                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                                        onChanged: (value){
                                          setState(() {
                                            searchedText = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Aradığınız kelimeyi giriniz...",
                                          hintStyle: TextStyle(
                                            color: appStore.isDarkMode ? scaffoldLightColor : scaffoldColorDark,
                                          ),
                                          border: InputBorder.none,
                                          prefixIcon: IconButton(
                                            onPressed: () {},
                                            color: appStore.isDarkMode ? scaffoldLightColor : scaffoldColorDark,
                                            icon: Icon(Icons.search),
                                            iconSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // aramanın yanındaki sarı buton
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              filterByColor();
                                            },
                                            child: Icon(Icons.color_lens_outlined),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.amber,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                )
                                            ),
                                          )))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                ),
              ];
            },
            body: Center(
              child: sayfaGoster(_selectedIndex),
            ),
          ),
          //not eklemek için bulunan postitlerim
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height / 3) * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: 90,
                  child: ElevatedButton(
                    child: Text(""),
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TextDetectorView()));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 50,
                  width: 60,
                  child: ElevatedButton(
                    child: Center(
                        child: Text(
                      "+",
                      style: TextStyle(color: Colors.white),
                    )),
                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                    onPressed: () {
                      selectNoteType();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: DashboardDrawerWidget(),
      // şu anda uygulamada ikinci bir sayfa olmasını gerektiricek bir durum bulunmuyor.
      /*bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesome5.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome5.sticky_note), label: "Notlarım"),
          //BottomNavigationBarItem(icon: Icon(FontAwesome5.user), label: "Profil"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),*/
    );
  }

  Widget sayfaGoster(int seciliSayfa) {
    if (seciliSayfa == 0) {
      return StreamBuilder<List<NotesModel>>(
        stream: notesService.fetchNotes(color: colorFilter,searchedText: searchedText),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return noDataWidget(context).center();
            } else {
              return Scrollbar(
                child: StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(fitWithCount),
                  mainAxisSpacing: 8,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8,
                  addAutomaticKeepAlives: false,
                  padding: EdgeInsets.only(left: 8, top: 8, right: 8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {

                      NotesModel notes = snapshot.data![index];

                      if(notes.note != null){
                        if(!(notes.note!.toLowerCase().contains(searchedText.toLowerCase()))){
                          return Container(color: Colors.pink,);
                        }else{
                          if (notes.checkListModel.validate().isNotEmpty) {
                            return GestureDetector(
                              onLongPress: () {
                                HapticFeedback.vibrate();
                                lockNoteOption(notesModel: notes);
                              },
                              child: Container(
                                decoration: boxDecorationWithShadow(
                                  borderRadius: BorderRadius.circular(8),
                                  backgroundColor: getColorFromHex(notes.color!),
                                  spreadRadius: 0.0,
                                  blurRadius: 0.0,
                                  border: Border.all(color: Colors.grey.shade400),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    notes.isLock!
                                        ? Container(child: Icon(Icons.lock, color: scaffoldColorDark)).paddingOnly(top: 16).center()
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: notes.checkListModel!.take(5).length,
                                      itemBuilder: (_, index) {
                                        CheckListModel checkListData = notes.checkListModel![index];

                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 12,
                                              width: 12,
                                              decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.black)),
                                              child: checkListData.isCompleted! ? Icon(Icons.check, size: 10, color: Colors.black) : SizedBox(),
                                            ).paddingAll(8),
                                            Text(
                                              checkListData.todo.validate(),
                                              style: primaryTextStyle(
                                                decoration: checkListData.isCompleted! ? TextDecoration.lineThrough : TextDecoration.none,
                                                color: checkListData.isCompleted! ? Colors.grey : Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ).expand(),
                                          ],
                                        );
                                      },
                                    ).paddingTop(8),
                                    notes.checkListModel!.length > 5 ? Text('more...', style: secondaryTextStyle()).paddingLeft(8) : SizedBox(),
                                    Align(
                                      child: Text(formatTime(notes.updatedAt!.millisecondsSinceEpoch.validate()), style: secondaryTextStyle(size: 10, color: Colors.grey.shade900)),
                                      alignment: Alignment.bottomRight,
                                    ).paddingAll(16),
                                    notes.collaborateWith!.first != getStringAsync(USER_EMAIL)
                                        ? Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                                      child: Text(notes.collaborateWith!.first![0], style: boldTextStyle(color: Colors.black, size: 12)),
                                    ).paddingOnly(left: 16, bottom: 16)
                                        : SizedBox()
                                  ],
                                ),
                              ).onTap(() {
                                if (notes.isLock!) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => LockNoteDialogWidget(onSubmit: (aIsRight) {
                                      finish(context);
                                      AddToDoScreen(notesModel: notes).launch(context);
                                    }),
                                  );
                                } else {
                                  AddToDoScreen(notesModel: notes).launch(context);
                                }
                              }),
                            );
                          } else {
                            return GestureDetector(
                              onLongPress: () {
                                HapticFeedback.vibrate();
                                lockNoteOption(notesModel: notes);
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: boxDecorationWithShadow(
                                  borderRadius: BorderRadius.circular(defaultRadius),
                                  backgroundColor: getColorFromHex(notes.color!),
                                  spreadRadius: 0.0,
                                  blurRadius: 0.0,
                                  border: Border.all(color: Colors.grey.shade400),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    notes.isLock!
                                        ? Container(child: Icon(Icons.lock, color: scaffoldColorDark)).paddingOnly(top: 8, bottom: 8).center()
                                        : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(notes.noteTitle.validate(), style: boldTextStyle(color: Colors.black), maxLines: 1, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
                                        Text(notes.note!, style: primaryTextStyle(size: 12, color: Colors.black), maxLines: 10, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                    Align(
                                      child: Text(formatTime(notes.updatedAt!.millisecondsSinceEpoch.validate()), style: secondaryTextStyle(size: 10, color: Colors.grey.shade900)),
                                      alignment: Alignment.bottomRight,
                                    ),
                                    notes.collaborateWith!.first != getStringAsync(USER_EMAIL)
                                        ? Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                                      child: Text(notes.collaborateWith!.first![0], style: boldTextStyle(color: Colors.black, size: 12)),
                                    )
                                        : SizedBox()
                                  ],
                                ).onTap(() {
                                  if (notes.isLock!) {
                                    showDialog(
                                      context: context,
                                      builder: (_) => LockNoteDialogWidget(onSubmit: (aIsRight) {
                                        finish(context);
                                        AddNotesScreen(notesModel: notes).launch(context);
                                      }),
                                    );
                                  } else {
                                    AddNotesScreen(notesModel: notes).launch(context);
                                  }
                                }),
                              ),
                            );
                          }
                        }
                      }else{
                        return Container();
                      }
                  },
                ),
              );
            }
          }
          return snapWidgetHelper(snapshot, loadingWidget: Loader(color: appStore.isDarkMode ? scaffoldColorDark : PrimaryColor));
        },
      );
    } else if (seciliSayfa == 1) {
      return Container(
        color: Colors.blue,
      );
    } else if (seciliSayfa == 2) {
      return Container(
        color: Colors.black,
      );
    } else {
      return Container(
        color: Colors.red,
      );
    }
  }

  lockNoteDialog(NotesModel? notesModel) {
    return showDialog(
      context: context,
      builder: (_) {
        return LockNoteDialogWidget(
          onSubmit: (aIsRightPWD) {
            if (aIsRightPWD) {
              if (notesModel!.isLock == true) {
                notesModel.isLock = false;
              } else {
                notesModel.isLock = true;
              }

              notesService.updateDocument({'isLock': notesModel.isLock}, notesModel.noteId).then((value) {
                finish(context);
              }).catchError((error) {
                toast(error.toString());
              });
            }
          },
        );
      },
    );
  }

  lockNoteOption({NotesModel? notesModel}) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(select_option, style: secondaryTextStyle(size: 18)).center().paddingAll(8),
              Divider(height: 16),
              ListTile(
                leading: Icon(notesModel!.isLock! ? Icons.lock_open_rounded : Icons.lock_outline_rounded, color: appStore.isDarkMode ? PrimaryColor : scaffoldSecondaryDark),
                title: Text(notesModel.isLock! ? unlock_note : lock_note, style: primaryTextStyle()),
                onTap: () {
                  finish(context);
                  if (getStringAsync(USER_MASTER_PWD).isNotEmpty) {
                    if (notesModel.collaborateWith!.first == getStringAsync(USER_EMAIL)) {
                      lockNoteDialog(notesModel);
                    } else {
                      toast(share_note_change_not_allow);
                    }
                  } else {
                    setLockNoteDialog(notesModel);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_rounded, color: appStore.isDarkMode ? PrimaryColor : scaffoldSecondaryDark),
                title: Text(delete_note, style: primaryTextStyle()),
                onTap: () async {
                  finish(context);
                  if (notesModel.collaborateWith!.first == getStringAsync(USER_EMAIL)) {
                    bool deleted = await showInDialog(
                      context,
                      title: Text(delete_note, style: primaryTextStyle()),
                      child: Text(confirm_to_delete_note, style: primaryTextStyle()),
                      actions: [
                        TextButton(
                            onPressed: () {
                              finish(context, false);
                            },
                            child: Text(cancel, style: primaryTextStyle())),
                        TextButton(
                            onPressed: () {
                              finish(context, true);
                            },
                            child: Text(delete, style: primaryTextStyle())),
                      ],
                    );
                    if (deleted) {
                      notesService.removeDocument(notesModel.noteId).then((value) {
                        toast('note deleted');
                      }).catchError((error) {
                        toast(error.toString());
                      });
                    }
                  } else {
                    toast(share_note_change_not_allow);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  setLockNoteDialog(NotesModel? notesModel) {
    return showDialog(
      context: context,
      builder: (_) {
        return SetMasterPasswordDialogWidget(userId: getStringAsync(USER_ID), notesModel: notesModel);
      },
    );
  }

  selectNoteType() {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text('New', style: secondaryTextStyle(size: 18))
                  .center()
                  .paddingAll(8),
              Divider(height: 16),
              ListTile(
                leading: Icon(Icons.edit_outlined,
                    color: appStore.isDarkMode
                        ? PrimaryColor
                        : scaffoldSecondaryDark),
                title: Text(add_note, style: primaryTextStyle()),
                onTap: () {
                  finish(context);
                  AddNotesScreen().launch(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.check_box_outlined,
                    color: appStore.isDarkMode
                        ? PrimaryColor
                        : scaffoldSecondaryDark),
                title: Text(add_todo, style: primaryTextStyle()),
                onTap: () {
                  finish(context);
                  AddToDoScreen().launch(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  noteLayoutDialog() {
    return showInDialog(
      context,
      contentPadding: EdgeInsets.zero,
      titleTextStyle: primaryTextStyle(size: 20),
      title: Text(select_layout).paddingBottom(16),
      child:
      NoteLayoutDialogWidget(onLayoutSelect: (fitCount, crossCount) async {
        await setValue(FIT_COUNT, fitCount);
        await setValue(CROSS_COUNT, crossCount);
        setState(() {
          fitWithCount = fitCount;
          crossAxisCount = crossCount;
        });
      }),
    );
  }

  filterByColor() {
    return showInDialog(
      context,
      title: Text('Filter by color'),
      titleTextStyle: primaryTextStyle(size: 22),
      contentPadding: EdgeInsets.all(16),
      child: FilterNoteByColorDialogWidget(onColorTap: (color) {
        setState(() {
          colorFilter = color;
        });
      }),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

  const CustomCard(this._label, this._viewPage,
      {this.featureCompleted = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (Platform.isIOS && !featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    'This feature has not been implemented for iOS yet')));
          } else
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
        },
      ),
    );
  }
}
