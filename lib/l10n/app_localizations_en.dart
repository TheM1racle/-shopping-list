// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shopping List';

  @override
  String get shoppingList => 'Shopping list';

  @override
  String get settings => 'Settings';

  @override
  String get addItem => 'Add item';

  @override
  String get itemName => 'Item name';

  @override
  String get quantity => 'Quantity';

  @override
  String get add => 'Add';

  @override
  String get delete => 'Delete';

  @override
  String get purchased => 'Purchased';

  @override
  String get emptyList => 'Your list is empty. Add your first item.';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get languageRu => 'Russian';

  @override
  String get languageEn => 'English';

  @override
  String get goShopping => 'Go shopping';

  @override
  String get stopShopping => 'Stop shopping';

  @override
  String get nextItem => 'Next item';

  @override
  String get tapToMarkBought => 'Tap notification to mark as bought';

  @override
  String get noUnpurchasedItems => 'No unpurchased items left';

  @override
  String get shoppingActive => 'Shopping mode is active';
}
