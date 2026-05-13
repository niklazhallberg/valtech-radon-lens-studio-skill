# Classification

This guide teaches you how to utilize [Machine Learning](/lens-studio/features/snap-ml/ml-overview.md) model to determine whether a thing of a certain class is detected or not and apply an effect based on this information. It comes with a model example to determine whether a person is wearing glasses or not and show some effects when state changes.

[](/img/lens-studio/classification_classification.webm)

The `Glasses Classification` example is available in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project, create a new Orthographic camera and place the prefab under it.

## Guide[​**](#guide "Copy to clipboard")

You can skip to the **Triggering Effects** section if you’d like to use the Glasses Classification model. Or, if you already have a binary classification model, you can skip down to the **Importing Your Model** section below.

### Creating a Model[​**](#creating-a-model "Copy to clipboard")

This example relies on a machine learning model to predict the probability of something. While an example ML model is included, you can create your own model to predict whether something is in the camera feed. The following section will teach you how to train your own binary classification model.

#### Prerequisites[​**](#prerequisites "Copy to clipboard")

To create a model, you’ll need:

* **Machine learning training code:** code that describes how the model is trained (this is sometimes referred to as a notebook). Please find our [example notebook here](https://github.com/Snapchat/snapml-templates/blob/main/Classification/eyeglasses_classification.ipynb).
* **Data Set:** collection of data that our code will use to learn from  (in this case we will use the [CelebA](http://cocodataset.org/#home)).

### Training Your Model[​**](#training-your-model "Copy to clipboard")

There are many different ways you can train your model. For our example, we will use [Google Colaboratory](https://colab.research.google.com/). To see other ways of training, take a look at the [ML Frameworks](/lens-studio/features/snap-ml/ml-frameworks/export-from-pytorch.md) page for more information.

Head over to Google Colaboratory, select the `Upload` tab, and drag the python notebook into the upload area.

[](/img/lens-studio/classification_importing-model.webm)

Provided example is using the famous CelebA dataset for training the model. It's a dataset of images with celebrities' faces. Every image is labeled with a set of attributes. One of them is the presence of eyeglasses, so the dataset suits perfectly for our task.

 You can swap out `MAIN_ATTRIBUTE` parameter for a different one from list\_attr\_celeba.txt in the notebook before running it to change what your model is trained to predict!

Running the notebook will install all the necessary libraries and mount Google Drive. To train a model, however, you have to provide the training dataset (images, annotations, and train/test partition lists) from [the official CelebA Google Drive](https://drive.google.com/drive/folders/0B7EVK8r0v71pWEZsZE9oNnFzTm8).

### Connecting your data set to the notebook[​**](#connecting-your-data-set-to-the-notebook "Copy to clipboard")

Next, we need to provide our code to have a reference to the data. One way to do this is to place them in a folder named `CelebA` at the top level of your Google Drive, and then let Google Colab access your Google Drive. To do this, uncomment `#copy_files_from_drive()` From the notebook.

 After uncommenting this line, do not re-run the code cell since it’ll interrupt the flow of computation.

Alternatively, you can bring the files directly to Google Drive by uploading it to the sidebar. Make sure the directory matches directory called in the code.

If you upload the dataset to your notebook, it will only be stored there temporarily.

**Train your model**

With our files added, you can run the code by choosing  `Runtime > Run All` in the menu bar. This process may take a while to run, as creating a model is computationally intensive.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAbwAAAA6CAAAAADuRbNyAAALrElEQVR42u3c308TWRsH8P1Xnvte9qZXJr0w6QUhMeRNNo0xQ5rGVX3VpsempNhlC+sCLlsFZJcKKywoWikKS1ZRBAkLuoKqINIiCqK0iFCgP2zpdL57MUxbSov7vmx2S+1zM6XnTOeZ+dDnnJ4OfIGMD4Ffd+001nkB2RdfZL5ddP2ja4ev4fq4HhVyeP/GGy/k2zGeL8Tn8P6FiEaC3h3jeYORaA7v36iagaUd4y0FsrFu7gY8/+KO8Rb9ObwcXgbiLXo8Ho8nyLsE1F1K01PsEwAANDWAd6W4GFGxXfD4A7OfPvby6l/D80l4vMfj8afruLC8HZ5vPSoAEY8Ya8l56x+k3pH3hAFgKZ5p2uuDsHdnFLdvpXp2zev1er1e8WKH3/jEi/KWj+PJiIiofZDGoNaneW2xTz0A4CstBmkMT0eS85fpAGCUOn6gT08QVIZtm9/cSsabIiLa37L1lfumgQLNp/EekRjmZCOyp97xJQ0CwN6i2DNprw/62cdUTz+Z/4t4tdWJP30cEZ3KGGOMsQAADBsYs74Fuo3McDmOZ3a73e5gaJDfBs/sdrvdfgkvNMjjxP7kTiUUBGChwOIj7BTvCglb8Drcj810eWtudYBz5tN46273S6p3u1f+QTzDr/8X3jwTTzro8/l81ioAWGANS6+NlZhhdwIP2OsYXpX4u16xDLUeWGhmF4JbLlDVRrE7yy5rtXhT8aFSqahIqnxP6SbAy05iqA7AQIllFPMVHqD6KdDevhXvRaWrvHQMgLPGMhQBPnYaqt5hraLfYm87QBXjyXiDAC8/jLrfAVdFcK1ivLaoj39TQf+px5VuTHz/1GIaCDUb7KvS0TfjAQiITi+qDa2R2JYneyyFdHhialDrccvRaSifSYvH3/u56y2Auc5Lz/n311jFbwAA792LD4JSq+faCjB1jcfc9YvDANauN/RVVyfs/vxnVh+rawtsDM4uDLMFoM2AB80CYLyWhPeQZqDWY3mPQk8FQmq84B46kkdaPKRXp5Xy08m/w8rDwO80jFo50ETafBoIkB1TxCDIa7fidZFcl0evMUJaPdWAP0x6hWzRQ5Tf2rKfysZS4AVlJsjPAT3k9RBpCsk+e5oKzkOtRyfJjUraqzpBR6Sjp8EboT0H6Ute2vJkl1JIh7eRGtR6mEh5gmSr6fDOGloqmQdOVn2BdS60sfIuAFg3ljYbz0itQXYHqKvAS1ZWwxwIF7O6UladsPt4A6uLjcMtZgGdRh4AcE68ik52P4anMplMzRKeRRbEICUP4TKZSqXS4io9RFilxUOaSVE2UU9rKFLwqJXjA9UDBV+i8ATqSRaZprFUePcRpEYY5EDzQdyix1ijag+dTVM2bQ87ORqK450D9mvFsqnWo5OcWCMlj4sUkI6eGk+p5jFAXdKWJ7uUQjKeQqVSqahISg1qPUyKAKapJw1eoGECUaMdjUbgTk2sbI4wN5wVH6RWWwXC7B5KrICDhe8xJyKW6sTdpbIJYJUNABDT/4NNAuguYS3RGF5eSUnJJQkvX2m1Vm4ZWWSFDoejB1/LeOCrtHhuuh6SWYFaOfrIZLUWyNAii+77kYavyKOp8AJA3te4SfuvfgDKyWq1yo95aCANHhHRMOJ4A0C5MgEvCKgswDDNSkdPibdMTQAvs0hbnuxSCsl4ZQ6HwyEvklKDWg/TPgB7i9O98yKurkajDSPs+3ur8TFvwVDSPR9vHWPeR8wXYFUdHfXsXYshGhvzNjok4F03hKWHM+wGAIx3lhrfpC6bsj06nU53N3XZZHuxHR4OFPbSa6BWjjY6rNPpGGaoj94esZwwIj0eRotkdBEnSKfT6erT4w3iEbV/Gu8+zUpHT4k3TbcBKA3Slie7lEK6srmRWgxPXZgGL1puutRvtgFTFw2sJz5heX/NzH7ipVbecPdCLeZZuc1ms3kaSmITFqlDHC9kuBEb/Ix1G+8A3tiSGq9gLwA+zYTlHC0D2vR4naQuAFArxxD1AEIUUCry0C2X3dwG7/ofiJgoaKVFgMd2ePhKHsTer4HftseLHT0VXogsgIdapC1PdimFdHgbqUGthykfWKfGNHjjbByosGFoEnwTC0t4E/eBQTYptaKtzDCCMLsEIIobzAeIExapQxyvl0nD62pxVQRAd40AnK5OjeegMucdxWQyHnvy5MmT+WnSjraRiFeumEqeniFA1CbihZXKmy4DA76jGqwRrW6D91/50MuD8tA0FY4+zreLeHdpaC0F3hSdR7l8+IEyAS/v4FwyXuzoKcc8s6z54QHZnLTlyS6lkA5vIzVxwnJl0kCurXgT09PT817WPN3OzuJH48R8jXEdpTXvAaCPDXhusFmpFa+ZIQw0Gm67b5nD86za1S9OWKQOfvareMF4UxMAvLyFUJlham5uzj/Iut71sbEY3g9xPAbhJyJZTeoP6ZXoINqTL+KNyWl66+caWhHxMF1AlD8LDNELQKPe0jPPgC4KAnklWCok+nIY6FMQHQt6aBBAII+upsBDEXmnOSKOvB4aFPHsJIeaxfEe0Gzs6CnxAgaivNHYlid7LIVNMR3/qCCmBjWDSa4ism45nXuMMcbO4LaRlZabsHqWscoJYIAZAYBvY6ykF1IrYG4CEGhgzPQE+J2x4jJxzJM6NDHbxhTlLQC0G/gp8fN6v3C7jFluCunWNqNL2ywE8vF1KP4TK0KBwF9eHApvrHt5E97Ly/xmvIRY2VzWg/5tj56AJ8X62uZtQgrpQkrNtA8r4e1W9DZeJyLW4PBGKRZ8m1o3IiL+GPVt2T2wuaptOuHArlmY9v0NC9O+v3Fh2rQv1bN29o9HDu9/j3Mncl8J7Vq83Pd5ObzP58tYYUfhfO8L81EhK2K34b13RncWkwtroQgfzY6I++0CvLB/8cUOX2TCsxIIhdezIiJ8jG8X3Pq37nu/4zEvqyJ2+/euwNvxhCWrIn77dw5v9+HFbv/+IuOLxOSLZyM5vES8kWcvJl0ul8v1edwxnV14sdu/P4+bbrMLL3YHcQ4vh5fhy2NZhufL4eXwcng5vBxeDi+Hl8PL4eXwcng5vKzG+9DR0fGY36bDgVac0+XwMhJvhArUMllb+g6qepRxGXNCzjOtq8Dod44QAGBgGXD3dL1M6NF6JvbwUW9vb29vCK86+4NZiudBxERBgQfAAzyCsbttl/lMw+O1v5gascLZj3cDwGsuiHbu1HGuC7jUL3axmWO9T2mLi4uLV3q5k9zxSLbioY9mm5TAM1pykY7IAgAYU5KsPMPwZjnh+SHcO4Ub5QBwoRpPuWHAoQ1HixqjiAp+v80M4JU+AODUeQAQNK34wD3LVrz3WoUQw9N7HOQBgL261QGazCw84ZjlrOYXy6FG7SCAdc0ELmqigP+b5xzHHYfmJNdqMwN4zq3F8BY4F2Buzk48uYIUI4jhzYGnmwAQ5p19spYMG/MCPbWatm+PXnEBwOBRAcWVYkPY2BCB5vj4qs2M1eVhbnbZj1OlTqdzKcD1A9bi7MS7OXKgAHG8twB1A8BVueoYZRoe8Oog+r4VH5a0AzrpL/1MFwHNHcBmxnGO4ziuCqc4rVbbBfOh3hbuu2wtmy+oB63yJLw1agEUmYY3fvoYpz+oOdkWABa5ZeAbEwCsrYt4vYDNjMX5e5xr3rtRNrFqPXrGcCFrJyz6PREX3Xl7JBEvLLfM/kT1mYUX0vx2Rzvxi/Fp0TXgaimAZi4EvOYmE/E2j3kAsKL5IxvxRskDvKHLMBOpaclF76Sy2amgfXuMUNlQVpgp5+PmfL1GPD0aabVCOHQfwBJXveg0FwOnT/vT4c1cOmQQsnt5LJj8L4iElcw7oRpOMwLBzGlf4pk2AgDOY5zm/BxwX3MImj7AVgLpry0lvEPHm0PIbrzdEYshAHDzgMOx8ZQ/CgAIffzslsc+t8jhZQee0vIOQG8B5VfxObxdhicn5QoeEeXJqCiHt8vwhHL6HmfpPLwnH+Twdhfen0GYHUPljeESAAAAAElFTkSuQmCC)

When using a data set to train your model, make sure that you adhere to the usage license of that dataset.

#### Downloading your Model[​**](#downloading-your-model "Copy to clipboard")

You can scroll to the Train Loop section of the notebook to see how your machine learning model is coming along.

Once you are happy with the result, you can download your `.ONNX` model!

We would like the model to be small and fast to make our Lens experience optimal for the user, so for this simple task, it would be a good decision to train a small model from scratch rather than use transfer learning from a large pre-trained model.

### Importing your Model[​**](#importing-your-model "Copy to clipboard")

Now that we have our model, we’ll import it into Lens Studio.

You can drag and drop your file into the `Asset Browser` panel to bring it into Lens Studio.

[](/img/lens-studio/5-snap-ml/classification-import.webm)

### Setting up MLComponent[​**](#setting-up-mlcomponent "Copy to clipboard")

If you are using the built-in ML model, you can skip this section.

Next, we’ll tell the Lens Studio to use this model. In the `Scene Hierarchy` panel, select `ML Component`. Then, in the `Inspector` panel, click on the field next to `Model`, and then in the pop up window, choose your newly imported model.

[](/img/lens-studio//5-snap-ml/classification-set-model.webm)

After the model is set additional build, run, input and output settings become available in the ML Component UI.

To learn more about what each setting does take a look at the [ML Component](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md) Guide.

![](/assets/images/classification-build-run-82ae21205dc719cedebe359846e452d1.png)

MLComponent has an `Auto Build` checkbox selected, this means the model will be built automatically after the lens is initialized.

By default we have the `Auto Run` checkbox disabled since we want a more fine control about how our model works. Specifically, this example uses [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) to configure how the model is run.

In this case, we set the model to run on every frame and with both start and end timing set to `FrameTiming.Update`. You can find more information about run modes and frame timing [here](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md).

![](/assets/images/classification-main-b35ec8250824a5f038856ec17761915c.png)

You can modify these settings if you want a different behavior, for example, to run the MLComponent on tap or other interactions.

### Input[​**](#input "Copy to clipboard")

Our model was trained on the `CelebA` Dataset that consists of the square images of people’s faces. We can use `Face Crop Texture`, which crops an area from `Device Camera Texture` based on a person’s face to feed similar input to our model.

`Face Crop Texture` can be created by clicking the `+` button on the `Asset Browser` panel and selecting `Face Crop Texture`. It is initialized with default settings - `Device Camera Texture` as an input.

![](/assets/images/classification-input-f070ee8d36a95ad91b7d83ddba660c58.png)

When a face is not detected by the camera - Face Crop Texture will stop updating and model will not run.

The output of this ML Model is an array of probabilities. Because we have only one class - output array length is 1.

The output data is represented with an array (Float32TypedArray) of size 1 (1x1x1) which is processed by the `Glasses Classification Controller` script.  

![](/assets/images/classification-output-b5f779868a970aa56941001ab9d2c998.png)

## Customizing your Lens Experience[​**](#customizing-your-lens-experience "Copy to clipboard")

If you are using the built in ML model, you can skip this section.

With our model hooked in, let’s take a look at the `Glasses Classification Controller [EDIT ME]`.

![alt text](/assets/images/classification-main-controller-5aa36987be0c3da963623a651c85e560.png)

Select the object in the `Scene Hierarchy` panel, and then take a look at the `Inspector` panel for the following settings:

**ML Component:** - set your MLComponent here.

**Output Name:** - set this input to match the output name of your neural network in order to access its data.

You can see this name in the ML Component we just set up.

**Class Index:** is an index of desired class in your neural network. In this example we have an output array of length 1, so the index is equal to 0.

As we already mentioned our model provides us with the probability of whether glasses are present or not. So this example allows you to trigger an effect , when the object was just found or just lost.

The **Threshold:** parameter defines what probability is counted as found or lost. The default value is 0.5.

**Scripts With Callbacks:** parameter is a list of scripts with specific API functions: `script.onFound` and `script.onLost`. It will call these API functions when the probability provided by our model crosses the threshold number.

Add scripts to the list to add more effects to trigger, or delete scripts from the list if you don’t need them.

**Show Debug:** enables a debug progress bar to visualize probability. You can use this to figure out whether or not the model has been hooked up properly, as well as what value you should use for threshold.

Disable this checkbox before publishing your Lens if you don't want to show the predicted probability!

[](/img/lens-studio/classification_classification-6.webm)

### Triggering Effects[​**](#triggering-effects "Copy to clipboard")

This example includes a few helper scripts and methods to trigger effects based on the **Scripts with Callbacks** list mentioned above.

The **Simple Text Example** provides a simple scripting example of modifying a text of a `Text` component. Please use the `ClassificationExampleHelper` script as a base of your own script.

```
// Do something when glasses are found
script.onFound = function () {
  // set the text on a Text Component
  script.text.text = 'Glasses';
};
// Do something when glasses are lost
script.onLost = function () {
  // set the text on a Text Component
  script.text.text = 'No Glasses';
};
```

To learn more about APIs and scripting, check out the [Scripting Overview](/lens-studio/features/scripting/script-overview.md) guide.

[](/img/lens-studio/classification_classification-11.webm)

The `ClassificationBehaviorHelper` script to Send Custom Triggers when class is found or lost.

![](/assets/images/classification-behavior-e52f51a13b01417789efaa0a5596e191.png)

In the `Scene Hierarchy` panel, select the `Behavior Example` scene object and customize custom `Behavior` script triggers and responses.

Take a look at the [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) guide for more information on what you can trigger with Behavior.

[](/img/lens-studio/classification_classification-8.webm)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
