import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مذكرات ملونة';

  @override
  String get emptyListMessage => 'أضف مذكرة بالضغط على  ';

  @override
  String get noteTitle => 'الموضوع';

  @override
  String get noteBody => 'المحتوى';

  @override
  String get saveNoteButtonText => 'حفظ';

  @override
  String get addNoteAppbarTitle => 'أضف مذكرة';

  @override
  String get myNotesAppbarTitle => 'مذكراتى';

  @override
  String get noteEditeSnackbarMessage => 'تم تعديل مذكرة';

  @override
  String get noteAddSnackbarMessage => 'تم إضافة مذكرة';

  @override
  String get noteNotSavedSnackbarMessage => 'لم يتم الحفظ';

  @override
  String get deleteDismissText => 'حذف';

  @override
  String get deleteNoteMessage => 'تم حذف المذكرة';
}
