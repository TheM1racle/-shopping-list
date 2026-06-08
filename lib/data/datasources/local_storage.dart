import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const shoppingBoxName = 'shopping_items';
  static const settingsBoxName = 'app_settings';
  static const itemsKey = 'items';
  static const settingsKey = 'settings';

  Future<void> init({String? testPath}) async {
    if (testPath != null) {
      Hive.init(testPath);
    } else {
      await Hive.initFlutter();
    }
    await Hive.openBox(shoppingBoxName);
    await Hive.openBox(settingsBoxName);
  }

  Box get shoppingBox => Hive.box(shoppingBoxName);

  Box get settingsBox => Hive.box(settingsBoxName);
}
