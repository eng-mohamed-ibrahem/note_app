import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/controller/helper/shared_perferences_helper.dart';
import 'package:note_app/view/widget/note_widget_in_home.dart';
import '../../controller/provider/list_notes_provider.dart';
import '../../controller/provider/theme_mode_provider.dart';
import '../widget/dismissible_widget.dart';
import 'add_note.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('my notes'),
        actions: [
          const Icon(Icons.dark_mode_outlined),
          Switch(
            value: ref.watch(themeModeProvider) == ThemeMode.dark,
            onChanged: (on) {
              ref.watch(themeModeProvider.notifier).update((state) {
                if (on) {
                  /// save at sharedpreference
                  SharedHelper.accessShared.setBool('dark_theme', true);

                  /// update state of provider
                  return ThemeMode.dark;
                } else {
                  SharedHelper.accessShared.setBool('dark_theme', false);
                  return ThemeMode.light;
                }
              });
            },
          )
        ],
      ),
      body: notes.isEmpty
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('add note by tapping  '),
                  FaIcon(FontAwesomeIcons.penToSquare),
                  Text('  icon bellow.'),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return DismissbleWidget(
                    dismisskey: Key('${notes[index].colorCode}'),
                    onDismissed: (direction) {
                      /// remove and save at runtime
                      ref
                          .watch(notesProvider.notifier)
                          .removeNote(index: index)
                          .whenComplete(() {
                        /// save at sharedpreferences
                        ref
                            .watch(notesProvider.notifier)
                            .saveToShared()
                            .whenComplete(() {
                          /// force rebuild
                          var getNotes = ref.read(notesProvider);
                          ref.refresh(notesProvider).addAll(getNotes);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('note deleted'),
                          ),
                        );

                        log('removed- $index');
                      });
                    },
                    child: NoteWidget(index: index),
                  );
                },
                itemCount: ref.watch(notesProvider).length, // get from shared
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
        icon: const FaIcon(
          FontAwesomeIcons.penToSquare,
          size: 30,
        ),
      ),
    );
  }
}
