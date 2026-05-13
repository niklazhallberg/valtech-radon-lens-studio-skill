# Remote Assets

Remote Assets are assets that are stored in the remote storage and not bundled into the Lens. Instead, they are downloaded on demand and used as normal assets once the download succeeds.

Remote Assets are a part of [Lens Cloud](/lens-studio/features/lens-cloud/lens-cloud-overview.md), a collection of backend services, built on the same infrastructure that powers Snapchat.

## Video Walkthrough[​**](#video-walkthrough "Copy to clipboard")

In this video, you will learn how to use Remote Assets to build more performant Snapchat Lenses. We will give you an overview of how to setup an organization, how to upload Remote Assets and add Remote Assets to your Lens Studio project.

**Please note:** This video was recorded using Lens Studio version 4.55

## Storage Limits[​**](#storage-limits "Copy to clipboard")

There are storage limits to be aware of when working with remote assets:

* A remote asset can be up to **10 MB**.
* Each Organization can use up to **500 MB** for Remote Asset Storage.

Remote Assets **do not** count towards your total Lens size for submission. Each Remote Asset uses its own **[10 MB Remote Asset](#storage-limits)** storage. This allows you to create optimized Lenses that load much faster, use assets beyond the maximum Lens size, and share assets with all members of the [Organization](#organizations-and-remote-assets).

## Best Practices When Building Lenses With Remote Assets[​**](#best-practices-when-building-lenses-with-remote-assets "Copy to clipboard")

When building Lenses with Remote Assets, it is recommended that you keep the following in mind in order to provide a smooth user experience.

* Your Lens should contain an experience at the beginning that **is not a Remote Asset** so that your Remote Asset loads while the user expereincing the first part of the experience.
  <!-- -->
  * You should show something at the start of the Lens by using the Lens Archive while the Remote Asset loads.
* If your Remote Asset is heavy and your experience doesn’t require everything all at once, it is recommended to download and fetch an asset one by one. If you have lots of different assets, you should break them out into separate experiences within the Lens as much as possible.
* You should show a loading icon or feedback icon in the Lens while the Remote Asset is downloading so that your user knows that something is about to happen, before they swipe off of the Lens too quickly.
* Using Remote Assets that are shared between Lenses will optimize performance. This means that several Lenses can use the same asset, because they are already downloaded.

## Uploading Remote Assets[​**](#uploading-remote-assets "Copy to clipboard")

You must refer to the [Best Practices](#best-practices-when-building-lenses-with-remote-assets) in this document when building Sponsored Lenses with Remote Assets.

In order to create a Remote Asset:

1. Navigate to the Asset Browser panel in Lens Studio.
2. Right-click on any [supported asset type](#supported-asset-types) in the `Asset Browser` panel.
3. Select `Upload to Remote Assets`.

When you upload your first asset, you will need to link your Lens Studio project to an [Organization](#organizations-and-remote-assets).

If you do not have an existing Organization, you will be prompted to create one.

![Upload Remote Assets](/assets/images/remote_assets_upload-0bcb85486376c991e774355878f21226.png)

After selecting an Organization, your asset will upload to the Organization. Once uploaded, a [RemoteReferenceAsset](/api/lens-studio/Classes/Assets.md#RemoteReferenceAsset) will automatically import into your project and appear in your `Asset Browser` panel.

![Reference Assets](/assets/images/remote_assets_imported_references-250d3c249ddeed17d3ca23f3e2a6bd71.png)

You can upload multiple assets at once by clicking the `Upload Asset` button in the Remote Assets panel and selecting multiple resources by holding `Shift` button and then clicking `Ok`

## Importing Asset References[​**](#importing-asset-references "Copy to clipboard")

You can open the Remote Assets panel by clicking on the cloud button at the top of the `Asset Browser` panel.

![Cloud button](/assets/images/remote_assets_cloud_button-6b49c384f898d104fc32f4c79a97b684.png)

The Remote Assets panel allows you to see all available assets within the Organization or multiple Organizations, upload new assets as well as import and delete existing ones.

To import an existing remote asset to your Lens Studio project, You can select one or multiple assets in the Remote Assets panel and click `Import`.

![Import Assets](/assets/images/remote_assets_import_multiple-ec9d4209ec03073096a35a6a075d470b.png)

One Lens Studio Project may only use Remote Assets that belong to one [Organization](https://businesshelp.snapchat.com/s/topic/0TO0y000000YVcVGAW/manage-members-and-roles?language=en_US). The Organization for the project will be set to the one that the first imported asset belongs to.

To switch to another Organization, you will need to remove all the asset references that don't belong to it, and then import assets from the new Organization.

## Downloading And Using Remote Assets[​**](#downloading-and-using-remote-assets "Copy to clipboard")

Once you’ve imported asset from the Remote Assets panel, a corresponding [RemoteReferenceAsset](/api/lens-studio/Classes/Assets.md#RemoteReferenceAsset) asset will be created in the `Asset Browser` panel:

![Remote References](/assets/images/remote_assets_imported_references-250d3c249ddeed17d3ca23f3e2a6bd71.png)

You can select the RemoteReferenceAsset resource to view its name and Organization it belongs to in the Inspector Panel:

![Remote Reference Inspector](/assets/images/remote_assets_inspector-e984f4f2448db907fcb0a1206fa019b9.png)

[RemoteReferenceAsset](/api/lens-studio/Classes/Assets.md#RemoteReferenceAsset) are not an asset itself but a reference (link or address) of the actual asset and can not be used in a project directly. The actual Remote Asset has to be downloaded from the storage using the `downloadAsset` function of RemoteReferenceAsset.

```
downloadAsset(function(Asset asset) onDownloaded, function onFailed) : void
```

The function accepts two callbacks:

* `onDownloaded(asset)` where `asset` argument is an actual asset that can be used normally depending on its [type](#supported-asset-types)
* `onFailed` in case something went wrong.

Below is a code example of how to download the asset:

```
//@input Asset.RemoteReferenceAsset myRemoteReferenceAsset
/** @type {RemoteReferenceAsset} */
var myRemoteReferenceAsset = script.myRemoteReferenceAsset;

/**
 * download remote asset from its reference
 */
function downloadAsset() {
  myRemoteReferenceAsset.downloadAsset(onDownloaded, onFailed);
}
/**
 * on asset successfully downloaded
 * @param {Asset} asset
 */
function onDownloaded(asset) {
  print(
    asset.name + ' was successfully downloaded, type is ' + asset.getTypeName()
  );
  // do something with an asset, for example:
  // - instantiate ObjectPrefab
  // - use Texture in Material
  // - display Mesh using RenderMeshVisual Component
  // - play AudioTrackAsset with Audio Component
}
/** on remote asset download failed */
function onFailed() {
  print(myRemoteReferenceAsset.name + ' was not downloaded');
  // use fallback asset or notify user that something went wrong
}
```

Below are some best pratices to keep in mind when downloading remote assets to a Lens:

* Download assets only when needed, avoid downloading them upfront
* Provide an indication of loading in the Lens so that people using your Lens are not confused while waiting
* Provide a backup asset / scenario in case the download fails.

## Deleting Remote Assets[​**](#deleting-remote-assets "Copy to clipboard")

To delete a RemoteReferenceAsset from the project, Delete the resource file from the `Asset Browser` panel.

To delete an Asset from the Remote Asset Storage:

1. Left-click on one or more assets in the `Remote Assets` panel.
2. Right-click and select `Delete From Storage`.

![Delete Remote Asset](/assets/images/remote_assets_deleting-86e2c66be965f39afd43cd79ff34ab01.png)

Be careful with deleting assets that are used in multiple projects and Lenses.

## Supported Asset Types[​**](#supported-asset-types "Copy to clipboard")

These types of assets can be uploaded to Remote Asset storage directly:

* [Texture](/api/lens-studio/Classes/Assets.md#Texture) (except for [Animated Texture](/api/lens-studio/Classes/Providers.md#AnimatedTextureFileProvider), which can be uploaded as a part of prefab)
* [Render Mesh](/api/lens-studio/Classes/Assets.md#RenderMesh)
* [Audio Track](/api/lens-studio/Classes/Assets.md#AudioTrackAsset) (Except when using a [Licensed Music Asset](/api/lens-studio/Classes/Providers.md#FileLicensedSoundProvider))
* [Object Prefab](/api/lens-studio/Classes/Assets.md#ObjectPrefab)
* [ScriptAsset](/api/lens-studio/Classes/Assets.md#ScriptAsset)
* [MLAsset](/api/lens-studio/Classes/Assets.md#MLAsset)

More Asset types and different Components can be uploaded as a part of the ObjectPrefab, except for the following;

#### Unsupported Assets[​**](#unsupported-assets "Copy to clipboard")

* [MarkerAsset](/api/lens-studio/Classes/Assets.md#MarkerAsset)
* [LocationAsset](/api/lens-studio/Classes/Assets.md#LocationAsset)
* [Object3DAsset](/api/lens-studio/Classes/Assets.md#Object3DAsset)
* [BodyDepthTexture](/lens-studio/features/graphics/person-normals-and-depth.md#body-depth-texture)
* [FaceMesh](/lens-studio/features/ar-tracking/face/face-mesh.md)
* LocationMesh
* [WorldMesh](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md)
* [BodyMesh](/lens-studio/features/ar-tracking/body/body-mesh-overview.md)
* [SegmentationTexture](/api/lens-studio/Classes/Providers.md#SegmentationTextureProvider)
* [ScanModule](/api/lens-studio/Classes/Assets.md#scanmodule)
* [VoiceMlModule](/api/lens-studio/Classes/Assets.md#VoiceMlModule)
* [TextToSpeechModule](/api/lens-studio/Classes/Assets.md#TextToSpeechModule)
* [DialogModule](/api/lens-studio/Classes/Assets.md#DialogModule)
* [BitmojiModule](/api/lens-studio/Classes/Assets.md#BitmojiModule)
* [ShoppingModule](/lens-studio/sponsored/sponsored-lens-templates/shopping/surface-objects.md)
* [Matter](/api/lens-studio/Classes/Assets.md#Matter)

#### Unsupported Components[​**](#unsupported-components "Copy to clipboard")

* [RetouchVisual](/api/lens-studio/Classes/Components.md#RetouchVisual)
* [HairVisual](/api/lens-studio/Classes/Components.md#HairVisual)
* [ClothVisual](/api/lens-studio/Classes/Components.md#ClothVisual)
* [ColliderComponent](/api/lens-studio/Classes/Components.md#ColliderComponent)
* [BodyComponent](/api/lens-studio/Classes/Components.md#BodyComponent)
* [WorldComponent](/api/lens-studio/Classes/Components.md)

## Organizations and Remote Assets[​**](#organizations-and-remote-assets "Copy to clipboard")

You will need to log in into [My Lenses](/lens-studio/publishing/submitting/submitting-your-lens.md#my-lenses) in order to work with Remote Assets.

![Login](/assets/images/remote_assets-login-289cc2dadf2c45ecc9be5e40ed7dbf39.png)

Remote Assets requires your project to be linked up to the Organization.

When you open the Remote Assets panel to upload your very first assets you will be prompted to link your project to existing Organization or create a new one.

![Create Organization](/assets/images/remote_assets_create_organization-2351755c2b10074ca63d3ee2e51a3f00.png)

In this case you will be redirected to the My Lenses website to set new Organization and a Lens Folder:

![Create Organization](/assets/images/remote_assets_create_lens_folder-158db7355b68e660214570924f896851.png)

After you’ve successfully created an Organization and a folder feel free to go back to Lens Studio, left-click on your browser's `Refresh` button and [upload](#uploading-remote-assets) your first remote asset.

Multiple projects can be linked to one Organization and use uploaded assets.

Multiple users that belong to one Organization may share the same Remote Assets storage. If you wish to share your Lens Studio project with someone else you will need to make them a member of your Organization in order to allow them to work with the project.

Each project can only use assets from one Organization. If you wish to change the Organization your project is linked to, you will need to delete all Remote Asset references from the previous Organization and upload and / or import assets from the new one.

To manage your Organization, visit <https://business.snapchat.com/> or visit this [guide](https://businesshelp.snapchat.com/s/topic/0TO0y000000YVcVGAW/manage-members-and-roles?language=en_US).

## Examples[​**](#examples "Copy to clipboard")

To see an example of how to implement Remote Assets, take a look at the `Preview Remote Asset` and `Remote Asset Cycler` assets in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).
