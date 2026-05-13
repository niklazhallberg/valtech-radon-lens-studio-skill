# AccuWeather API

Here at Snap we built a custom API that allows for developers to create with AccuWeather APIs more efficiently. Rather than communicating and developing directly with AccuWeather APIs, you will be developing with the APIs of Snap’s custom service which communicates with AccuWeather APIs. Please follow the below API documentation to build Lenses with Weather APIs.

`AccuWeather API` module is available in APIs category of Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md); ![alt text](/assets/images/weather-api-11-6d060db43e78c85d74de64c8e6435e54.png)

You can find an example using the AccuWeather API [here](/lens-studio/features/remote-apis/remote-apis-templates/weather-api.md).

## Endpoints[​**](#endpoints "Copy to clipboard")

This section documents the API endpoints of the AccuWeather API for use with the [`Remote Service Module`](/lens-studio/features/remote-apis/remote-service-module.md). This API can be used to get current weather conditions as well as forecasts.

### Current Condition[​**](#current-condition "Copy to clipboard")

Remote service module endpoint: current\_condition

#### Parameters[​**](#parameters "Copy to clipboard")

| Name   | Type   | Description                                                                                   |
| ------ | ------ | --------------------------------------------------------------------------------------------- |
| `Body` | `JSON` | Coordinate object with latitude and longitude. Example: `{"lat": LATITUDE, "lng": LONGITUDE}` |

#### Response[​**](#response "Copy to clipboard")

| Name                | Type       | Description                                                                     |
| ------------------- | ---------- | ------------------------------------------------------------------------------- |
| `current_condition` | `Weather`  | A weather object representing the current condition.                            |
| `address`           | `Address`  | A localized representation of the input coordinates.                            |
| `time_zone`         | `TimeZone` | TimeZone data for the requested location. Null if the timezone cannot be found. |

### Hourly Forecast[​**](#hourly-forecast "Copy to clipboard")

Remote service module endpoint: hourly\_forecast

#### Parameters[​**](#parameters-1 "Copy to clipboard")

| Name   | Type   | Description                                                                                   |
| ------ | ------ | --------------------------------------------------------------------------------------------- |
| `Body` | `JSON` | Coordinate object with latitude and longitude. Example: `{"lat": LATITUDE, "lng": LONGITUDE}` |

#### Response[​**](#response-1 "Copy to clipboard")

| Name              | Type        | Description                                                                                                        |
| ----------------- | ----------- | ------------------------------------------------------------------------------------------------------------------ |
| `hourly_forecast` | `Weather[]` | An array of 12 weather objects representing the forecast. Each entry in the array represents an hour of forecasts. |
| `address`         | `Address`   | A localized representation of the input coordinates                                                                |
| `time_zone`       | `TimeZone`  | TimeZone data for the requested location. Null if the timezone cannot be found.                                    |

### Daily Forecast[​**](#daily-forecast "Copy to clipboard")

Remote service module endpoint: daily\_forecast

#### Parameters[​**](#parameters-2 "Copy to clipboard")

| Name   | Type   | Description                                                                                   |
| ------ | ------ | --------------------------------------------------------------------------------------------- |
| `Body` | `JSON` | Coordinate object with latitude and longitude. Example: `{"lat": LATITUDE, "lng": LONGITUDE}` |

#### Response[​**](#response-2 "Copy to clipboard")

| Name             | Type              | Description                                                                                             |
| ---------------- | ----------------- | ------------------------------------------------------------------------------------------------------- |
| `daily_forecast` | `DailyForecast[]` | An array of 5 daily forecast objects which contain weather forecasts for the day and night of each day. |
| `address`        | `Address`         | A localized representation of the input coordinates                                                     |
| `time_zone`      | `TimeZone`        | TimeZone data for the requested location. Null if the timezone cannot be found.                         |

### Current Condition and Forecast[​**](#current-condition-and-forecast "Copy to clipboard")

Remote service module endpoint: current\_condition\_and\_forecast

#### Parameters[​**](#parameters-3 "Copy to clipboard")

| Name   | Type   | Description                                                                                   |
| ------ | ------ | --------------------------------------------------------------------------------------------- |
| `Body` | `JSON` | Coordinate object with latitude and longitude. Example: `{"lat": LATITUDE, "lng": LONGITUDE}` |

