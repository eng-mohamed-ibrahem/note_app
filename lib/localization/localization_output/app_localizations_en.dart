import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Color Notes';

  @override
  String get emptyListMessage => 'add note by tapping  ';

  @override
  String get noteTitle => 'title';

  @override
  String get noteBody => 'body';

  @override
  String get saveNoteButtonText => 'save';

  @override
  String get addNoteAppbarTitle => 'add note';

  @override
  String get myNotesAppbarTitle => 'my notes';

  @override
  String get noteEditeSnackbarMessage => 'note edited';

  @override
  String get noteAddSnackbarMessage => 'note added';

  @override
  String get noteNotSavedSnackbarMessage => 'not saved';

  @override
  String get deleteDismissText => 'Delete';

  @override
  String get deleteNoteMessage => 'note deleted';
}
