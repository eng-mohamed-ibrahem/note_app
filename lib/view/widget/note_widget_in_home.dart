import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/controller/util/methods/app_methods.dart';
import 'package:note_app/view/screens/add_note.dart';
import '../../controller/provider/drag_decoration_note.dart';
import '../../controller/provider/list_notes_provider.dart';
import '../../controller/util/constants/app_constants.dart';
import 'love_widget.dart';

class NoteWidget extends ConsumerWidget {
  final int index;
  const NoteWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddNoteScreen(
              index: index,
            ),
          ),
        );
      },
      child: DragTarget<String>(
        onMove: (details) {},
        onWillAccept: (details) {
          return details == AppConst.dragData &&
              (notes[index].iLikedIt == false);
        },
        onAccept: (data) {
          addLovedNote(ref: ref, lovedNoteIndex: index, notes: notes);
        },
        builder: (context, candidateData, rejectedData) {
          return Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    side: ref.watch(drawBoxOnWidgetProvider)
                        ? const BorderSide(
                            width: 2,
                            color: Color.fromRGBO(143, 143, 143, 1),
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.antiAlias,
                color: Color(notes[index].colorCode!),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${notes[index].title}',
                        style: Theme.of(context).textTheme.titleMedium,
                        softWrap: true,
                      ),
                      const Divider(thickness: 1, indent: 5, endIndent: 0),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Text(
                          '${notes[index].body}',
                          style: Theme.of(context).textTheme.bodySmall,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: notes[index].iLikedIt
                    ? const LoveWidget(
                        size: 15,
                      )
                    : const SizedBox(), // empty
              )
            ],
          );
        },
      ),
    );
  }
}