#### Response[​**](#response-3 "Copy to clipboard")

| Name                | Type              | Description                                                                                                        |
| ------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------ |
| `current_condition` | `Weather`         | A weather object representing the current condition.                                                               |
| `hourly_forecast`   | `Weather[]`       | An array of 12 weather objects representing the forecast. Each entry in the array represents an hour of forecasts. |
| `daily_forecast`    | `DailyForecast[]` | An array of 5 daily forecast objects which contain weather forecasts for the day and night of each day.            |
| `address`           | `Address`         | A localized representation of the input coordinates.                                                               |
| `time_zone`         | `TimeZone`        | TimeZone data for the requested location. Null if the timezone cannot be found.                                    |

## Air Quality API Endpoints[​**](#air-quality-api-endpoints "Copy to clipboard")

This section documents API endpoints for the Plume Labs by AccuWeather air quality API.

### Current Conditions and Forecast Air Quality[​**](#current-conditions-and-forecast-air-quality "Copy to clipboard")

Remote service module endpoint: current\_air\_quality

#### Parameters[​**](#parameters-4 "Copy to clipboard")

| Name   | Type   | Description                                                                                   |
| ------ | ------ | --------------------------------------------------------------------------------------------- |
| `Body` | `JSON` | Coordinate object with latitude and longitude. Example: `{"lat": LATITUDE, "lng": LONGITUDE}` |

#### Response[​**](#response-4 "Copy to clipboard")

| Name         | Type         | Description                                                                     |
| ------------ | ------------ | ------------------------------------------------------------------------------- |
| `airQuality` | `AirQuality` | Air quality data for the requested location.                                    |
| `address`    | `Address`    | A localized representation of the input coordinates.                            |
| `time_zone`  | `TimeZone`   | TimeZone data for the requested location. Null if the timezone cannot be found. |

## Types[​**](#types "Copy to clipboard")

This section documents the data types the AccuWeather API returns.

### Weather (JSON)[​**](#weather-json "Copy to clipboard")

| Field                       | Type                | Description                                                                                                                |
| --------------------------- | ------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `condition`                 | `Condition`         | The weather condition.                                                                                                     |
| `detailed_condition`        | `DetailedCondition` | The detailed weather condition.                                                                                            |
| `temperature_f`             | `number`            | Temperature in Fahrenheit.                                                                                                 |
| `epoch_ms`                  | `number`            | The epoch in milliseconds of the forecast or current condition this weather object represents.                             |
| `relative_humidity_perc`    | `number`            | Relative humidity as a percent. This will only be set for CurrentConditions. Hourly and Daily Forecasts will not set this. |
| `pressure_mb`               | `number`            | Pressure in millibars. This will only be set for CurrentConditions. Hourly and Daily Forecasts will not set this.          |
| `wind_speed`                | `number`            | The speed of the wind in kilometers per hour.                                                                              |
| `precipitation_probability` | `number`            | Precipitation probability. Only set for Daily and Hourly Forecasts, ranging from 0 to 100.                                 |
| `sunrise_epoch_sec`         | `number`            | The seconds since epoch of the sunrise. Only set in DailyForecast objects.                                                 |
| `sunset_epoch_sec`          | `number`            | The seconds since epoch of the sunset. Only set in DailyForecast objects.                                                  |

### DailyForecast (JSON)[​**](#dailyforecast-json "Copy to clipboard")

| Field   | Type      | Description                        |
| ------- | --------- | ---------------------------------- |
| `day`   | `Weather` | Weather forecast during the day.   |
| `night` | `Weather` | Weather forecast during the night. |

### Condition (Enum)[​**](#condition-enum "Copy to clipboard")

