# Pairing to Snapchat

With Lens Studio, you can preview your Lenses inside Snapchat. When paired, any changes you make in Lens Studio are reflected in preview Lenses on your mobile device. Previewing your Lenses inside Snapchat will help you test and iterate on the Lens' user experience.

To pair Snapchat with Lens Studio, you'll need the latest version of Snapchat as well as the latest version of Lens Studio.

## Pairing Your Device[​**](#pairing-your-device "Copy to clipboard")

To preview your Lenses on your device, first you must pair your device with Lens Studio.

1. Press the `Preview Lens` button in the top right corner of Lens Studio. You should see a Snapcode pop up. This Snapcode is unique to your Lens Studio instance

[](/tutorials/buildYourFirstLensTutorial/04_01_preview_lens.webm)

2. Open Snapchat on your device

3. In Snapchat, point your camera at the Snapcode

4. Press and hold the image of the Snapcode to scan it

5. You should see a prompt to Pair with Lens Studio

[](/tutorials/buildYourFirstLensTutorial/04_02_pair.webm)

6. Press the `Open` button

7. When paired, you should see the `Device Paired` message in Lens Studio

   ![](/img/lens-studio/pairing-to-snapchat_general_paring_3.png)

The pairing process can take up to 30 seconds depending on your network. After clicking `Pair`, please allow some time for the device to find and connect to Lens Studio.

You can pair more than one devices to Lens Studio. This is useful for testing on multiple devices, as well as while working on [Connected Lenses](/lens-studio/features/connected-lenses/connected-lenses-overview.md). Once one phone is connected, you can press the `down arrow` button next to the `Send to Snapchat` button, and press `Pair New Account.`<br />![](/assets/images/pairing-to-snapchat_pair-new-account-73123b0331b6633ad55f7540d6e7a28d.png)

If you want to remove the paired lens from Snapchat, first open Snapchat. Then, go to `Settings`. There, select `Additional Services -> Manage -> Lens Studio -> Pair Status -> Tap to ``Unpair`. This will unpair your device and remove the paired Lenses from your Lenses carousel. Note, you might have to force quit and reopen Snapchat if you want the Lenses removed immediately.

## Previewing Your Lenses[​**](#previewing-your-lenses "Copy to clipboard")

Now that your device is paired with Lens Studio, you can now push your Lenses to Snapchat to preview them.

1. Press the `Preview Lens` button to send your Lenses to your paired device for preview

   ![](/img/lens-studio/pairing-to-snapchat_general_paring_4.png)

2. When sending, the button will display `Sending Lens...`

   ![](/img/lens-studio/pairing-to-snapchat_general_paring_6.png)

3. Once the Lens has been sent to your device, the button will display the `Lens Sent` message.

   ![](/img/lens-studio/pairing-to-snapchat_general_paring_5_new.png)

4. Finally, once the push is successful, you should now see your Lenses for preview in your Lenses carousel. The icons of the Lenses will be whatever you set them to in the [Project Info](/lens-studio/publishing/configuring/configuring-project-info.md)

   ![Pairing to Snapchat](/assets/images/carousel-b43e1e0b73c1f7782d5a95b6446be9dc.png)

If you don't see your Lens in your carousel, make sure you're on the side of the camera which you've set your Lens to show up in, in the [Project Info](/lens-studio/publishing/configuring/configuring-project-info.md) window.

## Checking Lenses Performances[​**](#checking-performance "Copy to clipboard")

When paired, you're able to see the performance of your Lenses. Please refer to the [Performance and Optimization](/lens-studio/publishing/optimization/overview.md) guide for performance requirements and best practices. To display your Lenses' performance:

1. With your Lenses paired and opened in Snapchat, click the `Bug` button in the top left corner of Snapchat

   ![](/assets/images/bug-closed-06149f1b9b105f2a9bc2739d199306c1.jpg)

2. After clicking the `Bug` button, you should now see performance stats for your Lenses. 

   * `FPS` represents your Lenses' framerates.
   * `RAM` represents how much memory your Lenses are consuming.
   * `SIZE` represents how large your Lenses are.
   * `LAT` represents the [Lens Activation Time](/lens-studio/publishing/optimization/performance-optimization-guide.md#lens-activation-time-optimization).
   * a time stamp displays when the Lenses were last pushed.

   ![](/assets/images/bug-opened-295c096ce99ac16824d1d80a008fd567.jpg)

You can get more details about your Lens performance using the [Lens Profiler and Trace Analysis](/lens-studio/publishing/optimization/mobile-monitor.md).
