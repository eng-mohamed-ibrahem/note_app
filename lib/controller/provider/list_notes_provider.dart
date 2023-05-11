import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/controller/helper/shared_perferences_helper.dart';
import '../../model/note_model.dart';
import '../util/constants/key_constants.dart';

final notesProvider =
    StateNotifierProvider<_NoteStateNotifier, List<NoteModel>>(
  (ref) => _NoteStateNotifier([]),
);

class _NoteStateNotifier extends StateNotifier<List<NoteModel>> {
  _NoteStateNotifier(super.state) {
    // fetchNotesFromShared();
  }

  Future<bool> fetchNotesFromShared() async {
    bool fetched = false;
    try {
      List<String>? listOfNotes =
          SharedHelper.accessShared.getStringList(KeySharedConstants.notes);
      if (listOfNotes != null) {
        for (String note in listOfNotes) {
          state.add(NoteModel.fromJson(note));
        }
        fetched = true;
      } else {
        state = [];
      }
    } on Exception catch (e) {
      debugPrint('$e');
      fetched = false;
    }
    return fetched;
  }

  void addNote({required NoteModel note}) {
    state.add(note);
    debugPrint('add- $state');
  }

  void editNote(
      {required int index, required String title, required String body}) {
    state[index].title = title;
    state[index].body = body;
    log('${state.toList()}');
  }

  Future moveTo(
      {required int currentNoteIndex,
      int desiredIndex = 0,
      required NoteModel note}) async {
    await removeNote(index: currentNoteIndex)
        .whenComplete(() => state.insert(desiredIndex, note)); // then
    // add first

    log('inserted');
  }

  Future<bool> removeNote({required int index}) async {
    await Future(() {
      state.removeAt(index);
      debugPrint('remove- $state');
    });
    return true;
  }

  List<String> _notesToMap() {
    List<String> nTom = [];
    for (NoteModel note in state) {
      nTom.add(note.toJson());
    }
    return nTom;
  }

  Future<bool> saveToShared() async {
    return await SharedHelper.accessShared
        .setStringList(KeySharedConstants.notes, _notesToMap());
  }
}
