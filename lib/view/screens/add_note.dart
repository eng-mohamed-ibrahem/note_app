import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/view/widget/love_widget.dart';
import '../../controller/color_controller/color_note_controller.dart';
import '../../controller/provider/list_notes_provider.dart';
import '../../controller/util/methods/app_methods.dart';
import '../widget/input_text_field.dart';



class AddNoteScreen extends HookConsumerWidget {
  late int? index;
   AddNoteScreen({super.key, this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = useTextEditingController();
    final TextEditingController bodyController = useTextEditingController();
    final GlobalKey<FormState> globalKey =
        useMemoized(() => GlobalKey<FormState>());
    Color? fillColor;
    final notes = ref.watch(notesProvider);
    if (index != null) {
      titleController.text = notes[index!].title!;
      bodyController.text = notes[index!].body!;
      fillColor = Color(notes[index!].colorCode!);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('add note'),
      ),
      body: Form(
        key: globalKey,
        child: AnimatedContainer(
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFormField(
                    fillColor: index != null ? fillColor : null,
                    controller: titleController,
                    labelText: 'title',
                    maxLines: 2,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          indent: 0,
                          endIndent: 5,
                          height: 20,
                        ),
                      ),
                      index != null && notes[index!].iLikedIt
                          ? InkWell(
                              onTap: () {
                                // remove loved note
                                removeLovedNote(
                                    ref: ref,
                                    unLovedNoteIndex: index!,
                                    notes: notes);
                                    index = notes.length-1;

                              },
                              child: const LoveWidget(),
                            )
                          : const SizedBox(),
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          indent: 5,
                          endIndent: 0,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  InputTextFormField(
                    fillColor: index != null ? fillColor : null,
                    controller: bodyController,
                    labelText: 'body',
                    maxLines: 30,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                bodyController.text.isNotEmpty) {
              /// No_1 at runtime
              /// if edit or add
              if (index != null) {
                /// edit at runtime state
                ref.watch(notesProvider.notifier).editNote(
                      index: index!,
                      title: titleController.text.trim(),
                      body: bodyController.text.trim(),
                    );
              } else {
                /// save note at runtime state
                ref.watch(notesProvider.notifier).addNote(
                      note: NoteModel(
                          id: notes.isNotEmpty
                              ? notes.length - 1
                              : notes.length,
                          title: titleController.text.trim(),
                          body: bodyController.text.trim(),
                          colorCode: ColorController.generateColor().value),
                    );
              }

              /// No_2 at sharedpreferences
              /// save to sharedPref
              ref.watch(notesProvider.notifier).saveToShared().whenComplete(() {
                /// display snackbar saved
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: index != null
                        ? const Text('note edited.')
                        : const Text('note added.'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 120,
                  ),
                );
              });

              /// No_3 displayed changes to home screen
              /// force rebuild
              var getNotes = ref.read(notesProvider);
              ref.refresh(notesProvider).addAll(getNotes);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('not saved.'),
                ),
              );
            }

            /// navigate to mainScreen
            Navigator.pop(context);
          },
          child: const Text('save')),
    );
  }
}
