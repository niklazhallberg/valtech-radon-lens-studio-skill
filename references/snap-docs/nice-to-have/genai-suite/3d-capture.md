# 3D Capture

The **3D Capture** Plugin enables Lens Studio creators to transform real-world objects into high-quality 3D assets through a video-to-3D conversion process. By capturing a 30-second video, users can reconstruct an object, generating a `.PLY` file that can be imported directly into Lens Studio for use in augmented reality (AR) experiences. This tool opens new creative opportunities for Lens creators by allowing them to integrate real-world objects into their lenses.

[](/img/lens-studio/5-platform-solutions/gaussian-table-video.webm) [](/img/lens-studio/5-platform-solutions/armchair-3D.webm)

## Getting Started[​**](#getting-started "Copy to clipboard")

### Launching 3D Capture Plugin[​**](#launching-3d-capture-plugin "Copy to clipboard")

1. Navigate to the `GenAI Home Page` using the `Lens Studio AI` option in the top right corner of the Lens Studio.

   ![](/img/lens-studio/5-platform-solutions/genai-suite-menu-3d-capture-icon.png)

2. On the `GenAI Home Page`, you may need to scroll down to find the menu of GenAI tools. In the panel, select 3D Capture.

   ![](/img/lens-studio/5-platform-solutions/genai-suite-menu-3d-capture-menu.png)

### User Interface Overview[​**](#user-interface-overview "Copy to clipboard")

* **Create new Asset Toolbar:** Contains tools for creating 3D models:

  ![](/img/lens-studio/5-platform-solutions/gaussian-create-new-asset.png)

* **Gallery:** Displays all assets you created and their statuses.

  ![](/img/lens-studio/5-platform-solutions/gaussian-gallery.png)

* **Search:** Allows to search through the created assets.

  ![](/img/lens-studio/5-platform-solutions/gaussian-search.png)

## Creating a 3D Asset with 3D Capture Plugin[​**](#creating-a-3d-asset-with-3d-capture-plugin "Copy to clipboard")

### Upload your video[​**](#upload-your-video "Copy to clipboard")

* **Pre-record a video:** Capture an object you want to reconstruct on a video (30 seconds recommended).

  [](/img/lens-studio/5-platform-solutions/gaussian-table-video.webm)

* **Upload a video:** Upload the pre-recorded video reference into the plugin.

  ![](/img/lens-studio/5-platform-solutions/gaussian-video-reference.png)

### Object selection[​**](#object-selection "Copy to clipboard")

* **Input a text prompt:** Upon uploading, specify the object you wish to reconstruct with a text prompt to improve identification accuracy.

  ![](/img/lens-studio/5-platform-solutions/gaussian-select-object-1.png)

* **Confirm the object selection:** Review the video preview. A yellow bounding box highlights the object based on your entered text prompt. You can adjust it at this step by modifying the text prompt and pressing the `Regenerate` button.

  ![](/img/lens-studio/5-platform-solutions/gaussian-select-object-2.png)

### Generation[​**](#generation "Copy to clipboard")

* Press `Submit Selection` when you are ready.

  ![](/img/lens-studio/5-platform-solutions/gaussian-generate-asset-button.png)

* Check upon the Status bar for info.

  ![](/img/lens-studio/5-platform-solutions/gaussian-10-15-min-warning.png)

* Once the generation is complete and the asset is ready you can preview your asset.

  ![](/img/lens-studio/5-platform-solutions/gaussian-preview-asset.png)

### Delete 3D Asset[​**](#delete-3d-asset "Copy to clipboard")

* You can also delete the asset

  ![](/img/lens-studio/5-platform-solutions/gaussian-delete-button.png)

## Create a Lens[​**](#create-a-lens "Copy to clipboard")

### Import to Project[​**](#import-to-project "Copy to clipboard")

* Press `Import to Project` button to start creating a Lens with your 3D asset.

  ![](/img/lens-studio/5-platform-solutions/gaussian-import-to-project.png)

## Best Practices for Capturing a Video[​**](#best-practices-for-capturing-a-video "Copy to clipboard")

### Do ✅[​**](#do- "Copy to clipboard")

* Capture the object of interest from all possible angles.
* Maintain a reasonable distance from the object to include some background.
* Make sure the surroundings are well lit.
* Avoid using plain and non-textured backgrounds such as plain white walls.
* A typical video length is around 20-50 sec.
* A typical video size is around 40 MB.

### Do Not ❌[​**](#do-not- "Copy to clipboard")

* Shake camera. This can lead to poor quality of overall reconstruction.
* Move too close to the object. This might result in failure to get a splat representation of the object.
* Move the camera such that object is not visible in the frame.

### Examples of Good Captures[​**](#examples-of-good-captures "Copy to clipboard")

* <https://www.youtube.com/shorts/wT-g6NbdzKA>

* <https://youtube.com/shorts/YEYOfAvp1z0>

### Examples of Bad Captures[​**](#examples-of-bad-captures "Copy to clipboard")

Capture is textureless: This can result in failure to estimate cameras causing failure of splat training.

* <https://youtube.com/shorts/u8oWb3nbgTY>

* <https://www.youtube.com/shorts/XHbFgJD9kng>

* <https://youtube.com/shorts/T43DCUMQKEU>

Camera is too close to the object: This might result in failure to get a splat representation of the object or the representation might be poor.

* <https://www.youtube.com/shorts/54QYDJgizDM>

Camera is shaking: This can lead to poor quality of overall reconstruction.

* <https://youtube.com/shorts/dt7U1u2dS5c>

Object captured only partially: This can result in poor performance from back view.

* <https://www.youtube.com/shorts/33xM83tIywA>
