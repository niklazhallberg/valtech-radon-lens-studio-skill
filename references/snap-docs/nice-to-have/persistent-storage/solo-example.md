# Single Player "Solo" Example

Persistent Cloud Storage is a great way to build a Lens that you want a user to come back with over, and over again. Let’s take a look at an example of how you would make an experience with Persistent Cloud Storage.

This guide will take a look at an experience that does **not** use a `MultiplayerSession` (i.e. does not involve a `ConnectedLensModule`). After finishing this guide, please visit the [Multiplayer Example](/lens-studio/features/persistent-cloud-storage/multiplayer-example.md) to learn how you can use Persistent Cloud Storage with multiple participants.

## Creating a Single Player Game[​**](#creating-a-single-player-game "Copy to clipboard")

In this example, you will create a Jaw Strengthening Coach Lens, where we want the users to record themselves opening their mouth, day after day, in order to strengthen their jaw.

This example is designed to showcase how the APIs function from end to end and not a full practical Lens experience.

### Setting up the Persistent Cloud Storage[​**](#setting-up-the-persistent-cloud-storage "Copy to clipboard")

After creating a script and attaching it to an object, you need to add an input for Cloud Storage Module, so that the Lens know that you need this resource.

```
// @input Asset.CloudStorageModule cloudStorageModule
```

You can create a `CloudStorageModule` in the `Asset Browser` panel and pressing **+**, then attach it to it to the scene object containing your script in the **Inspector** panel.

Next, we will use this module to get access to our Persistent Cloud Storage. Since we don’t need to share this storage with anyone else, we can `getCloudStore` without passing in a `session` to our options.

In addition, we will create a response for when our store is created, as well as if we had an error.

```
function createCloudStore(session) {
  const cloudStorageOptions = CloudStorageOptions.create();
  script.cloudStorageModule.getCloudStore(
    cloudStorageOptions,
    onCloudStoreReady,
    onError
  );
}
```

We will create a generic error that will print the error message that we can use in many places:

```
function onError(code, message) {
  print('Error: ' + code + ' ' + message);
}
```

When our `CloudStore` is ready, we will store it in our `script` object so that we can access the store in many other places.

```
function onCloudStoreReady(store) {
  print('CloudStore created');
  script.store = store;

  // When we have our store we can add our first data.
  // Once we've successfully done so, we can start ourgame.
  modifyStore(0, startGame);
}
```

### Reading and writing from the store[​**](#reading-and-writing-from-the-store "Copy to clipboard")

With our store ready, let's create some helper functions for us to read and write from it!

Since our game is relatively simple--we just need to store how many times the user has opened or closed their jaw--we will store a variable named `key` for us to use whenever we want to get data.

```
const key = 'jawOpenedCount';
```

#### Getting Data from the store[​**](#getting-data-from-the-store "Copy to clipboard")

Let's create a function to get data from our store. First we need to create

Since our store is in the cloud, our call is "asynchronous". Meaning, that it may take some time for us to get the data back over the internet. In order to account for this, we will allow our callers to pass in a "callback" function that can can be called when the data is returned to keep the program going.

```
function getStore(callback) {
  // our get code
}
```

In this function, we will create a `CloudStorageReadOptions` to describe whether this data is in our `user`, or `session` scope. Since this is a solo experience, we can only get it from our `user` scope.

```
const getOptions = CloudStorageReadOptions.create();
getOptions.scope = StorageScope.User;
```

Next, we will use this option to get our data. To do this, we call `getValue` method from the `script.store` we saved earlier. This call takes 5 parameters.

* The key which contains our data
* The options (which we just described)
* The function to call when data is retrieved. Here, we call in the callback value we passed in)
* The function to call if an error occurs. We will use the general `onError` we created earlier.

```
script.store.getValue(
  key,
  getOptions,
  function onSuccess(key, value) {
    print('Get successfully: ' + key + ' ' + value);

    if (callback) {
      callback(value);
    }
  },
  onError
);
```

#### Setting value to the store[​**](#setting-value-to-the-store "Copy to clipboard")

We can do a very similar function to set the store. The key difference here is that we also pass in the value we want to store. It has 6 parameters.

* The key which contains our data
* The value which will be mapped to the key.
* The options (which we just described)
* The function to call when data is retrieved. Here, we call in the callback value we passed in)
* The function to call if an error occurs. We will use the general `onError` we created earlier.

```
function modifyStore(value, callback) {
  const writeOptions = CloudStorageWriteOptions.create();
  writeOptions.scope = StorageScope.User;

  script.store.setValue(
    key,
    value,
    writeOptions,
    function onSuccess() {
      print('Stored successfully: ' + key + ' ' + value);

      if (callback) {
        callback(value);
      }
    },
    function onError(code, message) {
      print('Error: ' + code + ' ' + message);
    }
  );
}
```

