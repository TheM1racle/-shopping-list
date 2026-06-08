# Список покупок (Flutter)

Приложение на Flutter с двумя экранами: список покупок и настройки.

## Возможности

- Добавление, удаление, изменение количества товаров
- Отметка «куплено» с зачёркиванием без удаления
- Переключение светлой/тёмной/системной темы
- Русский и английский язык
- Сохранение данных и настроек в Hive
- Material 3, адаптивный UI (NavigationBar / NavigationRail)
- Бонус: кнопка «За покупками» с уведомлениями (Linux/Android; на Web ограничено)

## Архитектура

```
lib/
  domain/        — сущности и абстракции репозиториев
  data/          — Hive, модели, реализации репозиториев
  presentation/  — экраны, виджеты, Riverpod-провайдеры
  core/          — тема, DI, сервисы
```

## Запуск в Brave (Web)

Если экран белый — Flutter не может загрузить CanvasKit с CDN. Используйте локальный CanvasKit:

```bash
flutter pub get
flutter gen-l10n
export CHROME_EXECUTABLE=/usr/bin/brave-browser
export NO_PROXY=localhost,127.0.0.1,::1

# release (стабильно, без hot reload)
flutter run -d chrome --release --no-web-resources-cdn

# или web-server + открыть Brave вручную
flutter run -d web-server --web-port=8080 --no-web-resources-cdn
# затем http://localhost:8080
```

Статическая сборка:

```bash
flutter build web --release --no-web-resources-cdn
cd build/web && python3 -m http.server 8080
```

## Linux Mint + Brave

См. раздел «Установка на Linux Mint» в конце README или в ответе ассистента.