| Name                   | Type     | Description                                                 |
| ---------------------- | -------- | ----------------------------------------------------------- |
| `UNKNOWN`              | `String` | The weather condition is unknown.                           |
| `CLEAR_NIGHT`          | `String` | Forecast or condition includes being clear at night.        |
| `CLOUDY`               | `String` | Forecast or condition includes cloudy weather.              |
| `HAIL`                 | `String` | Forecast or condition includes hail.                        |
| `LIGHTNING`            | `String` | Forecast or condition includes lightning.                   |
| `LOW_VISIBILITY`       | `String` | Forecast or condition includes low visibility.              |
| `PARTIAL_CLOUDY`       | `String` | Forecast or condition includes partial cloudiness.          |
| `PARTIAL_CLOUDY_NIGHT` | `String` | Forecast or condition includes partial cloudiness at night. |
| `RAINY`                | `String` | Forecast or condition includes rain.                        |
| `SNOW`                 | `String` | Forecast or condition includes snow.                        |
| `SUNNY`                | `String` | Forecast or condition includes sun.                         |
| `WINDY`                | `String` | Forecast or condition includes higher than usual winds.     |
| `HOT`                  | `String` | Forecast or condition includes hotter than usual weather.   |
| `COLD`                 | `String` | Forecast or condition includes colder than usual weather.   |

### DetailedCondition (Enum)[​**](#detailedcondition-enum "Copy to clipboard")

| Name                                | Type     | Description                                                                 |
| ----------------------------------- | -------- | --------------------------------------------------------------------------- |
| `UNKNOWN`                           | `String` | The weather condition is unknown.                                           |
| `SUNNY`                             | `String` | Forecast or condition is sunny.                                             |
| `CLOUDY`                            | `String` | Forecast or condition includes cloudy weather.                              |
| `RAINY`                             | `String` | Forecast or condition includes rain.                                        |
| `MOSTLY_CLOUDY_DAY`                 | `String` | Forecast or condition is mostly cloudy.                                     |
| `MOSTLY_CLOUDY_NIGHT`               | `String` | Forecast or condition at night is mostly cloudy.                            |
| `SNOW`                              | `String` | Forecast or condition includes snow.                                        |
| `HOT`                               | `String` | Forecast or condition includes hotter than usual weather.                   |
| `COLD`                              | `String` | Forecast or condition includes colder than usual weather.                   |
| `WINDY`                             | `String` | Forecast or condition includes higher than usual winds.                     |
| `CLEAR`                             | `String` | Forecast or condition is clear.                                             |
| `MOSTLY_CLEAR`                      | `String` | Forecast or condition is mostly clear.                                      |
| `PARTLY_CLOUDY`                     | `String` | Forecast or condition is partially cloudy.                                  |
| `INTERMITTENT_CLOUDS_DAY`           | `String` | Forecast or condition includes intermittent clouds during the day.          |
| `INTERMITTENT_CLOUDS_NIGHT`         | `String` | Forecast or condition includes intermittent clouds during the night.        |
| `MOSTLY_SUNNY`                      | `String` | Forecast or condition is mostly sunny.                                      |
| `PARTLY_SUNNY`                      | `String` | Forecast or condition is partly sunny.                                      |
| `RAIN_SHOWERS`                      | `String` | Forecast or condition includes rain showers.                                |
| `HAZY_SUNSHINE`                     | `String` | Forecast or condition includes hazy sunshine.                               |
| `OVERCAST`                          | `String` | Forecast or condition includes an overcast.                                 |
| `FOGGY`                             | `String` | Forecast or condition is foggy.                                             |
| `MOSTLY_CLOUDY_WITH_SHOWERS_DAY`    | `String` | Forecast or condition is mostly cloudy with showers during the day.         |
| `MOSTLY_CLOUDY_WITH_SHOWERS_NIGHT`  | `String` | Forecast or condition is mostly cloudy with showers during the night.       |
| `PARTLY_SUNNY_WITH_SHOWERS`         | `String` | Forecast or condition is partly sunny with showers.                         |
| `THUNDERSTORMS`                     | `String` | Forecast or condition includes thunderstorms.                               |
| `MOSTLY_CLOUDY_WITH_T_STORMS_DAY`   | `String` | Forecast or condition is mostly cloudy with thunderstorms during the day.   |
| `MOSTLY_CLOUDY_WITH_T_STORMS_NIGHT` | `String` | Forecast or condition is mostly cloudy with thunderstorms during the night. |
| `PARTLY_SUNNY_WITH_T_STORMS`        | `String` | Forecast or condition is partly sunny with thunderstorms.                   |
| `FLURRIES`                          | `String` | Forecast or condition includes snow flurries.                               |
| `MOSTLY_CLOUDY_WITH_FLURRIES_DAY`   | `String` | Forecast or condition is mostly cloudy with flurries during the day.        |
| `MOSTLY_CLOUDY_WITH_FLURRIES_NIGHT` | `String` | Forecast or condition is mostly cloudy with flurries during the night.      |
| `PARTLY_SUNNY_WITH_FLURRIES`        | `String` | Forecast or condition is partly sunny with flurries.                        |
| `MOSTLY_CLOUDY_WITH_SNOW_DAY`       | `String` | Forecast or condition is mostly cloudy with snow during the day.            |
| `MOSTLY_CLOUDY_WITH_SNOW_NIGHT`     | `String` | Forecast or condition is mostly cloudy with snow during the night.          |
| `HAIL`                              | `String` | Forecast or condition includes hail.                                        |
| `SLEET`                             | `String` | Forecast or condition includes sleet.                                       |
| `FREEZING_RAINING`                  | `String` | Forecast or condition includes freezing rain.                               |
| `RAIN_AND_SNOW`                     | `String` | Forecast or condition includes both rain and snow.                          |
| `HAZY_MOONLIGHT`                    | `String` | Forecast or condition includes hazy moonlight.                              |
| `PARTLY_CLOUDY_WITH_SHOWERS`        | `String` | Forecast or condition is partly cloudy with rain showers.                   |
| `PARTLY_CLOUDY_WITH_T_STORMS`       | `String` | Forecast or condition is partly cloudy with thunderstorms.                  |

