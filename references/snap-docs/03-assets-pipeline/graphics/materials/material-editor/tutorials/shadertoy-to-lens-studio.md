# Shadertoy to Lens Studio

This guide provides a reference for transcribing Shadertoy operations to Material Editor in Lens Studio. Since Material Editor now supports authoring shaders in both a node graph and writing GLSL in the Code Node, we provide both the node analog of a function and the correct Code Node syntax. Some Shadertoy inputs require supporting scripts to get and send data to materials. In these cases, we also provide example script code you can use in your projects.

[](/img/lens-studio/shadertoy-to-lens-studio-1.webm)

For more information on Material Editor, check out our many guides on this powerful tool, including our guide specifically for the Code Node.

## Shadertoy Operations[​**](#shadertoy-operations "Copy to clipboard")

### iTime[​**](#itime "Copy to clipboard")

**Node:** Elapsed Time

![](/assets/images/shadertoy-to-lens-studio-2-e48757826aa5b225a12c59596969e7c6.png)

**Code Node:** *float* `system.getTimeElapsed()`

### iTimeDelta[​**](#itimedelta "Copy to clipboard")

**Node:** Delta Time

![](/assets/images/shadertoy-to-lens-studio-3-b638c9c7e799d8dc15f97b2c5e3f36f8.png)

**Code Node:** *float* `system.getTimeDelta()`

### iChannelResolution\[i][​**](#ichannelresolutioni "Copy to clipboard")

**Node:** Texture 2D Parameter → Texture Size.xy or Texture 2D Object Parameter → Texture Size.xy

![](/assets/images/shadertoy-to-lens-studio-4-4b205829b3e0dfdacbbe82d6cfac7df5.png)

**Code Node:** *vec2* `texture_2d::textureSize();`

You can expose the Texture Size by enabling Expose Size Output under the Parameter Settings.

### iChannel{i},<br />texture()[​**](#ichannelitexture "Copy to clipboard")

**Node:** Texture 2D Sample texture input or Texture 2D Object Parameter input + Texture 2D Sample

![](/assets/images/shadertoy-to-lens-studio-5-f265fb93c5b2926112a95223447e4e0c.png)

**Code Node:** *vec4* `sampledTex = MyTexture.sample( MyUV );`

### iResolution.xy[​**](#iresolutionxy "Copy to clipboard")

**Node:** Texture 2D Parameter → Texture Size.xy or Texture 2D Object Parameter → Texture Size.xy

![](/assets/images/shadertoy-to-lens-studio-6-93437fa41d5989993a0e30816b9d139a.png)

Texture parameters can return the attached texture’s dimensions and pixel size (1/textureSize). To get the screen resolution, attach a Screen Texture to this parameter.

Another option is to send the resolution from Script to a float parameter.

For Parameters to appear in the inspector panel, and for the texture size to be returned correctly, they must be sampled, and the sampled value must contribute to the final output of the material or they will be compiled out.

**Code Node:**

```
input_texture_2d MyTexture;
output_vec2 Result;

void main()
{
    Result = MyTexture.textureSize();
}
```

### fragCoord.xy / iResolution.xy[​**](#fragcoordxy--iresolutionxy "Copy to clipboard")

**Node:** Surface UV Coord.xy

![](/assets/images/shadertoy-to-lens-studio-7-78b72e19dd37983851ff4aa60746fc34.png)

**Code Node:** `system.getSurfaceUVCoord0()`

### fragCoord[​**](#fragcoord "Copy to clipboard")

**Node:** Texture Size.xy \* Surface UV Coord

![](/assets/images/shadertoy-to-lens-studio-8-68fdbff70585f5759c0881266918134a.jpg)

**Code Node:**

```
input_texture_2d MyTexture;
output_vec2 Result;

void main()
{
    Result = MyTexture.textureSize() * system.getSurfaceUVCoord0()
}
```

### fragColor[​**](#fragcolor "Copy to clipboard")

