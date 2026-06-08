// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Список покупок';

  @override
  String get shoppingList => 'Список покупок';

  @override
  String get settings => 'Настройки';

  @override
  String get addItem => 'Добавить товар';

  @override
  String get itemName => 'Название товара';

  @override
  String get quantity => 'Количество';

  @override
  String get add => 'Добавить';

  @override
  String get delete => 'Удалить';

  @override
  String get purchased => 'Куплено';

  @override
  String get emptyList => 'Список пуст. Добавьте первый товар.';

  @override
  String get theme => 'Тема';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeSystem => 'Системная';

  @override
  String get language => 'Язык';

  @override
  String get languageRu => 'Русский';

  @override
  String get languageEn => 'Английский';

  @override
  String get goShopping => 'За покупками';

  @override
  String get stopShopping => 'Остановить';

  @override
  String get nextItem => 'Следующий товар';

  @override
  String get tapToMarkBought =>
      'Нажмите на уведомление, чтобы отметить как купленное';

  @override
  String get noUnpurchasedItems => 'Некупленных товаров не осталось';

  @override
  String get shoppingActive => 'Режим покупок активен';
}