### Address (JSON)[​**](#address-json "Copy to clipboard")

| Field               | Type     | Description                                                                                                           |
| ------------------- | -------- | --------------------------------------------------------------------------------------------------------------------- |
| `admin_area_1`      | `String` | First level of administration. In the US, this is the state. This field is optional and may not always be included.   |
| `admin_area_2`      | `String` | Second level of administration. In the US, this is the county. This field is optional and may not always be included. |
| `admin_area_3`      | `String` | Third level of administration. This field is optional and may not always be included.                                 |
| `admin_area_4`      | `String` | Fourth level of administration. This field is optional and may not always be included.                                |
| `admin_area_5`      | `String` | Fifth level of administration. This field is optional and may not always be included.                                 |
| `locality`          | `String` | City or town for the input latitude and longitude.                                                                    |
| `sublocality`       | `String` | Level below locality for a smaller geographic area.                                                                   |
| `colloquial_area`   | `String` | Colloquial name for the area. This field is optional and may not always be included.                                  |
| `neighborhood`      | `String` | Name for the neighborhood.                                                                                            |
| `premise`           | `String` | Included if a small area is named, e.g., 'Times Square'.                                                              |
| `subpremise`        | `String` | Included if the latitude and longitude have a name for a single entity.                                               |
| `point_of_interest` | `String` | Named point of interest such as "Empire State Building". This field is optional and may not always be included.       |
| `country`           | `String` | Country for the input latitude and longitude.                                                                         |
| `country_code`      | `String` | Country code for the input latitude and longitude. This field is optional and may not always be included.             |
| `postal_code`       | `String` | Postal code for the input latitude and longitude. This field is optional and may not always be included.              |
| `macro_area`        | `String` | The continent, ocean, or marine area for the input latitude and longitude.                                            |

### TimeZone (JSON)[​**](#timezone-json "Copy to clipboard")

| Field      | Type     | Description                                                           |
| ---------- | -------- | --------------------------------------------------------------------- |
| `id`       | `String` | Timezone ID, for example: `America/New_York`, `Asia/Hong_Kong`.       |
| `offset_s` | `Number` | Time offset in seconds, for example: `-18000` for `America/New_York`. |

### Air Quality (JSON)[​**](#air-quality-json "Copy to clipboard")

| Field                   | Type     | Description                                                                                             |
| ----------------------- | -------- | ------------------------------------------------------------------------------------------------------- |
| `epochMs`               | `String` | The current time since epoch in milliseconds.                                                           |
| `overallIndex`          | `Number` | Air quality rating on a scale set by local regulating bodies. Scales can vary widely based on location. |
| `overallPlumeLabsIndex` | `Number` | Air quality rating on a scale set by Plume Labs.                                                        |
| `dominantPollutant`     | `String` | The dominant air pollutant.                                                                             |
| `category`              | `String` | One-word description of the air quality in the requested language.                                      |
| `categoryColor`         | `Number` | A unique color assigned to the level of air quality.                                                    |
