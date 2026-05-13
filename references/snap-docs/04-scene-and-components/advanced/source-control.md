# Lens Studio Project Structure

## File Structure[​**](#file-structure "Copy to clipboard")

Every Lens project is contained within a folder. These folders and files contain information about various parts of your Lens project and are needed.

### Required[​**](#required "Copy to clipboard")

Each of the files and folders in this section will need to exist, or you will NOT be able to open your project.

#### Assets/[​**](#assets "Copy to clipboard")

This folder is the most useful and editable part of the Lens project. This folder is a reflection of your `Asset Browser` panel. You can add/remove/modify files in this folder to add it into your project.

* When it's modified: When the `Asset Browser` panel has changed. For example, on a new project, you will find an Echopark.hdr since this HDR contains the default environment map used to light your scene.
* Source control: Looking at this folder is a great way to see how the project has changed. You should commit things you expect, and if something is unexpected, consider re-opening the project in Lens Studio and modifying the `Asset Browser` panel to reflect what you expect..

You can modify the files within this folder and it will be reflected in Lens Studio. For example, you may modify JavaScript files in this folder, and it will be reflected in your project. If you add new files that Lens Studio needs to process (e.g. 3D models), it will be processed the next time you open your project.

#### project-name.esproj[​**](#project-nameesproj "Copy to clipboard")

The filename is generated when you initially save the project. You do not need to modify this file as it is managed by Lens Studio as you work on your project automatically. This file contains many of the metadata related to your project, such as the Lens Name, structure of the resource panel, various settings, and more.

* When it's modified: On Project Save.
* Source control: You should always commit this. Your source control may report things that have changed in your lsproj, such as which Lens Studio version the project was last saved in, or when it was last saved, etc. In almost all cases you should just commit the changes Lens Studio has made.

This is a good way to distinguish projects from Lens Studio 4 and below, which uses `.lsproj`, from Lens Studio 5 and above `.esproj`.

### Required but not in every project[​**](#required-but-not-in-every-project "Copy to clipboard")

#### Cache/[​**](#cache "Copy to clipboard")

This folder contains additional information about your project that Lens Studio generates. Keeping this folder will speed up your project loading time, but it is not necessary to keep.

### Support Files[​**](#support-files "Copy to clipboard")

These files are used by Lens Studio to make your development easier. It is not required for these files to exist, but are very useful and thus in most cases you should leave them as is.

#### Support/StudioLib.d.ts[​**](#supportstudiolibdts "Copy to clipboard")

This is a definition file used in general Javascript/Typescript development to help developers write code by providing information about functions and methods from a given module. In this case, it provides Lens Studio specific APIs. In other words, this will allow supported IDEs, such as VSCode, to have Lens Studio specific Intellisense.

* When it's modified: It is automatically added to your Lens Studio project starting from Lens Studio 4.19.
* Source control: You should keep this file, though Lens Studio will auto generate it for you if you are missing it.

#### jsconfig.json[​**](#jsconfigjson "Copy to clipboard")

This is a config file used in general JavaScript development to let your IDE know what type of code is being used. In this case, it lets the IDE know that Lens Studio uses the ES2019 version of JavaScript.

* When it's modified: It is automatically added to your Lens Studio project starting from Lens Studio 4.19.
* Source control: You should keep this file, though Lens Studio will auto generate it for you if you are missing it.

### Other Files[​**](#other-files "Copy to clipboard")

#### Backup[​**](#backup "Copy to clipboard")

This folder contains some backups about the resources you have in your project.

* When it's modified: Lens Studio will add these as needed.
* Source Control: Exclude this folder from Source Control. This is only used for recovering from crashes.

## File Management by Type[​**](#file-management-by-type "Copy to clipboard")

Within your Public folder, you will find various files that are used in your Lens project.

### System Files[​**](#system-files "Copy to clipboard")

While the Assets folder reflects the `Asset Browser` panel, not all the items in the `Asset Browser` panel have a 1:1 correspondence with files you may find on your computer.

#### folder.lock[​**](#folderlock "Copy to clipboard")

Throughout your Public folder, you will find a folder.lock in every folder. This file ensures that your source control system commits every folder within the Public folder, even if it may seem empty to your computer file system. This file is important for the integrity of your project and should NOT be deleted.

Every folder.lock is identical. If you accidentally delete one, you can copy and paste the folder.lock from another folder into the one missing it.

Below are some examples of System Files that come with the default Lens Studio project:

* **Device Camera Texture:** the raw camera feed from the device the Lens is running on
* **Physics Root World Settings:** Defines the default physics settings
* **Render Target:** A texture that cameras in the project can output to–in an empty project’s case, one is provided and is what your Lens will output to by default.

