# photos_app_ldr_v2

**Wow Photos** — тестовое приложение на Flutter: бесконечная лента изображений
с предварительным кешированием и постепенной подгрузкой при скролле.

A Flutter test app: an infinite image feed with pre-caching and lazy scroll loading.

[![Flutter](https://img.shields.io/badge/Flutter-2.x-02569B?logo=flutter)](https://flutter.dev)

---

## 🇷🇺 Русский

### Описание

Демо-приложение для отработки загрузки и кеширования большого количества картинок:
лента из 100 фото с `picsum.photos` подгружается порциями по 10 штук, когда
пользователь до скролла до конца, а перед показом весь текущий батч прогревается
в кеш (`precacheImage` + `cached_network_image`).

### Возможности

- Сетка фото (`GridScreenPhotos`) с бесконечной прокруткой: +10 элементов
  при достижении низа, индикатор загрузки, финальное состояние «всё»
- **Предкешинг батча**: `Future.wait` по всем ссылкам через `PreCacheUtil.cacheImages`
- Отображение через [cached_network_image](https://pub.dev/packages/cached_network_image)
  (дисковый кеш, повторные открытия без сети)
- Полноэкранный просмотр фото и **кнопка «Поделиться»** (`share_plus`)
- Плейсхолдер `assets/noPhoto.png` для битых ссылок
- Целевые платформы этого проекта: **Windows и Web** (есть также android/ios)

### Известная проблема

Список ссылок генерируется как `https://picsum.photos/id/<10..109>/600`, и часть id
отдаёт 404 — из-за этого `cached_network_image` логирует ошибки и кеш работает
хуже (поэтому в `fetch_photos_list.dart` рекомендуют уменьшить размер выборки
с 100 до 60). См. комментарий в `lib/services/fetch_photos_list.dart` и
[обсуждение на Stack Overflow](https://stackoverflow.com/questions/62491230/how-to-handle-404-exception-with-cachednetworkimage-in-flutter).

### Технологии

- **Flutter**
- [cached_network_image](https://pub.dev/packages/cached_network_image) — загрузка и кеш изображений
- [share_plus](https://pub.dev/packages/share_plus) — шаринг ссылок

### Структура проекта

```
photos_app_ldr_v2/
├── lib/
│   ├── main.dart
│   ├── view.dart                      # Scaffold «Wow Photos»
│   ├── screens/
│   │   ├── grid_screen.dart           # сетка, бесконечный скролл, предкеш
│   │   └── photo_screen_selected.dart # полноэкранный просмотр + share
│   └── services/
│       ├── fetch_photos_list.dart     # генерация 100 ссылок picsum.photos
│       └── precash_img.dart           # утилита предкешинга
├── assets/noPhoto.png
├── windows/ web/ android/ ios/
└── pubspec.yaml
```

### Запуск

```bash
flutter pub get
flutter run -d windows    # или -d chrome
```

---

## 🇬🇧 English

### Overview

A demo app for practising loading and caching lots of images: a feed of 100
`picsum.photos` photos is fetched in chunks of 10 as the user scrolls to the bottom,
and every current batch is pre-warmed into the cache before rendering
(`precacheImage` + `cached_network_image`).

### Features

- Photo grid (`GridScreenPhotos`) with infinite scroll: +10 items at the bottom,
  loading indicator, final «that's all» state
- **Batch pre-caching**: `Future.wait` over all URLs via `PreCacheUtil.cacheImages`
- Rendering with [cached_network_image](https://pub.dev/packages/cached_network_image)
  (disk cache, offline re-opens)
- Full-screen photo view and a **share button** (`share_plus`)
- Placeholder `assets/noPhoto.png` for broken links
- Target platforms of this project: **Windows and Web** (android/ios included too)

### Known issue

Links are generated as `https://picsum.photos/id/<10..109>/600` and some ids return
404 — this makes `cached_network_image` log errors and weakens caching (that's why
`fetch_photos_list.dart` suggests lowering the batch from 100 to 60). See the comment
in `lib/services/fetch_photos_list.dart` and
[this Stack Overflow thread](https://stackoverflow.com/questions/62491230/how-to-handle-404-exception-with-cachednetworkimage-in-flutter).

### Tech stack

- **Flutter**
- [cached_network_image](https://pub.dev/packages/cached_network_image) — image loading & caching
- [share_plus](https://pub.dev/packages/share_plus) — link sharing

### Project structure

```
photos_app_ldr_v2/
├── lib/
│   ├── main.dart
│   ├── view.dart                      # «Wow Photos» scaffold
│   ├── screens/
│   │   ├── grid_screen.dart           # grid, infinite scroll, pre-cache
│   │   └── photo_screen_selected.dart # full-screen view + share
│   └── services/
│       ├── fetch_photos_list.dart     # 100 picsum.photos links
│       └── precash_img.dart           # pre-cache helper
├── assets/noPhoto.png
├── windows/ web/ android/ ios/
└── pubspec.yaml
```

### Getting started

```bash
flutter pub get
flutter run -d windows    # or -d chrome
```
