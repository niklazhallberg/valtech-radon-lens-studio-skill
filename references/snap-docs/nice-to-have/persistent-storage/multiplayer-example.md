# Multiplayer Example

This feature is only available for use in Spectacles and Camera Kit.

Persistent Cloud Storage can be shared in a multiplayer session by simply passing in the `MultiplayerSession` provided by the `ConnectedLensesModule` to allow multiple participants to access the same data.

If you use a `ConnectedLensesModule`, you will only be able to create a Persistent Cloud Storage, after the user has connected to a Connected Lens Session.

These examples are designed to showcase the APIs, not to be a complete (questionably practical) experience.

## Creating a Multiplayer Game[​**](#creating-a-multiplayer-game "Copy to clipboard")

For this example, we will build on top of the Jaw Strengthening Coach Lens that we created in the [Single Player Persistent Cloud Storage example](/lens-studio/features/persistent-cloud-storage/solo-example.md). To make it multiplayer, we will supplement the code we have written with the [Creating a Connected Lens example](/lens-studio/features/connected-lenses/connected-lenses-example.md).

### The experience[​**](#the-experience "Copy to clipboard")

The Jaw Strengthening Coach Lens is an experience where users can record themselves opening their mouth, day after day, in order to strengthen their jaw.

Since training with others can be encouraging, we will add a multiplayer layer to this experience. In it, all participants can contribute to the number of Jaw Opens. However, to ensure each participant is still motivated, we will also track their own counter.

A practical version of this might leverage 3D Body Tracking to keep track of how many of some certain exercises you and your friends have done!

### Sharing our Store[​**](#sharing-our-store "Copy to clipboard")

After inviting other participants into our Lens using the `Connected Lens Module`, you can attach the `MultiplayerSession` when you first create the Cloud Store to make it available for everyone.

We'll modify our `createCloudStore` function to allow for a `session` parameter.

```
function createCloudStore(session) {
  const cloudStorageOptions = CloudStorageOptions.create();

  // We might want to pass in a session if we want
  // other people to have access to the Cloud Store
  if (session) {
    cloudStorageOptions.session = session;
  }

  script.cloudStorageModule.getCloudStore(
    cloudStorageOptions,
    onCloudStoreReady,
    onError
  );
}
```

Then, in response to our `ConnectedLensesModule` providing a session, we will pass it in to the store:

```
function onHostConnectedToMultiplayer(session) {
  print('Host Connected to Multiplayer Session');

  createCloudStore(session);
}

function onReceiverConnectedToMultiplayer(session) {
  print('Receiver Connected to Multiplayer Session');

  createCloudStore(session);
}
```

### Modifying our store functions for multiplayer[​**](#modifying-our-store-functions-for-multiplayer "Copy to clipboard")

Multiplayer Persistent Cloud Storage allows you to scope data you pass in so that it's only visible to you, or to the session.

In the solo experience, we hardcoded our Cloud Storage Options to use the scope: `StorageScope.User`. In a session with multiple participants, you can also use the `StorageScope.Session` scope so that the data will be visible/writable for everyone.

Thus: we'll modify each of our store related functions to additionally take a `scope` parameter which will be used to create the Cloud Storage options.

