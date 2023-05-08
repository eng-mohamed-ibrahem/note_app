import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/view/widget/note_widget_in_home.dart';

import '../../controller/provider/list_notes_provider.dart';
import 'add_note_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider); // ???!

    return Scaffold(
      appBar: AppBar(
        title: const Text('my notes'),
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text('add note by tapping + icon'),
            )
          : Container(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NoteWidget(index: index);
                },
                itemCount: notes.length, // get from shared
              ),
            ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNoteScreen(),
              ));
        },
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
