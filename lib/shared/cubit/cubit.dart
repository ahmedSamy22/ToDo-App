import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/note_model.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<NoteModel> notes = [];
  NoteModel? noteModelSave;
  String? encodedNotes = '';

  void addNote({
    required String title,
    required String description,
    Color? color,
  }) {
    noteModelSave = NoteModel.fromJson({
      'title': title,
      'description': description,
      'date': DateFormat('yyyy-MM-dd  kk:mm a').format(DateTime.now()),
    });
    notes.add(noteModelSave!);
    encodedNotes = NoteModel.encode(notes);

    CacheHelper.saveData(key: 'notes', value: encodedNotes);
    emit(SaveNoteState());
  }

  String? decodedNotes = '';

  void getNotes() {
    decodedNotes = CacheHelper.getData(key: 'notes');

    if (decodedNotes == null) {
    } else {
      notes = NoteModel.decode(decodedNotes!);
    }

    emit(GetNotesState());
  }

  String? encodedEditedNotes = '';
  void updateNote({
    required int index,
    String? title,
    String? description,
  }) {
    notes[index] = NoteModel.fromJson({
      'title': title,
      'description': description,
      'date': DateFormat('yyyy-MM-dd  kk:mm a').format(DateTime.now()),
    });

    emit(UpdateNoteState());

    encodedEditedNotes = NoteModel.encode(notes);
    CacheHelper.saveData(key: 'notes', value: encodedEditedNotes);
    emit(SaveNoteState());
  }

  void removeNote({
    required int index,
  }) {
    notes.removeAt(index);
    emit(RemoveNoteState());
    encodedEditedNotes = NoteModel.encode(notes);
    CacheHelper.saveData(key: 'notes', value: encodedEditedNotes);
    emit(SaveNoteState());
  }

  bool isBottomSheetShowen = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState(bool isShown, IconData icon) {
    isBottomSheetShowen = isShown;
    fabIcon = icon;
    emit(AppBottomSheetShowenState());
  }
}