```
function getStore(scope, callback) {
  const getOptions = CloudStorageReadOptions.create();
  getOptions.scope = scope;

  script.store.getValue(
    key,
    getOptions,
    function onSuccess(key, value) {
      print('Get successfully: ' + key + ' ' + value);

      if (callback) {
        callback(value);
      }
    },
    function onError(code, message) {
      print('Error: ' + code + ' ' + message);
    }
  );
}

function modifyStore(scope, value, callback) {
  const writeOptions = CloudStorageWriteOptions.create();
  writeOptions.scope = scope;

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

function listStore(scope) {
  const listOptions = CloudStorageListOptions.create();
  listOptions.scope = scope;

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

Show more▼

### Modifying our experience for multiplayer[​**](#modifying-our-experience-for-multiplayer "Copy to clipboard")

Since we want to store information about both the total number of jaw opens, as well as each participant's, we will need to modify our experience logic to modify both the `StorageScope.Session` and `StorageScope.User` stores.

#### Modifying the Mouth Opened Event[​**](#modifying-the-mouth-opened-event "Copy to clipboard")

As with the helper functions, we will first modify our function to take in an additional `scope` parameter. We'll pass in this `scope` parameter to the helper function we created above.

```
function incrementJawOpen(scope) {
  function onGetCurrentJawOpenCount(value) {
    modifyStore(scope, ++value);
  }
  getStore(scope, onGetCurrentJawOpenCount);
}
```

Next, we can create a new function which calls this twice. One for each scope.

```
function onMouthOpened() {
  print('Attempt to increment value for session and user');
  incrementJawOpen(StorageScope.Session);
  incrementJawOpen(StorageScope.User);
}
```

Lastly, we will modify our MouthOpenedEvent to call this function instead:

```
script.createEvent('MouthOpenedEvent').bind(onMouthOpened);
```

#### Modifying the Tap Event[​**](#modifying-the-tap-event "Copy to clipboard")

Just as with setting our data, we will need to get the value of our store twice.

```
function onTap() {
  print('Attempt to list value for session and user');
  listStore(StorageScope.Session);
  listStore(StorageScope.User);
}
```

But as you recall, since our data is in the cloud and is returned asynchronously (aka may take time to be sent over the internet), we wouldn't be able to use this result at the same time--since they can arrive at different times.

One way you can handle this is by getting the second scope, after the first one, and then combining the results.

```
// First we get the session count
getStore(StorageScope.Session, function (sessionCount) {
  // Then once we get the callback, request user count
  getStore(StorageScope.User, function (userCount) {
    // Finally, Display the result.
    print('JawOpen Session: ' + sessionCount + '\n JawOpen User: ' + userCount);
  });
});
```

#### Two different ways to start[​**](#two-different-ways-to-start "Copy to clipboard")

Since our experience is multiplayer, there's actually two scenarios in which the game starts.

1. The host starts the game, and they need to set the initial value of both the `session` and `user` scope of `jawOpenedCount`
2. The receiver starts the game, and they ONLY need to set the initial value the `user` scope of `jawOpenedCount`--less they overwrite the sessions.

Thus we will modify the `onCloudStoreReady` function to account for these two entry points.

```
function onCloudStoreReady(store) {
  print('CloudStore created');
  script.store = store;

  if (script.isHost) {
    modifyStore(StorageScope.Session, 0, function () {
      modifyStore(StorageScope.User, 0, startGame);
    });
  } else {
    modifyStore(StorageScope.User, 0, startGame);
  }
}
```

Note, that like in the get example previously, since the host needs to call the modifyStore twice, the second call to `modifyStore` happens inside the callback of the first. After the second call, we then start the game.

This is important because the calls are asynchronous and thus, without chaining our functions like this, the start game might occur before one of the stores have finished!

### Next Steps[​**](#next-steps "Copy to clipboard")

At this point, you can modify the game to work for multiple participants.

Of course, this is only the beginning. Consider the following:

#### Making your Lens usable[​**](#making-your-lens-usable "Copy to clipboard")

Since you are making a very innovative experience, you will need to make sure your users understand what is happening and what to do. Don’t forget to spend some time considering how to onboard users to the game. Be sure to over communicate. In fact, that’s one of the main differences between a subpar, and an amazing experience!

Try making the game you built here more user friendly! Then tweet us as @SnapAR so we can check it out!

#### Testing your Lens[​**](#testing-your-lens "Copy to clipboard")

As with any game, make sure to run play tests with others to ensure that your experience works as intended.

But in addition to the game itself, multiplayer experience can be complicated because you need to synchronize data across multiple people. While the Persistent Cloud Storage simplifies a lot of this, you should make sure to test your Lens in a large number of scenarios.

Here are some example cases you should test out to make sure your Lens works as expected:

* Host joins,
* Host joins, Host leaves, Host joins
* Host joins, Receiver joins
* Host joins, Host leaves, Receiver joins
* Host joins, Receiver joins, Host leaves, Host joins
* Host joins, Receiver Joins, Receiver leaves, Receiver Joins

#### Expanding the game with Realtime Store[​**](#expanding-the-game-with-realtime-store "Copy to clipboard")

Consider adding more capabilities to the game by using Realtime Store

Amongst other many other features, with Realtime Store, you can get notification when anyone has changed the store. For example, you can trigger a confetti VFX whenever someone does the exercise.
