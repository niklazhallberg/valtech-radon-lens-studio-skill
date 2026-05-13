# Snapchat Places API

Snapchat Places API for Lenses, which powers how different places interact in the Snapchat Map, offers Lens Developers a way to bringing the Snapchat map into a Lens. This will allow for developers to pull in data on places that are nearby them within a Lens.

`Snapchat Places API` module is available in APIs category of Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md);

![alt text](/assets/images/places-api-0-744519994e2240cd674b2ecd5bf2b8c1.png)

## Endpoints[​**](#endpoints "Copy to clipboard")

This section documents the API endpoints of the Snapchat Places API for use with the [`Remote Service Module`](/lens-studio/features/remote-apis/remote-service-module.md). This API can be used to get information from the Snapchat Map that users can interact with.

### `get_nearby_places`[​**](#get_nearby_places "Copy to clipboard")

List Nearby Places given a location.

This will give you the `place_id` which you can use with other APIs to get more information.

`lat` and `lng` will automatically be filled in by the Lens to allow you to get nearby places from a user. Thus, you can get a list of nearby places like so:

#### Parameters[​**](#parameters "Copy to clipboard")

| Name             | Type   | Description                                                                 |
| ---------------- | ------ | --------------------------------------------------------------------------- |
| `lat`            | Double | Latitude of the device. The default value is based on the user's location.  |
| `lng`            | Double | Longitude of the device. The default value is based on the user's location. |
| `gps_accuracy_m` | Double | Horizontal GPS accuracy of the device. The default is set to 65.            |
| `places_limit`   | int32  | Maximum number of nearby place results to return. Default is 10.            |

If you set gps\_accuracy to a value greater than 3000, then you may not return any venues. If you set value less than 3000, we will calculate the search radius by min(100m, req.radius + buffer), the buffer is 50 meters. If you don't set gps accuracy at all, we will use default radius of 65m.

#### Response[​**](#response "Copy to clipboard")

| Name            | Type        | Description                                             |
| --------------- | ----------- | ------------------------------------------------------- |
| `nearby_places` | NearbyPlace | Message that stores relevant information for the place. |

`NearbyPlace` provides the following information:

| Name            | Type   | Description                                       |
| --------------- | ------ | ------------------------------------------------- |
| `place_id`      | string | The unique identifier for the place.              |
| `name`          | string | Localized name of the place.                      |
| `rank`          | int32  | Rank order of the place returned.                 |
| `subtitle`      | string | Additional descriptive text for the place.        |
| `is_reportable` | bool   | Indicates if this place can be reported by users. |
| `placeTypeEnum` | string | The type of place it is (e.g. VENUE).             |
| `categoryId`    | uuid   | The ID of the category this place is under.       |
| `categoryName`  | string | The name of the category this place is under.     |

#### Example[​**](#example "Copy to clipboard")

```
function onReceiveNearbyPlaces(isError, places) {
  // Get the names and id of nearby places
  places.nearbyPlaces.map((place) => {
    print(place.name + ' ' + place.placeId);
  });
}

ApiModule.get_nearby_places(null, null, null, null, onReceiveNearbyPlaces);
```

### `get_places_profile`[​**](#get_places_profile "Copy to clipboard")

Renders the metadata needed to build Place Listings.

This will give you some of the basic data of a multiple places simultaneously, such as its opening hours, address, and phone numbers.

#### Parameters[​**](#parameters-1 "Copy to clipboard")

| Name        | Type   | Description                                                                              |
| ----------- | ------ | ---------------------------------------------------------------------------------------- |
| `place_ids` | String | List of place\_ids for which to retrieve place listings data.                            |
| `locale`    | String | *Optional*: Locale set in the request; if not in the header, defaults to `acceptHeader`. |

#### Response[​**](#response-1 "Copy to clipboard")

| Name             | Type         | Description                                                                          |
| ---------------- | ------------ | ------------------------------------------------------------------------------------ |
| `place_profiles` | PlaceProfile | List of PlaceProfile metadata respective to the IDs passed. Order is not maintained. |

#### Example[​**](#example-1 "Copy to clipboard")

You can get the opening hours of nearby places using the `place_profile`.

```
function onReceiveNearbyPlaces(isError, places) {
  const listOfPlaceIds = JSON.stringify(
    places.nearbyPlaces.map((p) => p.placeId)
  );
  ApiModule.get_places_profile(
    listOfPlaceIds,
    null,
    function (isError, placeProfiles) {
      print(JSON.stringify(placeProfiles));
    }
  );
}

ApiModule.get_nearby_places(null, null, null, null, onReceiveNearbyPlaces);
```

### `get_place`[​**](#get_place "Copy to clipboard")

Renders the complete metadata associated with the place.

You can use this API to get as much information as possible on a single place, including latitude and longitude.

#### Parameters[​**](#parameters-2 "Copy to clipboard")

| Name       | Type   | Description                                          |
| ---------- | ------ | ---------------------------------------------------- |
| `place_id` | String | place\_id for which to retrieve place listings data. |

#### Response[​**](#response-2 "Copy to clipboard")

| Name    | Type  | Description     |
| ------- | ----- | --------------- |
| `place` | Place | Place metadata. |

#### Examples[​**](#examples "Copy to clipboard")

You can get detailed information on the highest ranked nearby place like so:

```
function onReceiveNearbyPlaces(isError, places) {
  ApiModule.get_place(
    places.nearbyPlaces[0].placeId,
    function (isError, placeMetadata) {
      print(JSON.stringify(placeMetadata));
    }
  );
}

ApiModule.get_nearby_places(null, null, null, null, onReceiveNearbyPlaces);
```

You can get latitude and longitude information for each place like so:

```
function onReceiveNearbyPlaces(response) {
  try {
    print('Full Response: ' + response.bodyAsString());

    let places = response.bodyAsJson();

    if (places && Array.isArray(places.nearbyPlaces)) {
      places.nearbyPlaces.forEach((place) => {
        ApiModule.get_place(place.placeId, function (isError, response) {
          if (isError) {
            print(`Error fetching metadata for ${place.name}`);
            return;
          }

          const placeMetadata = response.bodyAsJson();
          print(`Metadata for ${place.name}: ${JSON.stringify(placeMetadata)}`);

          if (
            placeMetadata.place &&
            placeMetadata.place.geometry &&
            placeMetadata.place.geometry.centroid
          ) {
            const latitude = placeMetadata.place.geometry.centroid.lat;
            const longitude = placeMetadata.place.geometry.centroid.lng;
            print(
              `Coordinates for ${place.name}: Latitude: ${latitude}, Longitude: ${longitude}`
            );
          } else {
            print(`Coordinates not found for ${place.name}`);
          }
        });
      });
    } else {
      print('No nearby places found or nearbyPlaces is undefined.');
    }
  } catch (error) {
    print('Error parsing places: ' + error.message);
  }
}
```

Show more▼
