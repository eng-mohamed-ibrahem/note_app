import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/view/screens/add_note.dart';
import '../../controller/provider/list_notes_provider.dart';

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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        color: Color(notes[index].colorCode!),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${notes[index].title}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Expanded(
                    flex: 1,
                    child: Divider(thickness: 1, indent: 5, endIndent: 0),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
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
    );
  }
}
