# Configuring Project Settings

The `Project Settings` settings window is where additional info, required for Lens submission, is configured. To access the `Project Settings` settings window, click the `Project Settings` button in Lens Studio's toolbar.

![](/assets/images/project-settings-1-ae3c85c758d4cd3008cec639b2704e03.png)

You should make sure the Lens Project Settings is configured properly before submitting the Lens. Below are the various settings that are configurable through the `Project Settings` settings window.

![](/assets/images/project-settings-1-7bd6f21b228f385f52403ed612c2227d.png)

On the left sidebar, you will find the various categories of settings you will need to configure.

In the center, you will find the settings for each category.

On the right side, you will find a summary of your Lens settings, which were configured.

In the bottom right, you will see a list of validation checks you will need to complete before you publish your Lens.

Finally, the Publish button itself!

## General[​**](#general "Copy to clipboard")

### Lens Name[​**](#lens-name "Copy to clipboard")

![](/assets/images/project-settings-2-7aa4b2e7fe7ce29f69936e80cf726fd4.png)

The name of your Lens. This will be shown to users when they receive the Lens. It's also how people can identify, and search for your Lens.<br /><!-- -->caution

Your Lens name must be 18 characters or less, containing only letters, numbers, or spaces.

### Platform Settings[​**](#platform-settings "Copy to clipboard")

![](/assets/images/project-settings-3-212779f0cf47654e42e5f6a65f7156d4.png)

This setting indicates what kind of platform the Lens is made for.

* By selecting Mobile, your Lens will be enabled for native Snapchat and Camera Kit Mobile applications.
* By selecting Web, your Lens will be enabled for Camera Kit Web – which includes mobile web and [Snapchat for Web](https://web.snapchat.com/).
* By selecting Spectacles, your Lens will be enabled for Spectacles. You will only be able to target your Lens for Spectacles if you have either checked your Lens in the Preview panel with the Spectacles device simulation option, OR have paired your device.

Toggling a platform may change the availability of various settings in the Platform Settings section of the sidebar.

### Size[​**](#size "Copy to clipboard")

![](/assets/images/project-settings-4-b6d76c01d5f6a88242a9aeaaa5174b43.png)

The size of the compressed Lens that will be uploaded upon submission. The size limit for a submitted Lens is `8 mb` but we advise staying at `2 mb` or less for a quicker download. For more information, refer to the [Performance and Optimization](https://developers.snap.com/lens-studio/publishing/optimization/overview) guide. For information on optimizing 2D images, see the [2D Optimization](https://developers.snap.com/lens-studio/publishing/optimization/texture-optimization) guide.<br /><!-- -->important

If you are working on building Sponsored Lenses, please make sure your lens is less than `4MB` to ensure the most optimal performance across the widest array of devices.

In addition to the Lens Size, you can have up to 10mb dedicated to ML model when you’re using the SnapML Machine Learning component.

### API Settings[​**](#api-settings "Copy to clipboard")

![](/assets/images/project-settings-5-32704781eb7fdc8bc8b99e48ea61f2ee.png)

When Experimental API is enabled, you will have access to additional APIs. However, this will limit your ability to publish your Lens!

This is mostly used when developing for Spectacles.

## Distribution Settings[​**](#distribution-settings "Copy to clipboard")

### Discoverability[​**](#discoverability "Copy to clipboard")

This allows you to configure settings that will help your Lens show up to various Snapchatters.

#### Tags of the Month[​**](#tags-of-the-month "Copy to clipboard")

![](/assets/images/project-settings-6-fe60704d3f567bfc8fbbfde736a92adc.png)

Tags of the Month is a way for Lens Creators to get exclusive access to the hottest Lens topics of the month. Tags are sourced from both on-platform and off-platform repositories to highlight the “hottest” themes/trends of the moment. Creating high quality Lenses related to these tags, and tagging them here will increase your chances of being featured across a number of places in the app!

Learn more about Tags of the Month in the Submitting your Lens guide.

#### Other Lens Details[​**](#other-lens-details "Copy to clipboard")

There are no settings to be changed here as you’ll be able to set these in My Lenses during submission.

### Lens Icon[​**](#lens-icon "Copy to clipboard")

The icon for the Lens is packaged with the Lens. They help identify your Lens for Snapchatters to come back to.

You can Import an image, or generate one using GenAI Suite. To learn more about creating an icon, follow the [Creating an Icon](https://developers.snap.com/lens-studio/publishing/configuring/creating-an-icon) guide.

With your icon selected, you can use the built in crop tool to change how you want your icon to look.

[](/img/lens-studio/5-project-info/project-settings-4.webm)

If your icon has a transparent background, you can enable the `Background` option and select a background color.

[](/img/lens-studio/5-project-info/v2/project-settings-8.webm)

Your selected icon will appear in the right side of the window.

For example, using GenAI Suite, with the prompt `horror` in the style of `Vector art` you can add a Lens icon like so:

![](/assets/images/project-settings-9-10771ed28fb547163d438a7842c22670.png)

### Lens Preview[​**](#lens-preview "Copy to clipboard")

A Lens Preview is also packaged with your Lens. A preview shows off your Lens in Lens Explorer and will be visible to the public. Click on `+` to pick a pre-made video or upload your own. For more information on Preview Videos, please refer to the [Preview Videos](/lens-studio/publishing/configuring/creating-a-preview-video.md) guide.

![](/assets/images/project-settings-10-09ed5df16348f2e55306c006ee5f6d3e.png)

Once you’ve selected your preview, you should see the chosen preview in the right side of the window.

![](/assets/images/project-settings-11-6e2630ac40d66d44738bc404f255952b.png)

## Platform Settings[​**](#platform-settings-1 "Copy to clipboard")

### Mobile[​**](#mobile "Copy to clipboard")

When building for mobile devices, Lenses can be configured to work on different platforms and enabled for different cameras.

#### Lens Works On[​**](#lens-works-on "Copy to clipboard")

![](/assets/images/project-settings-12-c8e087417f9870580705b2b5abb47183.png)

This setting indicates which side of the camera your Lens works on. For example, Face Lenses will automatically be enabled on both sides as long as a face is found. However, a Location AR experience may only be built for the rear camera.

If you are working on building Sponsored Lenses, you should make sure that your Lens utilizes Both Cameras. By not having both a world and face camera experience for your Lens, it may receive less distribution in the carousel and may negatively impact any advertising campaigns using this Lens.

#### Activation Camera[​**](#activation-camera "Copy to clipboard")

![](/assets/images/project-settings-13-e9535f1579823706ac85df211cf5722d.png)

Activation Camera indicates which camera your Lens is optimized for – this impacts which camera your Lens will default to upon start up.

#### Camera Hint[​**](#camera-hint "Copy to clipboard")

The hint is a suggestion given to the user to help instruct interaction. The hint appears as soon as the Lens is turned on and fades out after a set number of seconds. For more information, refer to the [Lens Hints](/lens-studio/publishing/configuring/lens-hints.md) guide.

The built-in hints are useful as they are localized to the region the user is in.

![](/assets/images/project-settings-14-8d2d3d68c85d1781228502fc0bc2b891.png)

### Spectacles[​**](#spectacles "Copy to clipboard")

When developing for Spectacles, you may access additional things in the Lens that require the user’s permission to confirm. This page will list out the various permissions your Lens will request when the Lens is used.

![](/assets/images/project-settings-15-d107cdba022c8e4bac9a46fd421394cc.png)

If no permissions are needed, you will not see any item in the text box.
