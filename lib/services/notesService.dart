import 'package:flutter_text_recognititon/main.dart';
import 'package:flutter_text_recognititon/model/notesModel.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import 'BaseService.dart';

class NotesServices extends BaseService {
  NotesServices({String? userID}) {
    ref = db.collection('notes');
  }

  Stream<List<NotesModel>> fetchNotes(
      {String color = '', String searchedText = ''}) {
    print(searchedText +
        "+++++++++++++++++++++++++++++++++++++++++++++++++--------------+++---------------");
    return color.isEmpty
        ? ref
            .where('collaborateWith', arrayContains: getStringAsync(USER_EMAIL))
            .orderBy('updatedAt', descending: true)
            .snapshots()
            .map(
            (event) {
              return event.docs
                  .map((e) =>
                      NotesModel.fromJson(e.data() as Map<String, dynamic>))
                  .toList();
            },
          )
        : ref
            .where('collaborateWith', arrayContains: getStringAsync(USER_EMAIL))
            .where('color', isEqualTo: color)
            .orderBy('updatedAt', descending: true)
            .snapshots()
            .map(
            (event) {
              return event.docs
                  .map((e) =>
                      NotesModel.fromJson(e.data() as Map<String, dynamic>))
                  .toList();
            },
          );
  }
}

/*
ref
    .where('collaborateWith', arrayContains: getStringAsync(USER_EMAIL))
.where('color', isEqualTo: color)
.orderBy('updatedAt', descending: true).snapshots().map(
(event) {
return event.docs.map((e) => NotesModel.fromJson(e.data() as Map<String, dynamic>)).toList();
},
);*/

/*

.where('note', isGreaterThanOrEqualTo: searchedText)
            .where('note', isLessThan: searchedText + 'z')

 */
