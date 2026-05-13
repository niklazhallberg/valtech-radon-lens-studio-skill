# Persistent Cloud Storage Overview

Persistent Cloud Storage allows you to store data in the cloud, such that it can persist across account logins, as well as be shared in a multiplayer session. It’s a great way to maintain the state of a Lens for a user. Each user has one Persistent Cloud Storage (Cloud Store) for each Lens.

**Persistent Cloud Storage** is a part of Lens Cloud, a collection of backend services, built on the same infrastructure that powers Snapchat.

To learn more about Lens Cloud and how to power a new generation of AR experiences that are more dynamic, useful, and interactive than ever before, please visit [Lens Cloud Overview](/lens-studio/features/lens-cloud/lens-cloud-overview.md)

If you’ve used the `store` related method in `MultiplayerSession`, you can think of using Persistent Cloud Storage very similarly. Alternatively, you can think of Persistent Cloud Storage as `PersistentStorageSystem`, except it’s backed by the cloud rather than on device.

## Creating a Persistent Cloud Storage[​**](#creating-a-persistent-cloud-storage "Copy to clipboard")

A user can access their Persistent Cloud Storage through the CloudStorage module. Each call to get the cloud store will return the same instance of a `Cloud Store`.

```
// @input Asset.CloudStorageModule cloudStorageModule
```

You can create a CloudStorageModule in the `Asset Browser panel > +`, then attach it to it to the scene object containing your script in the `Inspector` panel.

When getting a `CloudStore`, the user passes in a CloudStorageOptions. One of the settings that can be passed in is whether this `CloudStore` is shared with a `Session`. It is possible to `getCloudStore` multiple times. However, every time you call it, regardless of the options passed in, the same instance is returned.

```
const cloudStorageOptions = CloudStorageOptions.create();

script.cloudStorageModule.getCloudStore(
  cloudStorageOptions,
  onCloudStoreReady,
  onError
);

function onCloudStoreReady(store) {
  print('CloudStore created');
  script.store = store;
}

function onError(code, message) {
  print('Error: ' + code + ' ' + message);
}
```

The session property of a CloudStore is immutable once it is set. Practically speaking: if you want a multiplayer `CloudStore`, you **need** to create the `CloudStore` after you have received a `MultiplayerSession`.

When adding data to the `CloudStore`, you will pass in additional options that describe the permission of the data. For example: who can read, write, or list the data. These permissions can be scoped to: `User`: accessible only to the current user. `Session`: accessible to any user in the same MultiplayerSession.

```
const writeOptions = CloudStorageWriteOptions.create();
writeOptions.scope = StorageScope.User;

const key = 'myKey';
const value = Date.now();

script.store.setValue(
  key,
  value,
  writeOptions,
  function onSuccess() {
    print('stored successfully');
  },
  function onError(code, message) {
    print('Error: ' + code + ' ' + message);
  }
);
```

As shown in the code above, sharing a CloudStore without a MultiplayerSession attached would be ineffective, as only a single user would have access to the store. Therefore, it is not possible to share it in this case.

## Spatial Persistent Cloud Storage[​**](#spatial-persistent-cloud-storage "Copy to clipboard")

Spatial Persistent Cloud Storage is build on top of Persistent Cloud Storage which allows user to store/pin content against any location asset (Snap provided, custom or world). It is very much similar to cloud storage as it allow us to store information against a location asset in a privacy centric way.

A user can access their Spatial Persistent Cloud Storage through the `Location Cloud Storage Module`. Depending upon type of location asset, one or more cloud storage instances would be returned. For `world` location asset, depending upon the user location, we will return the closest location cloud store.

As user moves through in the world, `Location Cloud Storage Module` will fire events that return the nearest cloud store and related location asset to the user. Developers are expected to add the locationAsset to a `Located At Component`. This `Located At component` will position its SceneObject at exact position of the cloud store.

Therefore, if users want to persist content near this cloud store, it is recommended they add their content as a child of the locatedAtComponent’s SceneObject then store details about the content along with the offset from the locatedAtComponent.

This way, the next time a user accesses the store, all the store's values can be listed, and the content can be recreated and positioned using the stored offset from the cloud store.

You can create a `Location Cloud Storage Module` and `Location Asset` in the `Asset Browser` panel → `+`, then attach them to the script input field in the `Inspector` panel.

```
//@input Asset.Location locationAsset
//@input Asset.LocationCloudStorageModule locationCloudStorageModule

const options = LocationCloudStorageOptions.create();
options.location = script.locationAsset; //could be world, custom or snap.
options.onDiscoveredNearby.add(handleOnDiscoveredNearbyTo);
options.onError.add(handleOnError);

function handleOnDiscoveredNearbyTo(locationAsset, locationCloudStore) {
  // associate the locationAsset to a locatedAtComponent
  var locationStoreSceneObject =
    global.scene.createSceneObject('LocationStore');
  var locatedAtComponent =
    locationStoreSceneObject.createComponent('LocatedAtComponent');
  locatedAtComponent.location = locationAsset;

  var writeOptions = CloudStorageWriteOptions.create();
  writeOptions.scope = StorageScope.User;
  // persist content
  locationCloudStore.setValue(
    'test-key',
    'test-value',
    writeOptions,
    function onSuccess() {
      print('stored successfully');
    },
    function onError(code, message) {
      print('Error: ' + code + ' ' + message);
    }
  );
}

function handleOnError(locationAsset, code, description) {
  print('code:' + code + ' description:' + description);
}

script.locationCloudStorageModule.getNearbyLocationStores(options);
```

Show more▼

Currently, Spatial Persistence Cloud Storage does not support multiplayer sessions. We only support `user` scope for Spatial Persistent Cloud Storage.

## Restrictions[​**](#restrictions "Copy to clipboard")

When using Persistent Cloud Storage, some APIs will be restricted in order to protect the user’s privacy, similar to Connected Lenses. See [the "Restrictions" section from "Connected Lenses Overview"](/lens-studio/features/connected-lenses/connected-lenses-overview.md#Restrictions) for a complete list of disabled APIs.

## Examples[​**](#examples "Copy to clipboard")

Try making your first Peristent Cloud Storage Lenses with these following examples.

1. [Single Player Example](/lens-studio/features/persistent-cloud-storage/solo-example.md)
2. [Multiplayer Example using `ConnectedLensModule`](/lens-studio/features/persistent-cloud-storage/multiplayer-example.md)
3. [Spatial Persistence Example](/lens-studio/features/location-ar/spatial-persistence.md)
