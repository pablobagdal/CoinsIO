# coinio_app

Coinio app - coins input & output (с англ. входящие\исходящие монеты). Это игра с частой аббревиатурой в мире информационных технологий. Деньги приходят и уходфдят. Так почему бы не взять это течение под свой контроль? Данное приложение позволит выявить, какие статьи расходов наиболее высоки, и какие статьи доходов наиболее прибыльны.

Зачем? Ведь этот инструментарий есть уже почти в каждом банковском приложении. Верно. Но что делать, если в обороте наличные? Криптовалюты? Используются разные банки?
Было бы удобно собрать всё в одном месте. К счастью или сожалению, но чтобы прийти к такому пониманию, нужно, чтобы вы ответственно вели учёт всех транзакций. Удобный и простой интерфейс приложения вам в этом поможет.


Это учебное мобильное приложение, выполненное в ходе летней школы мобильной разработки от Яндекс в 2025 году.

В данном проекте я освоил множество новых для себя идей, решений, инструментов, технологий. Ниже я хочу поделиться, как же правильно собрать данное приложение у себя, чтобы также насладиться получившимся результатом. Хотя, конечно, оно вряд ли вам доставит сколько же удовольствия, сколько самому автору, но я буду рад, если вы тоже найдёте в этом для себя большую пользу:)

## Getting Started

1. Склонируйте себе репозиторий командой

git clone https://github.com/pablobagdal/coinio_app.git

2. Перейдите в загруженную папку
2. Выберите ветку, если есть необходимость её сменить
3. Подтяните зависимости командой в терминале
flutter pub get
4. Далее необходимо выполнить кодогенерацию. Мне понравилась идея не выносить её в репозиторий, чтобы снизить общий вес проекта, сделать его менее нагруженным.
flutter pub run build_runner build
Данная команда требует от нескольких минут ожидания на генерацию кода.
5. По завершении кодогенерации из проекта должны исчезнуть многочисленные сообщения об ошибке, а вернее их совсем не станет, после чего можно запустать приложение на любом желаемом вам устройстве (ios или android). Любым способом. В частности, командой
flutter run

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


По ДЗ-5
Как это работает
1. Архитектура решения
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   UI Thread     │    │  Isolate Pool    │    │   Backend       │
│                 │    │                  │    │                 │
│ NetworkService  │───▶│  networkWorker   │───▶│  HTTP API       │
│ (Dio + Inter.)  │    │  (Dio instance)  │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
2. Поток выполнения

Запрос создается в UI потоке через NetworkService
Interceptor проверяет - нужно ли выполнять в изоляте
Если да - создается IsolateRequest и отправляется в пул
WorkerManager выбирает свободный изолят или создает новый
В изоляте выполняется networkWorker с отдельным Dio
Результат возвращается через IsolateResponse
Interceptor преобразует ответ в стандартный Dio Response

3. Преимущества такого подхода

Прозрачность - API остается стандартным для Dio
Гибкость - можно настроить, какие запросы выполнять в изолятах
Эффективность - пул изолятов переиспользуется
Отказоустойчивость - ошибки в изоляте не влияют на UI

4. Настройка использования
dart// Все запросы в изолятах
enableIsolateForAllRequests: true

// Только определенные эндпоинты
isolateEnabledEndpoints: ['/heavy-endpoint']

// Размер пула изолятов
isolatePoolSize: 4
5. Когда использовать изоляты

Обработка больших JSON
Загрузка/выгрузка файлов
Сложные вычисления после получения данных
Множественные параллельные запросы