#### Listing all the key and values in our store[​**](#listing-all-the-key-and-values-in-our-store "Copy to clipboard")

In addition to getting and storing specific data, we can list all the items in our store.

This function is very similar to the previous two, except that it doesn't take in a key or value. Moreover, the return function will provide an array of results which contain key and value data.

```
function listStore() {
  const listOptions = CloudStorageListOptions.create();
  listOptions.scope = StorageScope.User;

  script.store.listValues(
    listOptions,
    function (results, cursor) {
      print('Listed Succesfully:');
      // Results are returned as a list of [key, value] tuples
      for (var i = 0; i < results.length; ++i) {
        const key = results[i][0];
        const value = results[i][1];
        print(' - key: ' + key + ' value: ' + value);
      }
    },
    onError
  );
}
```

### Creating the game interaction[​**](#creating-the-game-interaction "Copy to clipboard")

Now that we can get and set data from our store, we can create our game!

We'll create a function that will start our game. In it we will do two things:

* when the user's mouth opened (`MouthOpenedEvent`), we will increment our jaw counter.
* when the user taps the screen (`TapEvent`), we list all the values in our store so we can see how the user is doing.

We do this by binding functions to these events.

```
function startGame() {
  print('Start Game');

  script.createEvent('MouthOpenedEvent').bind(incrementJawOpen);
  script.createEvent('TapEvent').bind(listStore);
}
```

We'll create an `incrementJawOpen` function to respond to the user opening their mouth. Incrementing will be done in two steps. First we will get data from the store, and once we know the value, we will save the data again, incrementing one.

Thankfully, we wrote the helper functions earlier that can call a function when our data is returned. So all we need to do, is pass the second function to the first.

```
function incrementJawOpen() {
  // Store the data
  function onGetCurrentJawOpenCount(value) {
    // Increment the current value
    modifyStore(++value);
  }

  // Get the data, and when it's returned, call `onGetCurrentJawOpenCount`
  getStore(onGetCurrentJawOpenCount);
}
```

Since we already created a list function earlier, all we need to do is bind it to the tap event!

Try creating your own functions to display the result of the scores to the user instead! You can use the list function, or the get function we created earlier.

Find the whole script here.

```
// @input Asset.CloudStorageModule cloudStorageModule

function createCloudStore(session) {
  const cloudStorageOptions = CloudStorageOptions.create();
  script.cloudStorageModule.getCloudStore(
    cloudStorageOptions,
    onCloudStoreReady,
    onError
  );
}

function onError(code, message) {
  print('Error: ' + code + ' ' + message);
}

function onCloudStoreReady(store) {
  print('CloudStore created');
  script.store = store;

  // When we have our store we can add our first data.
  // Once we've successfully done so, we can start ourgame.
  modifyStore(0, startGame);
}

const key = 'jawOpenedCount';

function getStore(callback) {
  const getOptions = CloudStorageReadOptions.create();
  getOptions.scope = StorageScope.User;

  script.store.getValue(
    key,
    getOptions,
    function onSuccess(key, value) {
      print('Get successfully: ' + key + ' ' + value);

      if (callback) {
        callback(value);
      }
    },
    onError
  );
}

function modifyStore(value, callback) {
  const writeOptions = CloudStorageWriteOptions.create();
  writeOptions.scope = StorageScope.User;

  script.store.setValue(
    key,
    value,
    writeOptions,
    function onSuccess() {
      print('Stored successfully: ' + key + ' ' + value);

      if (callback) {
        callback(value);
      }
    },
    function onError(code, message) {
      print('Error: ' + code + ' ' + message);
    }
  );
}

function listStore() {
  const listOptions = CloudStorageListOptions.create();
  listOptions.scope = StorageScope.User;

  script.store.listValues(
    listOptions,
    function (results, cursor) {
      print('Listed Succesfully:');
      // Results are returned as a list of [key, value] tuples
      for (var i = 0; i < results.length; ++i) {
        const key = results[i][0];
        const value = results[i][1];
        print(' - key: ' + key + ' value: ' + value);
      }
    },
    onError
  );
}

function startGame() {
  script.createEvent('MouthOpenedEvent').bind(incrementJawOpen);
  script.createEvent('TapEvent').bind(listStore);
}
function incrementJawOpen() {
  // Store the data
  function onGetCurrentJawOpenCount(value) {
    // Increment the current value
    modifyStore(++value);
  }

  // Get the data, and when it's returned, call `onGetCurrentJawOpenCount`
  getStore(onGetCurrentJawOpenCount);
}

createCloudStore();
```

Show more▼

Now that we created our solo game, let's explore how we can make a [Multiplayer](/lens-studio/features/persistent-cloud-storage/multiplayer-example.md) Version of it.