None of these will be visible to your source control and thus you do not need to worry about merge conflicts. However, this also means that if you change some settings, you will not be able to track them.

## Lens Studio File Formats[​**](#lens-studio-file-formats "Copy to clipboard")

There are some files that are visible to the computer file system, but are proprietary to Lens Studio. They store various information about specific parts of your project.

#### Meshes (.mesh)[​**](#meshes-mesh "Copy to clipboard")

The .mesh file represents the 3D geometry of an object. It is a proprietary format and can not be exported back into a standard 3D file. It is created when you import any 3D models into Lens Studio.

#### Materials (.lsmat)[​**](#materials-lsmat "Copy to clipboard")

The .lsmat file represents a material which is used to display objects in Lens Studio. It is similar to a shader file, and in fact shaders can be defined within it. It contains both the logic of the material, as well as properties used by it. It is edited using the Material Editor. This file will change whenever a Lens Studio project is opened or saved.

#### Visual Scripting (.lsscript)[​**](#visual-scripting-lsscript "Copy to clipboard")

The .lsscript file represents Lens logic in the form of a node-graph. It is similar to a JavaScript file.

#### VFX (.lsvfx)[​**](#vfx-lsvfx "Copy to clipboard")

The .lsvfx file represents a vfx/particles system which can be used in a Lens. It is edited using the built-in VFX editor. It contains both the logic of the vfx system, as well as properties used by it. This file will change whenever a Lens Studio project is saved.

#### 2D Animation Files (.t3d)[​**](#2d-animation-files-t3d "Copy to clipboard")

The .t3d file represents the metadata of a 2d animated texture. They described how the adjacent textures (atlas) should be used, such as the number of frames, rows, and columns an animation may have. The folder a .t3d is in represents an animated texture in Lens Studio–you must keep them together. You can bring .t3d into another project by dragging in the .t3d into its `Asset Browser` panel and Lens Studio will automatically bring in the entire folder.

You may duplicate animation files in Lens Studio, and when the Lens is exported, if the animation file is exactly the same, it will only count one of them against your Lens size. This is especially useful if you want to display multiple 2D animations, as duplicating the Resource will allow you to have them in different states.

#### Textures (.pvr)[​**](#textures-pvr "Copy to clipboard")

When possible, Lens Studio will compress your images while still retaining its original source file. This is done in the .pvr format.

#### (Object) Prefabs (.oprfb)[​**](#object-prefabs-oprfb "Copy to clipboard")

The .oprfb file is a binary file representing a scene object tree. It can be instantiated in the Scene at runtime, or stored in the scene. It is useful for having multiple instances of the same thing. It is created by right clicking an object in the `Scene Hierarchy` panel, and pressing “Save as a Prefab”.

#### Lens Studio Objects (.lso)[​**](#lens-studio-objects-lso "Copy to clipboard")

The .lso file is a binary file representing a scene object tree. Unlike Prefabs, .lso does not exist within a project–rather it is used to transport an object tree into or out of a project. It is useful for extracting a subset of a project, or bringing in parts of a project into a project. When imported into a project, the .lso will bring in its object tree and all associated resources and it will become part of the project (and not as an instantiable object tree as with .oprfb). It is created by right-clicking an object in the `Scene Hierarchy` panel and pressing “Export Object”.

Other files you may encounter:

#### ML Models (.dnn)[​**](#ml-models-dnn "Copy to clipboard")

Lens Studio may contain a proprietary .dnn file which represents an ML model file.

#### Tracking Data (.td)[​**](#tracking-data-td "Copy to clipboard")

In your Preview folder, you might have a video with a .td file next to it. The .td file contains tracking data information about the video.

## Industry Standard Assets[​**](#industry-standard-assets "Copy to clipboard")

Projects can contain a number of industry standard formats which can be leveraged in a Lens.

#### Textures[​**](#textures "Copy to clipboard")

Images, videos, and even proprietary Lens Studio files such as “Segmentation” are all seen in Lens Studio as a texture. Where you can use one texture, you can use another.

#### Images[​**](#images "Copy to clipboard")

Lens Studio supports common raster files such as .png, .jpg, and .gif. It does NOT support proprietary formats from other software such as .psd, nor vector formats, such as .svg and .ai.

#### Videos[​**](#videos "Copy to clipboard")

Lens Studio supports .mp4 in the H.264 format.

#### Scripting[​**](#scripting "Copy to clipboard")

Lens Studio uses ES2019 JavaScript files, as well as TypeScript. You can edit these files outside of Lens Studio, or use the built in Script Editor.

Some JavaScript functions you may be familiar with are actually not part of the standard JS specification, such as `canvas` and won’t be available. In addition, some JS functions have Lens Studio specific implementation. For example, instead of `console.log`, you would use `print`.

