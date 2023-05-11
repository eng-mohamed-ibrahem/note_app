import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/controller/helper/shared_perferences_helper.dart';
import 'package:note_app/view/widget/note_widget_in_home.dart';
import '../../controller/provider/drag_decoration_note.dart';
import '../../controller/provider/list_notes_provider.dart';
import '../../controller/provider/theme_mode_provider.dart';
import '../../controller/util/constants/app_constants.dart';
import '../../controller/util/constants/key_constants.dart';
import '../../controller/util/methods/app_methods.dart';
import '../widget/dismissible_widget.dart';
import '../widget/love_widget.dart';
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
                  SharedHelper.accessShared
                      .setBool(KeySharedConstants.darkTheme, true);

                  /// update state of provider
                  return ThemeMode.dark;
                } else {
                  SharedHelper.accessShared
                      .setBool(KeySharedConstants.darkTheme, false);
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
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return DismissbleWidget(
                        dismisskey: Key('${notes[index].colorCode}'),
                        onDismissed: (direction) {
                          dismissNoteWidget(
                              context: context, ref: ref, index: index);
                        },
                        child: NoteWidget(index: index),
                      );
                    },
                    itemCount:
                        ref.watch(notesProvider).length, // get from shared
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: MediaQuery.of(context).size.width / 2.0 - 25,
                  child: Draggable<String>(
                    data: AppConst.dragData,
                    feedback: const LoveWidget(),
                    onDragStarted: () {
                      // box decoration on note
                      ref
                          .watch(drawBoxOnWidgetProvider.notifier)
                          .update((state) => true);
                    },
                    onDragEnd: (details) {
                      ref
                          .watch(drawBoxOnWidgetProvider.notifier)
                          .update((state) => false);
                    },
                    childWhenDragging: const SizedBox(), // empty
                    child: const LoveWidget(),
                  ),
                )
              ],
            ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNoteScreen(),
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
