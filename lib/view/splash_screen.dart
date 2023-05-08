import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/view/screens/home.dart';
import '../controller/provider/list_notes_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(
      () {
        return ref.read(notesProvider.notifier).fetchNotesFromShared();
      },
    ).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    });

    return const Scaffold(
      body: Center(
        child: Text('loading...'),
      ),
    );
  }
}
