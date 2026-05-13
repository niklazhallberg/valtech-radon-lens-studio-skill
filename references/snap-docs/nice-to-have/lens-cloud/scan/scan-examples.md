# Scan Examples

Scan examples (`Scan - Get Car Price`, `Scan - Print On Tap`, `Scan - Checklist`, `Scan - Scan On Update`) are available in the Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project, create new Orthographic camera and place the prefab under it.

The Scan example contains examples showcasing use cases of the Scan function to detect what's in the camera. The example contains several helpers that you can use to create experiences without scripting. In addition, it provides a simple example to get you started with your first Scan script.

To get started with using the scan module, please check out the [Scan](/lens-studio/features/lens-cloud/scan/scan-overview.md) documentation page to see more detailed explanations about scripting with Scan.

The **Scan** function is a part of Lens Cloud, a collection of backend services, built on the same infrastructure that powers Snapchat.

To learn more about Lens Cloud and how to power a new generation of AR experiences that are more dynamic, useful, and interactive than ever before, please visit [Lens Cloud Overview](/lens-studio/features/lens-cloud/lens-cloud-overview.md)

## Guide[​**](#guide "Copy to clipboard")

The example has several different independent examples on how you can use scan:

* **[Scan Permission](#scanpermission):** Since Scan will get information on the camera by sending data to the server, the Lens will require the user's permission
* **[Basic Scan](#basicscan):** Basic way to list scanned results on screen on update or by pressing buttons
* **[Identify Object](#identifyobject):** Identify whether certain object is in scene
* **[Environment Switch](#environmentswitch):** Activate visuals on environment changes
* **[Get Car Price](#getcarprice):** Shows scanned car and its price range on screen
* **[Checklist](#checklist):** Check if objects in scene fits into the element populated in a checklist. In addition, it contains an example script that you can use to get started with your own Scan experience.
* **[The Print On Tap Example](#printontap):** Simple example to show how to script with scan
* **[Scan Rate Limit](#scanlimit):** Dealing with multiple Scan requests

### Scan Permission[​**](#scan-permission "Copy to clipboard")

Since the Scan example leverages Snapchat’s Scan, when you first open the example Lens Studio will ask you to login if you haven’t yet. If not logged in, the `Preview` panel will show “Waiting on Scan Access” screen.

![](/assets/images/scan_scan_permission1-7a2b089fadf8c8f48961c66bf34bf5d9.jpg)

In the same way, in order to use the Scan function in the app, we need to get user’s permission to allow Lenses to use Scan on the Snapchat app. When a user first loads up a lens containing the Scan Module, this window will pop up on the app:

![](/assets/images/scan_scan_ftue-fed5df5f1afce4023e3470df994914f0.jpg)

When the user presses `Okay`, this screen will disappear and your Lens experience will continue. If they press `Cancel`, the Lens will be loaded but none of the functionality involving scan would work because there will be no data returned. We can find this screen in the `PermissionCheck` script attached to the `PermissionCheck` object under `Scan Controller`.

When the project starts, the `PermissionCheck` script will call the function `global.getScanResult()` to try to call the scan module. And if the scan result returned succeeds, this screen will disappear and your experience will know it can call Scan and get the expected result.

To protect the user’s privacy, Snapchat will always let the user know that a Lens will use the scan function. The next time they enter your Lens it will ask the user to '`Tap to Enter`' the Lens.

![](/assets/images/scan_scan_tap_to_enter-d49d42728c7e21bc4b21cac023b79b6d.jpg)

### The Basic Scan Example[​**](#basicscan "Copy to clipboard")

Under the `Basic Scan` object there are 2 examples of calling Scan and displaying its results.

`Scan On Update` would make a scan call constantly and it will display the scanning type and scanned result on the screen.

Try changing the `ScanType` variable to explore different types of scan!

![](/assets/images/scan_scan_onupdate-88b3757b25d0674c1015198fa5af3911.jpg)

The `Scan With Buttons` example works similarly as `Scan On Update`, but instead of constantly scanning it will just scan a type of object when the corresponding button is pressed. Feel free to push this example to the Snapchat app to try it out with your phone to scan the objects / places / cars around you!

[](/img/lens-studio/scan_scan-buttons.webm)

In both cases, modify or change the `ScanType` or the `ScanTypeText` field to design your own Lens experience.

### Identify Object[​**](#identifyobject "Copy to clipboard")

The `Identify Object` example uses the `IdentifyObject` script to check if any of the currently scanned objects matches the name typed in the `ObjectName` slot in the script. Instead of printing the result of the Scan, here we are checking if the result is what we want. If it is what we want, we trigger some effect.

By Default `ObjectName` is set as `Banana` and the [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) script will enable a particle system when Banana is scanned.

[](/img/lens-studio/scan_scan_isitbanan.webm)

Try changing the `ObjectName` to anything according to [this](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/ScanModule_-Scannable-Items.pdf) reference list of all available scan results!

### Environment Switch[​**](#environmentswitch "Copy to clipboard")

This example triggers an effect when the scanned result has changed from label1 to label2--in other words whether the Scan results contain at least one of two expected results. In the example provided the `scanType` is set to be `Places`, and it is checking if the scanned result has switched from `Indoor` to `Outdoor`.

[](/img/lens-studio/scan_scan_environment_switch.webm)

In the `CheckLabelSwitch` script, we can set up a tween response to run different tween animations on one object, in this case we’re running different tween animations on the `Lens Flare` object based on scanned result changing from ‘Indoor’ to ‘Outdoor’ and vice versa.

![](/assets/images/scan_scan_checklabel-e9107c12a20de18d404cca8b4e3eafad.jpg)

We have also set up Behavior triggers to be called when the switch happens, and the trigger will trigger tween responses on the icon under the `Hints` object as well as a color tween animation on the `Vignette` object.

Feel free to combine your own Behavior triggers, tween animations or labels with the `CheckLabelSwitch` and create more dynamic responses when scanned result changes!

### Get Car Price[​**](#getcarprice "Copy to clipboard")

[](/img/lens-studio/scan_scan-get_car.webm)

The `Get Car Price` example gets the scanned car name and price from the JSON file returned from the `Scan Module`. The Cars category is unique among scanned types in that it returns additional data on top of the detected result. In this case, you will also get  the car’s MSRP value (price) from scanned results.

The JSON format for car price is: `result["extraData"]["msrp"]`. We can use the same format to get the "make" or "model" of the car by replacing the "msrp" string with related string. Feel free to explore the `GetCarPrice` script to learn more!

It’s lots of fun to export this example to your phone and go explore and scan some cars to explore and learn about cars!

[](/img/lens-studio/scan_scan_car.webm)

### Checklist[​**](#checklist "Copy to clipboard")

![](/assets/images/scan_scan_checklist-13aa4c7acbcaf658f81d6716572f8e57.jpg)

The `Checklist` example contains a list of custom defined labels and will mark them as ‘checked’ if they have appeared in camera.

Turning on the `Persistent Storage` bool allows the lens to remember items which have been checked, so even when the lens gets refreshed all the previous checked items will stay checked.

[](/img/lens-studio/scan_scan-checklist-persisten.webm)

When changing the amount of items being checked, you may go to the `UILayout` script attached to the `Item Parent` object to change the y value of the `Cell Size` in order for items to populate the `Checklist` UI more evenly.

![](/assets/images/scan_scan-ui-layout-bf40cb9694b7b8c68a36fcb186dfd6ee.jpg)

Feel free to populate the Checklist example with a completely different set of objects, and have fun with checking them off!

### The Print On Tap Example[​**](#the-print-on-tap-example "Copy to clipboard")

This example is great if you want to create your own script using Scan as it is the basis for the other examples. However, feel free to see the other examples for a usage based example.

The Print On Tap example in the Scan example is the best way to get started with scripting with the scan module. The `PrintScanResultOnTap` script prints out the scan result (label) of a certain category on tap. Let’s check out the script to see how it works!

In the tap function, we’ll see the function `script.scanModule.scan([scanType], onScanComplete, onScanFailure);` being called. This is the function that calls the scan module and returns scanned data. The `scanModule` property is linked with a Scan Module created in the `Resources` folder. This module is the source for pulling scan data from a remote server!

The `onScanComplete()` function gets called when the scan module returns data and `onScanFailure()` gets called when the scan module fails to return data due to networking or permission reasons.

Since Scan understands what’s in the scene by sending it to a server, the Snapchatter must accept permission to enter the Scan experience. Please check the Scan Permission section above to learn more!

In the `onScanComplete()` function, we’ll see a JSON object being passed and the `printAnnotations()` function will print out every single entry from the JSON object based on the input variable `annotations[i]`.

```
function onScanComplete(json) {
  scanResultReturned = true;
  var obj = JSON.parse(json);
  if (
    !obj ||
    !obj.annotations ||
    !obj.annotations[scanType] ||
    !obj.annotations[scanType].annotations
  ) {
    return;
  }
  var annotations = obj.annotations[scanType].annotations;
  for (var i = 0; i < annotations.length; i++) {
    printAnnotation(annotations[i]);
  }
}
```

A scan result can return one or more objects, with one or more detail per object (depending on the scan type)

### Scan Rate Limit[​**](#scanlimit "Copy to clipboard")

The scan module can only send out one scan request at any given time. All updating scan calls only calls the next scan when result from the last scan has returned. We can see it in the `ScanOnUpdate` script. the `scan()` function calls itself inside the scan function where scanned results are returned:

```
function scan() {
  global.getScanResults(
    script.scanType,
    function callback(data) {
      if (data) {
        var combinedResults = '';
        for (var i = 0; i < data.length; i++) {
          combinedResults += data[i].name;
          combinedResults += '\n';
          debugPrint('Scan Result: ' + data[i].name);
        }
        script.scanResult.text = combinedResults;
      } else {
        debugPrint('Scan has No Result!');
      }

      scan();
    },
    function failureCallback(data) {
      debugPrint('Scan Failed! ' + data);
      scan();
    }
  );
}
```

While working with the Scan example, make sure only **ONE** example is running at any given time to avoid overloading the network by making multiple scan calls at the same time.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](https://lensstudio.snapchat.com/guides/general/pairing-to-snapchat/) guide.

## Related Guides[​**](#related-guides "Copy to clipboard")

Please refer to the guides below for additional information:

* [Scan](/lens-studio/features/lens-cloud/scan/scan-overview.md)
* [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md)
* [Scripting](/lens-studio/features/scripting/script-overview.md)
* [Scan Scavenger Hunt](https://support.lensstudio.snapchat.com/hc/en-us/articles/360061014372-Using-the-Scavenger-Hunt-Asset-with-the-Scan-Functionality)
