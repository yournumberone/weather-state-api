# weather-state-api

## Installation:

` make install `


## Usage:

- api/weather/current - Текущая температура
- api/weather/historical - Почасовая температура за последние 24 часа
- api/weather/historical/max - Максимальная темперетура за 24 часа
- api/weather/historical/min - Минимальная темперетура за 24 часа
- api/weather/historical/avg - Средняя темперетура за 24 часа
- api/weather/by_time - Ближайшая температура к переданному timestamp (например 1621823790 должен отдать температуру за 2021-05-24 08:00. Из имеющихся данных, если такого времени нет возвращает 404)
- api/health - Статус бекенда

- чтобы добавить город, укажите в параметрах запроса код населённого пункта(Accuweather) c ключом city