#### 3D Models[​**](#3d-models "Copy to clipboard")

Lens Studio allows you to provide a variety of Industry standard 3D models. Such as .fbx, .gltf, and .obj. The Lens itself will store the geometry data in a proprietary format .mesh, and its material in .lsmat, as described above.

Animation names are used in Lens Studio as references. Each animation should have a different name, lest they override each other.

If you export an object containing a 3D model, only the proprietary files will be stored (e.g. .lsmat and .mesh).

#### Sounds[​**](#sounds "Copy to clipboard")

You can bring in .mp3 or .wav files to use in your Lens. .mp3 files are preferred as they are generally smaller.

As in other software, .mp3 files can not be looped consistently as the file format adds a white space at the beginning of the file intentionally. You can use `.wav` in such cases. However, these files will be bigger, so you should becareful when using it.

#### ML Models[​**](#ml-models "Copy to clipboard")

You can bring in .onnx files into Lens Studio for use with SnapML.

## Source Control Setup[​**](#source-control-setup "Copy to clipboard")

While Lens Studio itself does not contain a source control system, you can use `git` to streamline collaboration on projects. Below are some suggestions when setting up your work. However, you should customize it to your preference and needs.

#### .gitignore[​**](#gitignore "Copy to clipboard")

With Lens Studio 4.40, a dedicated .gitignore file has been added. It is recommended to not edit the provided .gitignore. If you need to add additional items to be ignored such as the examples below, you should create your own .gitignore file.

If you are adding your own .gitignore file, you will need to place the file in the root of your repo, or a folder that contains your Lens Studio project folder. Two .gitignore files in the same folder can potentially cause issues when submitting your work to source control.

Since Lens Studio uses JavaScript, in the process of your development you may use other common JavaScript practices. As a result you might want to ignore things like:

* node\_modules
* yarn.lock
* package.lock

Since everyone’s workflow varies, you should consider other files to ignore based on your needs. For example, you might use a Python file to generate some JavaScript files for your Lens to use, you will likely want to ignore these:

* \_\_pycache\_\_/
* \*.py\[cod]
* \*$py.class

#### Example[​**](#example "Copy to clipboard")

* If a Lens Studio project is saved in a git repository (i.e., a directory in which git init has been called), recommended gitattributes and .gitignore are automatically added (or updated) to the directory. For this to happen, follow these steps:

  <!-- -->

  * From the command line, navigate to your project directory. Call git init.
  * Save your project.
  * Make an initial commit only after completing a and b

* The project format is designed to be both human-readable and to minimize conflicts, allowing multiple developers to contribute.

* Alongside the configuration files, Lens Studio also automatically supplies and integrates git merge tools that reduce the number of git conflicts to only the essential ones, e.g. if two users actually modified the same property.

* It is okay for two users to modify non-overlapping properties on the same object in parallel.

![](/img/lens-studio/whats-new-with-lens-studio-3.png)

To quickly set up a version control friendly environment, you can use the following walkthrough on how to enable collaboration between users.

For Example:

Collaborator 1:

1. Create a new repo for the Lens Studio 5 project.

2. Make a commit with the current project to the main branch.

   <!-- -->

   1. `git add .`
   2. `git commit -m "initial project"`

3. Make a new branch and Make some changes. You should save the project.

   <!-- -->

   1. `git checkout -b new_branch_collaborator1`
   2. Make changes
   3. `git add .`
   4. `git commit -m "new commit"`

Collaborator 2:

1. Clone the main branch.
   <!-- -->
   1. `git clone repo+url`

2. Make a new branch from the old main branch. Make some changes and save the project.

   <!-- -->

   1. `git checkout -b new_branch_collaborator2`
   2. Make changes
   3. `git add .`
   4. `git commit -m "new commit"`

Collaborator 1:

1. Merge new branch to main branch.
   <!-- -->
   1. `git merge new_branch_collaborator1`

Collaborator 2:

1. Merge new branch to new main branch with conflict commit

   <!-- -->

   1. `git merge new_branch_collaborator2`
   2. You will get a conflict. Please resolve the conflict. An example: `CONFLICT (content): Merge conflict in Project/Assets/Scene.scene Automatic merge failed; fix conflicts and then commit the result. Go to Scene.scene file to solve the conflict in VS Code. From: rotation: {x: 0, y: 20, z: -30} rotation: {x: 0, y: -20, z: -30} To: rotation: {x: 0, y: 20, z: -30}`
   3. `git add .`
   4. `git commit -m "resolve conflict"`
   5. `git merge new_branch_collaborator2`

Project will automatically update to the merged version.

#### GitLFS[​**](#gitlfs "Copy to clipboard")

