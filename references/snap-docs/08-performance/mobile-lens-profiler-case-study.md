# Mobile Lens Profiler Case Study

Profiling can be complex and solutions are uncertain. Every project has a different journey towards understanding. This case study considers a real world scenario to understand the origin of frames with greater than 33ms processing times using skills learned in the [Mobile Monitor how-to](/lens-studio/publishing/optimization/mobile-monitor.md).

First we construct the Lens. To speed up development, we leverage the Asset Library. We open the Asset Library (1) and add the following assets to the Scene: “Messy Hair” (2), “Leather Jacket” (3), “GPU Particles Effect Pack” (4) and “Color Correction Pack ( Look up Table )” \[sic] (5).

![](/assets/images/mobile-lens-profiling-case-study-1-3-9ec2d389a1ef865122b72a0e8a575a46.png)

![](/assets/images/mobile-lens-profiling-case-study-4-5-bbf8e729b9893257f20532a975e93d15.png)

We then drag them into the Scene Hierarchy (6) to construct our Lens.

![](/assets/images/mobile-lens-profiling-case-study-6-7e55b33d646bb01896b153914c15e270.png)

We push the Lens to the device, in this case, an iPhone 13. Please follow the instructions in the [Mobile Monitor how-to](/lens-studio/publishing/optimization/mobile-monitor.md) for more information. the example trace is provided [here](/assets/files/mobile-lens-profiler-case-study-4ee2d6546deecaa43a87a7ea3ce64200.pftrace).

This Lens was constructed using Lens Studio 5.1 and if a later Lens Studio is used, the contents of the trace may have shifted.

We start on the back camera, where the Lens is loaded. For three seconds, we use the Lens on the back camera. Then for twelve seconds, we use the Lens on the front camera. Then we download the trace and upload it to [Google's Perfetto UI](https://ui.perfetto.dev/).

Let’s first examine Lens loading.

We see that the Approx LensActivationTime is 173 ms (7).

Let’s look at what happened during that time.

Blocking the main rendering thread, we deserialize the scene for \~25 ms (8) On a separate non-blocking thread, we call ShapeTrack in an attempt to find the face (9). However, the detection fails and it re-tries periodically. This re-try uses neural networks and is expensive for the phone battery. On the main rendering thread, we draw the contents of main Camera for 125 ms (10).

![](/assets/images/mobile-lens-profiling-case-study-7-10-0aef41bd583a2fd85bb4cacc9aa52dba.png)

Let’s drill in on the camera work on the rendering thread.

A. We draw the Color Correction asset in 5 ms, although some draw call work is deferred (11).

B. We draw the text hint from the color correction visual in 0.5 ms (12).

C. We cannot really see the “get shader” scope. So getting shaders is very fast, which means our shaders were very likely in cache. Not all shaders will be in cache, but this time it appears they were. Often, large complex shaders are not in cache. When shaders are not in cache, this is a substantial slowdown to Lens loading!

D. But we see that the first draw calls for rendering the rain particles is slow, 100 ms, (13) likely due to some work the GPU driver has postponed. It is impossible for the application to know for certain, but it is most likely deferred GPU-texture-uploading, a common heavy operation.

E. We see that the hair and jacket has not been rendered yet, because we are still on the back camera.

![](/assets/images/mobile-lens-profiling-case-study-11-13-11f30baa2d12b79243d955a8066060ed.png)

Three seconds in, we switch to the front camera (14). In the picture below are also listed Approx Lens Activation Time (7), Lens Deserialization (8) and first Shape Track (9) for reference.

The FPS is \~28 FPS. There were 351 frames over 12.7 seconds starting at \~3s into the trace.

The first frame was the slowest. Without it the lens ran at 30 FPS almost exactly. Let’s find out why the first frame was slow.

![](/assets/images/mobile-lens-profiling-case-study-14-af3b3f38ee7b4a650d2fcd4d015e0fb5.png)

We can see that face detection succeeded the first time around and took about 10 ms (15). So this was not the cause of the slowdown.

We can drill in on the camera and see that the first frame was primarily slowed down by the first draw calls rendering the jacket and the hair (16). It is impossible to know for certain why the GPU driver stuttered, but it is most likely deferred GPU-texture-uploading again.

We can find some attributions blaming the jacket mesh and textures. (17)

```
With texture hoodi_base (-5956161908017969509,-5499899515090262976),With texture Black (2721474365900736345,-4789379167729695642),With texture hoodi_base (-5956161908017969509,-5499899515090262976),With texture Anonymous (-1,-1),With texture hoodi_normal (9093651103149409556,-9122420712760511310),With material Hoodie_main (-3498788061529617680,-6330725546971415677),With light Light (1517446348228158,84825),With light Envmap (1528843813151473,5129),With mesh hoodi (8474768469508442288,-6765785338471543920)
```

These numbers (X,Y) are engine internal unique identifiers. And we can also find a draw call slice blaming the hair mesh and textures. (18)

```
With texture Back_hair (6364106742164769204,-5334574027253645865),With texture MaterialParams (2534023075123775011,-5893353218034261396),With material back (-3750811543113412644,-7694071722992188609),With light Light (1517446348228158,84825),With light Envmap (1528843813151473,5129),With mesh back (6212797332673479151,-8839643367289051994)
```

![](/assets/images/mobile-lens-profiling-case-study-15-18-9aaa5906ad6f05758522667f37f1b3e9.png)

We can also go back into our Lens Studio 5.1 project, find our “Leather Jacket” pre-fab in the Asset Browser and find the textures (19) and mesh (20) drawn by the draw call (16).

![](/assets/images/mobile-lens-profiling-case-study-19-acb2c59a5155e9af40bd2e4377641a16.png)

![](/assets/images/mobile-lens-profiling-case-study-20-9ca7912e9d657defa9b8364b8d089749.png)
