# Le-Baluchon

**Le Baluchon** is an iPhone app, code in Swift for iOS 13, 14, 15.

![This is an image](https://image.noelshack.com/fichiers/2022/33/2/1660671175-weather.gif)

The App has 3 pages:

1- Money: Converter for getting the daily exchange rate from euros to dollars

2- Translate: Write in any language recognized by Google Translate and get the translation in English

3- Weather: Get the weather forecast for New York and Paris in Celsius and in Fahrenheit

## Api Keys:
To build the project you need to subscribe to the API providers by:
- Fixer.io for the exchange rate,
- Google for the translation
- OpenWeatherMaps.

After that, create a APIKeys.swift file with your Keys access:
```
struct Apikey
{
    static let weatherApiKey = ""
    static let fixerApiKey = ""
    static let translateApiKey = ""
}
```

The GIFs are created by Freepik: https://www.freepik.com/

The icons on the TabBar are created by Kosonicon https://www.flaticon.com/authors/kosonicon
