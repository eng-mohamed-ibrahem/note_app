import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../model/note_model.dart';
import '../../provider/list_notes_provider.dart';

SnackBar notifiySnackBar({required Widget content}) {
  return SnackBar(
    content: content,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    width: 150,
  );
}

void addLovedNote(
    {required WidgetRef ref,
    required int lovedNoteIndex,
    required List<NoteModel> notes}) {
  notes[lovedNoteIndex].iLikedIt = true;
  ref
      .watch(notesProvider.notifier)
      .moveTo(currentNoteIndex: lovedNoteIndex, note: notes[lovedNoteIndex])
      .whenComplete(() {
    ref.watch(notesProvider.notifier).saveToShared().whenComplete(() {
      forceRebuild(ref: ref);
    });
  });
}

void removeLovedNote(
    {required WidgetRef ref,
    required int unLovedNoteIndex,
    required List<NoteModel> notes}) {
  notes[unLovedNoteIndex].iLikedIt = false;

  ref
      .watch(notesProvider.notifier)
      .moveTo(
          currentNoteIndex: unLovedNoteIndex,
          desiredIndex: notes.length - 1,
          note: notes[unLovedNoteIndex])
      .whenComplete(() {
    ref.watch(notesProvider.notifier).saveToShared().whenComplete(() {
      forceRebuild(ref: ref);
    });
  });
}

int getTheLastLovedNoteIndex({required List<NoteModel> notes}) {
  int index = 0;
  for (var i = 0; i < notes.length; i++) {
    if (notes[i].iLikedIt) {
      index = i;
    }
  }
  log('desired-$index');
  return index != 0 ? index - 1 : index;
}

void forceRebuild({required WidgetRef ref}) {
  /// force rebuild
  var getNotes = ref.read(notesProvider);
  ref.refresh(notesProvider).addAll(getNotes);
}

void dismissNoteWidget(
    {required BuildContext context,
    required WidgetRef ref,
    required int index}) {
  /// remove and save at runtime
  ref.watch(notesProvider.notifier).removeNote(index: index).whenComplete(() {
    /// save at sharedpreferences
    ref.watch(notesProvider.notifier).saveToShared().whenComplete(() {
      forceRebuild(ref: ref);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('note deleted'),
      ),
    );

    log('removed- $index');
  });
}
