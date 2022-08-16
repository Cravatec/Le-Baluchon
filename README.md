# Le-Baluchon

**Le Baluchon** is a iPhone app code in Swift for iOS 13, 14, 15.

![This is an image](https://image.noelshack.com/fichiers/2022/33/2/1660671175-weather.gif)

The App have 3 pages:

1- Monney Converter for getting the daily rate change for Euro to Dollar

2- Translate, write on any language recognized by Google Translate and get the translation in English

3- Weather for getting the situation for New-York and Paris in Celsius and Fahrenheit

## Api Keys:
To build the project you need to subscribe to the API providers by:
- Fixer.io for the money exchange,
- Google for Translate part
- OpenWeatherMaps.

After that create a file APIKeys.swift with the Keys access:
```
struct Apikey
{
    static let weatherApiKey = ""
    static let fixerApiKey = ""
    static let translateApiKey = ""
}
```

The Gifs are created by Freepik: https://www.freepik.com/

The icons on the TabBar are created by Kosonicon https://www.flaticon.com/authors/kosonicon