**Node:** Shader → Color (Pixel).rgba

![](/assets/images/shadertoy-to-lens-studio-9-3941e4082bb978d8751b36a188fa3826.png)

### iMouse.xy[​**](#imousexy "Copy to clipboard")

**Node:** Float Parameter

Use a Float Parameter with two channels (xy) to get the eventData.getTouchPosition().xy value from script.

**Example:**

```
// @input Asset.Material material

function onTouchHandler(eventData) {
  script.material.mainPass.tapPos = eventData.getTouchPosition();
}

var touchStartEvent = script.createEvent('TouchStartEvent');
touchStartEvent.bind(onTouchHandler);

var touchMoveEvent = script.createEvent('TouchMoveEvent');
touchMoveEvent.bind(onTouchHandler);
```

![](/assets/images/shadertoy-to-lens-studio-10-62bc0a927ccf58f9a94957e7f1b1c92b.png)

### iDate[​**](#idate "Copy to clipboard")

**Node:** Float Parameter

Use the Float Parameter to get the .xyzw time (year/month/day/time in seconds).

**Example:**

```
//@input Asset.Material material

var event = script.createEvent("UpdateEvent");
event.bind(function (eventData)
{
   var date = new Date();
   var year = date.getYear();
   var month = date.getMonth();
   var day = date.getDay();
   var time =  (date.getHours() * 60.0 * 60.0) +
               (date.getMinutes() * 60.0) +
               date.getSeconds();
   var iDate = new vec4(year,month,day,time);
   script.material.mainPass.iDate = iDate;
});
```

![](/assets/images/shadertoy-to-lens-studio-11-9a9b0294c3042c4b6b52323209042c6e.png)

### iSampleRate[​**](#isamplerate "Copy to clipboard")

**Node:** Float Parameter

Use the Float Parameter and get the script.api.sampleRate value from script.

More info see: <https://developers.snap.com/api/lens-studio/Classes/Providers/#audiotrackprovider>

**Example:**

```
// @input Asset.AudioTrackAsset audioTrack
// @input Asset.Material material

var control = script.audioTrack.control;
script.material.mainPass.sampleRate = control.sampleRate;
```

![](/assets/images/shadertoy-to-lens-studio-12-8027cdcba61b48ecbbf7367eddb96d62.png)

## Shadertoy Example[​**](#shadertoy-example "Copy to clipboard")

Shown below are some examples of how shaders from Shadertoy can be recreated in Lens Studio

### Default Shader[​**](#default-shader "Copy to clipboard")

Let’s consider the default shader on Shadertoy: <https://www.shadertoy.com/new>

```
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

    // Output to screen
    fragColor = vec4(col,1.0);
}
```

### Material Editor using only Nodes[​**](#material-editor-using-only-nodes "Copy to clipboard")

Below is how to recreate this shader using only nodes in Material Editor. The Swizzle at the end constructs the final (x, y, z, 1.0) vec4.

![](/assets/images/shadertoy-to-lens-studio-13-786b068808604d6d6570f6507d22c8f3.png)

### Material Editor with Code Node[​**](#material-editor-with-code-node "Copy to clipboard")

You can also use a Code Node to transcribe the shader code in a more direct way. The code used in the Code Node is very similar to what’s used on Shadertoy, the main difference being how the Time uniform and the UV coordinate are called:

![](/assets/images/shadertoy-to-lens-studio-14-41d3fa1a6157992968434e513fe5e75a.png)

**Code breakdown:**

```
output_vec4 Result;

void main()
{
   float time = system.getTimeElapsed();

   // Normalized pixel coordinates (from 0 to 1)
   vec2 uv = system.getSurfaceUVCoord0();

   // Time varying pixel color
   vec3 col = 0.5 + 0.5 * cos(time + uv.xyx + vec3(0.0, 2.0, 4.0));

   // Output to screen
   Result = vec4(col,1.0);
}
```
