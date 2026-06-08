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

## Material
<img width="418" height="885" alt="image" src="https://github.com/user-attachments/assets/b97c2969-b5f1-4fa4-8bd3-0a2d9045f51b" />
<img width="418" height="884" alt="image" src="https://github.com/user-attachments/assets/b5381074-aa9d-4ff7-8dc6-cd0f450da88b" />
<img width="412" height="881" alt="image" src="https://github.com/user-attachments/assets/8c236d0b-3141-4e5a-b220-8a1ff2639cef" />
<img width="419" height="883" alt="image" src="https://github.com/user-attachments/assets/870e3fbe-95e7-4f55-aa01-d59e5cf009e4" />
<img width="426" height="882" alt="image" src="https://github.com/user-attachments/assets/ad041737-c119-4607-86df-df6345258c55" />





