import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String? noteId;
  String? userId;
  String? noteTitle;
  String? note;
  String? color;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CheckListModel>? checkListModel;
  List<String?>? collaborateWith;
  bool? isLock;

  NotesModel({
    this.noteId,
    this.userId,
    this.noteTitle,
    this.note,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.checkListModel,
    this.collaborateWith,
    this.isLock = false,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      noteId: json['id'],
      userId: json['userId'],
      noteTitle: json['noteTitle'],
      note: json['note'],
      color: json['color'],
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
      updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate() : null,
      checkListModel: json['checkList'] != null ? (json['checkList'] as List).map<CheckListModel>((e) => CheckListModel.fromJson(e)).toList() : null,
      collaborateWith: json['collaborateWith'] != null ? (json['collaborateWith'] as List).map<String>((e) => e).toList() : null,
      isLock: json['isLock'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.noteId;
    data['userId'] = this.userId;
    data['noteTitle'] = this.noteTitle;
    data['note'] = this.note;
    data['color'] = this.color;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;

    /// check is null or not
    data['checkList'] = this.checkListModel!.map((e) => e.toJson()).toList();
    data['collaborateWith'] = this.collaborateWith!.map((e) => e).toList();

    data['isLock'] = this.isLock;

    return data;
  }
}

class CheckListModel {
  String? todo;
  bool? isCompleted;

  CheckListModel({this.todo, this.isCompleted});

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
      todo: json['todo'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['todo'] = this.todo;
    data['isCompleted'] = this.isCompleted;

    return data;
  }
}