There’s are number of binary files Lens Studio uses in order to store information about your project. In many cases you will want to use GitLFS to store these binary files. GitLFS allows your repository to store pointers to a binary file, rather than keep the binary file within the repository itself.

However, when using GitLFS, it is important that you set this up early, and every collaborator is aware. If your collaborators don’t install GitLFS, then their computer will only hold the pointers to the binary file rather than the actual binary file and Lens Studio will NOT be able to open the project.

If your git repository is using GitLFS and you have trouble opening a project, try running `git lfs install` to install GitLFS, then `git lfs pull` to turn file pointers into the actual files.

## Workflow Suggestions[​**](#workflow-suggestions "Copy to clipboard")

Since Lens Studio involves a lot of binary files, it is important to be strategic in how you set up your project to prevent headaches, especially when multiple people are working on the same project.

In addition, since the Lens Studio Public folder can be modified without re-saving the project, when you haven’t changed the Lens Studio scene, you should skip saving the Lens Studio project and only modify its assets. This will prevent potential conflicts with binaries that may have automatically changed (e.g. any materials, project.data, etc.)

### Lens Studio Versions[​**](#lens-studio-versions "Copy to clipboard")

Make sure all developers are using the same version of Lens Studio. Advise your teammates not to automatically update Lens Studio when prompted.

If you do need to update Lens Studio (to take advantage of some cool new tech, for example), have one person do so first. They can then test the Lens and make any necessary fixes for compatibility with the newest Lens Studio. Only have the rest of the team upgrade once the updated project has been posted to the repository.

### Development Strategy[​**](#development-strategy "Copy to clipboard")

With Lens Studio 4.40 and later, you should focus on utilizing some of the new solutions as a safe and source control friendly way to build upon your Lens Studio project. Thus, as with other software development practices, it is important to break down your project into smaller modular pieces that can be managed separately, such as using .lso files and prefabs.

When re-importing LSO, you may end up with multiple duplicate resources if they are not identical. One way to solve this is to delete old instances, and File > Optimize Project to remove old resources.

.LSO files will wrap every file, including scripts, into a binary. This means that you will not be able to diff changes to your scripts or LSO. As a result, you will usually want to store the project that generates the LSO in your source control as well.

In some cases you may want to save them as Prefabs. This option is good as the Prefabs can later be switched easily, since they are seen as “one unit” in a Lens project. However, it might make it harder to edit since what’s inside the prefab is opaque (e.g. you can’t see the objects tree within a prefab.

Prefabs can't reference other prefabs. If you want to export objects that have "prefabs," you must embed the "prefab" as a child object and duplicate that.

### Working with Scripts[​**](#working-with-scripts "Copy to clipboard")

* Since scripts can be modified and be inspected without opening the Lens Studio project, sometimes it’s good to store variables in JS/TS files rather than in the Lens Studio scene (e.g. using // @input). This way you can inspect changes, as well as tweak parameters without resaving the Lens studio project.

* For large projects with a lot of scripts, it helps to explicitly divide PRs into scripts-only PRs and Scene/Resource PRs.

  <!-- -->

  * When making Scene/Resource changes, avoid making any script changes other than the absolute minimum necessary to keep the lens working, including their attributes in the Inspector panel. This way, reviewers won’t need to launch Lens Studio to review changes and can perform the entire review within GitHub just like regular code reviews.
  * Lens Studio will occasionally make a lot of changes to non-script files even if the only changes you make are script changes. Those changes are just metadata updates and are safe to revert. You should do so before sending your changes for review if you didn’t make any non-script changes.

* It’s OK to add stub PRs that set up the Lens scene for upcoming Script changes.

  <!-- -->

  * Example: For a feature that requires a new script file that takes multiple inputs, you can split this into multiple PRs:

    <!-- -->

    * The first PR will add an empty script file that defines its required inputs, and will add its ScriptComponent with the relevant values. At this point, there is no change to the lens behavior.
    * The second PR will add all the required script code to implement the new behavior, potentially also delete all the script code (except for input comments) that provided removed functionality. At this point, the new feature will be implemented, but there might be some zombie Scene objects and components left behind.
    * A third PR can then clean up any Scene objects, and ScriptComponents, and Script resources that are no longer needed.

## Working on Large Projects[​**](#working-on-large-projects "Copy to clipboard")

* If Lens Studio is constantly using high CPU usage, consider pausing the preview video. As you can imagine, continually running ML models and other processes will take a toll.
* Using TypeScript will allow you to make your script `type-safe` and make it less likely for you to run into accidental errors. In addition, it allows you to componentize large projects better so that multiple team members can modify different parts of the script together.
* Using [require](/lens-studio/features/scripting/script-modules.md) will also allow you to componentize your projects so they can be handled in a more manage-able fashion.
