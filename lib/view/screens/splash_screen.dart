import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/view/screens/home.dart';
import '../../controller/provider/list_notes_provider.dart';
import '../../controller/util/assets_images.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(
      const Duration(milliseconds: 500),
    ).then((value) {
      ref.read(notesProvider.notifier).fetchNotesFromShared();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetImages.splashScreen,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
