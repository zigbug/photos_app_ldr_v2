//Генерируем 100 ссылок
//id86 и ещё какие-то будут битые
//если изменить 100 на 60 кеш будет работать значительно лучше и фотографии будут грузитс одновременно по 10 штук
//Скорее всего, это связано с ошибками из-за битых сылок
// тут подробнее, пока косячок не исправлен
// https://stackoverflow.com/questions/62491230/how-to-handle-404-exception-with-cachednetworkimage-in-flutter
List<String> pht = List<String>.generate(
    100, (index) => 'https://picsum.photos/id/${index + 10}/600');
