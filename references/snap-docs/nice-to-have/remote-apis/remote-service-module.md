# Remote Service Module

The Remote Service Module allows you to obtain data from external APIs and use them in your Lenses. In order to get started simply navigate to the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) and import the remote service module for the API you’d like to use.

If you have ideas around APIs that you’d like to build AR Lenses with, be it your own APIs or those of other third party partners, [please get in touch](https://forms.gle/pND1i9y8UUQxsYnk9). Your input helps inform Snap’s product team on what we should be building to support our Lens Creator Community. We look forward to hearing from you!

![](/img/lens-studio/5-remote-api/remote-api-0.png)

Then, you can use the remote service modules scripting API to call the various endpoints of that API.

## Examples[​**](#examples "Copy to clipboard")

You can check out next pages to access helpful utilities and examples of how to use each API.

* [AccuWeather API](/lens-studio/features/remote-apis/weather-api-documentation.md) and [example](/lens-studio/features/remote-apis/remote-apis-templates/weather-api.md).
* [Stock Market - Alpaca API](/lens-studio/features/remote-apis/remote-apis-templates/stock-market-api.md) example.
* [Snapchat Places API](/lens-studio/features/remote-apis/snap-places-api.md)
* [ChatGPT API](/lens-studio/features/remote-apis/chatgpt-api.md)

### Scripting[​**](#scripting "Copy to clipboard")

Here is an example of how you can call to a Remote Service Module.

```
var req = RemoteApiRequest.create();
req.endpoint = 'ENDPOINT_NAME';
script.remoteServiceModule.performApiRequest(req, function (response) {
  handleAPIResponse(response);
});
```

## Best Practices When Utilizing a Third-Party Remote API[​**](#best-practices-when-utilizing-a-third-party-remote-api "Copy to clipboard")

Remote APIs in Lenses are a way to expand Lens functionality by calling a third-party service. However, if not optimized and thoughtfully planned, this technology can cause latency and can cause memory limitations. Below are some best practices to ensure the best possible user experience.

1. Read the third party API documentation and correlate those with your Lens concept.
   <!-- -->
   1. Identify endpoints. For example, the [Accuweather API documentation](https://developers.snap.com/lens-studio/features/remote-apis/weather-api-documentation) has a list of available endpoints.

2. Choosing the right API to use is important. Consider the size of the data response. In general, try to use the minimum number of API calls to endpoints that return the least amount of data.

   <!-- -->

   1. If over 800 KB, there is probably a different endpoint you can use or try configuring parameters to reduce the size.
   2. If not able to reduce the size or the API calls take too long to finish, contact [Lens Studio Support](mailto:lensstudio-support@snapchat.com)

3. Before you start to build the actual Lens, call the API endpoints with a simple script in Lens Studio to make sure they work properly. This will save debugging time later on.

### Do’s[​**](#dos "Copy to clipboard")

* Anticipate high latency. Ensure there is an intro experience or that there is meaningful content that loads immediately in order to give the API time to load. This way, the Snapchatter does not have to wait and the experience begins immediately.
* When receiving errors while developing with APIs, reference the error descriptions to see what needs to be fixed. Here are some [common error codes](/api/lens-studio/Classes/ScriptObjects.md#RemoteApiResponse--statusCode).

### Don’ts[​**](#donts "Copy to clipboard")

* Don’t make too many API calls at the same time. We recommend no more than three, but try to keep it to only one if possible.
* Don’t utilize APIs for fetching images dynamically. Use [Remote Assets](/lens-studio/features/lens-cloud/remote-assets-overview.md) for this purpose by authoring them at time of Lens creation.

## Restrictions[​**](#restrictions "Copy to clipboard")

When using a remote service module, some APIs will be restricted in order to protect the user’s privacy. The following APIs will be disabled:

* [UserContextSystem](/api/lens-studio/Classes/ScriptObjects.md#UserContextSystem): requestBirthdate, requestBirthdateFormatted, requestCity
* [Text component](/api/lens-studio/Classes/Components.md#Text): Reading from text property when Dynamic Text is being used
* [ProceduralTextureProvider](/api/lens-studio/Classes/Providers.md#ProceduralTextureProvider): getPixels
* [DepthTextureProvider](/api/lens-studio/Classes/Providers.md#DepthTextureProvider): getDepth
* [DeviceTracking](/api/lens-studio/Classes/Components.md#DeviceTracking): hitTestWorldMesh, raycastWorldMesh, getPointCloud
* [DeviceLocationTrackingComponent](/api/lens-studio/Classes/Components.md#DeviceLocationTrackingComponent): distanceToLocation, locationProximityStatus, onLocationFound, onLocationLost
* [ScanModule](/api/lens-studio/Classes/Assets.md#ScanModule)
* [OutputPlaceholder](/api/lens-studio/Classes/ScriptObjects.md#OutputPlaceholder): data
* [MicrophoneAudioProvider](/api/lens-studio/Classes/Providers.md#MicrophoneAudioProvider): getAudioFrame
* [DeviceInfoSystem](/api/lens-studio/Classes/ScriptObjects.md#DeviceInfoSystem): getOS
* [LocalizationSystem](/api/lens-studio/Classes/ScriptObjects.md#LocalizationSystem): getLanguage
* [TensorMath](/api/lens-studio/Classes/OtherClasses.md#TensorMath): textureToGrayscale
* [Voice ML Module](/api/lens-studio/Classes/Assets.md#VoiceMLModule)
