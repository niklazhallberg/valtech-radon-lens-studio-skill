# AccuWeather API Example

The `Weather API - AccuWeather` demonstrates how to use a [Remote Service Module](/lens-studio/features/remote-apis/remote-service-module.md) to get weather conditions and forecasts for locations around the world using the AccuWeather API. This guide will show you how to use the API to get current weather conditions, as well as hourly and daily forecasts and display them in your lenses. Locations are input to the API as coordinates.

The `AccuWeather` API Module is available separately in APIs category of Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). You can read about all the functionality available in the AccuWeather API [here](/lens-studio/features/remote-apis/weather-api-documentation.md).

## Weather API - AccuWeather Asset[​**](#weather-api---accuweather-asset "Copy to clipboard")

### Import from Asset Library[​**](#import-from-asset-library "Copy to clipboard")

You can find the `Weather API - AccuWeather` asset in the Lens Studio Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) to learn more about using assets from the Asset Library. Once imported, locate the `Weather API - AccuWeather` prefab in the Asset Browser. Drag and drop it under an Orthographic Camera in the Scene panel. If you don't have an Orthographic Camera, add one by clicking the "+" button in the Scene panel and searching for "Orthographic Camera." To edit the asset's contents, right-click the prefab in the Asset Browser and select `Unpack for Editing`. Click [here](/lens-studio/features/package-management/asset-packages-introduction.md) to learn more about Asset Packages.

[](/img/lens-studio/weather-api_image1.webm)

To respect user privacy you cannot currently get access to the users location while using the remote service module. You can read more about these restrictions [here](/lens-studio/features/remote-apis/remote-service-module.md).

## Example Walkthrough[​**](#example-walkthrough "Copy to clipboard")

The `Weather API - AccuWeather` asset includes three examples:

* [A Multiple Day Forecast](#multiple-day-forecast) which shows the forecast for 5 days.
* A [Current Condition](#current-condition-example) example which shows the current weather condition
* A [Simple Example](#print-hourly-forecast) which prints the hourly forecast.

The first two examples both use `Weather - Single Day [EDIT ME]` prefab which can be customized with new icons or fonts.

### Multiple Day Forecast[​**](#multiple-day-forecast "Copy to clipboard")

The multiple day forecast example uses the `Weather - Single Day` prefab to display 5 days of weather forecast.

![multi day example](/assets/images/weather-api-5-09ff39e13ac7b3b8debeae9a4d511092.png)

The `MultipleDayForecastController` script is used to populate each `Weather - Single Day` prefab with the corresponding data.

![multi day example](/assets/images/weather-api-6-0340ebdb3331a51c12bafc73c87603c9.png)

#### Inputs[​**](#inputs "Copy to clipboard")

* **AccuWeather API:** The AccuWeatherAPI script to use the API.
* **City:** The city name to use for the forecast. You can view or add cities by their coordinates in `ExampleCities.js`.
* **UI Weather Days:** The input `UIWeatherDay` for each day of the forecast. Each `Weather - Single Day` prefab has a `UIWeatherDay` script to display weather information.
* **Loading Object:** An optional object to enable/disable based on whether the API request is loading.
* **Loading Time:** How long to delay before showing the loading UI.

### Current Condition[​**](#current-condition "Copy to clipboard")

The current condition example uses the `Weather - Single Day` prefab to display a single day of weather conditions.

![current condition example](/assets/images/weather-api-7-4b28e055247c54697f7bd8291c1ea2a5.png)

The `CurrentConditionController` script is used to populate each `Weather - Single Day` prefab with the corresponding data.

![current condition script](/assets/images/weather-api-8-434e4a16a5d03a4e669ae9b2483a7c61.png)

### Inputs[​**](#inputs-1 "Copy to clipboard")

* **AccuWeather API:** The AccuWeatherAPI script to use the API.
* **City:** The city name to use for the forecast. You can view or add cities by their coordinates in `ExampleCities.js`.
* **UI Weather Day:** The input `UIWeatherDay` to use to display the weather.
* **Loading Object:** An optional object to enable/disable based on whether the API request is loading.
* **Loading Time:** How long to delay before showing the loading UI.

### Print Hourly Forecast[​**](#print-hourly-forecast "Copy to clipboard")

The print hourly forecast example calls the hourly forecast endpoint of the AccuWeather API and prints the forecasted conditions.

![hourly forecast script](/assets/images/weather-api-9-0c591aaa0e5e6f510ed910af12ca0000.png)

#### Inputs[​**](#inputs-2 "Copy to clipboard")

* **AccuWeather API:** The AccuWeatherAPI script to use the API.
* **City:** The city name to use for the forecast. You can view or add cities by their coordinates in `ExampleCities.js`.

### Adding a custom city[​**](#adding-a-custom-city "Copy to clipboard")

In order to add a custom city for use as inputs to the various examples simply add the city name and its coordinates to `ExampleCities.js.`

![add custom city](/assets/images/weather-api-10-b82be9ef33385e85471c258b96e863cc.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
