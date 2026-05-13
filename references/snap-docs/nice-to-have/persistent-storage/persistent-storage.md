# Persistent Storage

## Overview[​**](#overview "Copy to clipboard")

By default, script variables retain their value only while the Lens is active. When a user closes and reopens a Lens, all script variables are reset. The [Persistent Storage system](/api/lens-studio/Classes/ScriptObjects.md#PersistentStorageSystem) enables you to create Lenses that can selectively read and write data between Lens sessions. This is perfect for [keeping track of a high score in a game](/lens-studio/features/persistent-cloud-storage/persistent-cloud-storage-templates/high-score.md), for example.

In this guide, we'll write a simple script that increments a score every time the user opens their mouth, and then saves that count.

Please visit the High Score Template Guide for a more detailed example

## Writing Data To Persistent Storage[​**](#writing-data-to-persistent-storage "Copy to clipboard")

First, create a variable that refers to the Persistent Storage system's data store.

```
var store = global.persistentStorageSystem.store;
```

Next, create a key which you'll use to read and write the score value. In this case, we'll name our key `totalScore`.

![](/assets/images/persistent-storage_persistent_storage_logger-0b0f20a2f9cf2574d12db39001cac88c.png)

```
var scoreKey = 'totalScore';
```

Using this key, we can create an integer variable in the Persistent Storage system's data store.<br /><!-- -->Since we haven’t yet placed any data in the store, the first time we retrieve `totalScore` its value will be the default integer value of 0.

```
var currentGameScore = store.getInt(scoreKey);
print('Loaded score: ' + currentGameScore);
```

For a full list of supported data types, please visit the [GeneralDataStore API Reference](/api/lens-studio/Classes/ScriptObjects.md#GeneralDataStore).

Next, we'll write a function that increments the score and updates our variable in the Persistent Storage store.

```
function incrementScore() {
  currentGameScore += 1;
  store.putInt(scoreKey, currentGameScore);
  print('Current score: ' + currentGameScore);
}
```

And bind the new function `incrementScore` to the `MouthOpenedEvent`:

```
script.createEvent('MouthOpenedEvent').bind(incrementScore);
```

Now, each time the user opens their mouth, they will increment the integer value stored at the persistent key `totalScore`.

Once a value is stored in Persistent Storage, it stays there even after the user closes the Lens.  In Lens Studio, a notification appears in the Preview panel to remind you that there is data in Persistent Storage.

[](/img/lens-studio/persistent-storage_persistent_storage_lens_reset.webm)

Snapchat will clear the Lens' persistent storage 60 days after the user does not touch the Lens.

## Printing and Clearing Keys[​**](#printing-and-clearing-keys "Copy to clipboard")

In Lens Studio, you can print and clear the Persistent Storage system's keys in the Preview Panel.

### Printing Keys[​**](#printing-keys "Copy to clipboard")

You can print the keys and values you have stored in Persistent Storage in the `Preview Panel` by selecting `... > Print Persistent Storage`

The result will be printed in the `Logger Panel`.

![](/assets/images/persistent-storage_persistent_storage_print_storage-1ec5454b6e7487f80b25af78be5a3133.png)

### Clearing Keys[​**](#clearing-keys "Copy to clipboard")

You can clear Lens Studio's Persistent Storage in the `Preview Panel` by selecting `... > Clear Persistent Storage`

You can clear Persistent Storage in Snapchat by going to Settings > Clear Lens Data

## Storage Capacity[​**](#storage-capacity "Copy to clipboard")

Persistent Storage has a limited capacity. Once it’s full, no new data keys can be added until it's cleared.

![](/assets/images/persistent-storage_persistent_storage_storage_limit-d8b5b983816e6b56391420b3faa8ea5e.png)

`onStoreFull` is a callback function called every time Persistent Storage is full. We can call `clear` each time this happens to add new values.

```
store.onStoreFull = function () {
  store.clear();
  print('Storage cleared');
};
```

## The Final Script[​**](#the-final-script "Copy to clipboard")

Below you'll find the completed script from this guide:

```
// Create key for the score variable
var store = global.persistentStorageSystem.store;
var scoreKey = 'totalScore';
// Retrieve the score from persistent storage
var currentGameScore = store.getInt(scoreKey);
// Print the score
print('Loaded score: ' + currentGameScore);
// Function that increments the score
function incrementScore() {
  // Increment the score by 1
  currentGameScore += 1;
  // Store the current score in persistent storage
  store.putInt(scoreKey, currentGameScore);
  // Print the current score
  print('Current score: ' + currentGameScore);
}
// Bind the incrementScore function to the "Mouth Opened" event
script.createEvent('MouthOpenedEvent').bind(incrementScore);
// If persistent storage is full, clear it
store.onStoreFull = function () {
  store.clear();
  print('Storage cleared');
};
```
