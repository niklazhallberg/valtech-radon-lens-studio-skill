# Export from PyTorch

In general, the procedure for model export is pretty straightforward thanks to good integration of `.ONNX` in PyTorch.

The code itself is simple. First we import torch and build a test model.

```
import torch
import torch.nn as nn
class Model(nn.Module):
    def __init__(self):
        super().__init__()
        self.layer = nn.Conv2d(in_channels=3, out_channels=1,
                               kernel_size=3, stride=2, padding=1)

    def forward(self, x):
        out = self.layer(x)
        out = nn.functional.interpolate(out, scale_factor=2,
                                        mode='bilinear', align_corners=True)
        out = torch.nn.functional.softmax(out, dim=1)
        return out
```

The code for the export itself is then

```
model = Model()
model.eval()
random_input = torch.randn(1, 3, 64, 64, dtype=torch.float32)
# you can add however many inputs your model or task requires

input_names = ["image"]
output_names = ["pred"]

torch.onnx.export(model, random_input, './model.ONNX', verbose=False,
                  input_names=input_names, output_names=output_names,
                  opset_version=11)
```

It is important to make sure that the number of elements in `input_names` is the same as the number of input arguments in your model’s `forward` method. As well as that the number of return variables of the forward method is the same as the number of elements in `output_names`.

Make sure that input shapes are correct since you won’t be able to change them when you import the model in Lens Studio. It just takes them from your `.ONNX` file.

You can download this guide as .ipynb [here](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Templates/PVJcA0OXrT_3_0/ML_Resources/export_pytorch.zip)

## Loading Models into Lens Studio[​**](#loading-models-into-lens-studio "Copy to clipboard")

The process for importing your model into Lens Studio is straightforward. Import the model into your project by dragging and dropping your model file into the `Asset Browser`. With an **MLComponent** selected (create one if you don't have one by selecting a Scene Object and adding an **MLComponent**), select your `ONNX` file that you imported previously to link it to the **Model** field on the **MLComponent**.

Take a look at the [Compatibility](/lens-studio/features/snap-ml/compatibility.md) guide to learn more about supported Layers

One of the most useful apps for debugging ONNX files is [Netron](https://github.com/lutzroeder/netron).

You can open your `.ONNX` file in Netron and find the Op that’s causing the issue by name.

![](/assets/images/export-from-pytorch_image-b-ba017330f69a8e9b442c48bb8d1ac1aa.png)

You can then see if you can reimplement your model avoiding unsupported operations.

Remember that Lens Studio textures have values in the range of `[0, 255]` so if your mode was trained with whitened input with values in `[-1, 1]` you need to correctly set scale and bias parameters to reflect that.

Check out the [ML Component](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md) guide for more information!

# Common issues

One of the major issues is bilinear interpolation. There is a discrepancy between PyTorch and mobile inference frameworks in handling edges of interpolated image with `align_corners` set to `False`. So you need to make sure your model uses `align_corners=True` everywhere it uses bilinear interpolation. Also you should use `opset_version=11` if you have `align_corners=True` in your model, since default 9th opset doesn’t have this parameter in its op definition. It might also be better to use nearest neighbor interpolation or transposed convolution instead of bilinear interpolation, since iOS inference accelerator doesn’t support `align_corners=True`.

```
x = random_input
# bad
nn.functional.interpolate(x, scale_factor=2, mode='bilinear')
nn.functional.interpolate(x, scale_factor=2, mode='bilinear', align_corners=False)
nn.Upsample(scale_factor=2, mode='bilinear')

# better
nn.functional.interpolate(x, scale_factor=2, mode='bilinear', align_corners=True)
nn.Upsample(scale_factor=2, mode='bilinear', align_corners=True)

# best
nn.ConvTranspose2d(3, 3, 3)
nn.functional.interpolate(x, scale_factor=2, mode='nearest')
nn.Upsample(scale_factor=2, mode='nearest')
```

Pay attention to your `.view()` and `.reshape()` operations in your network. Main issue with those is that while PyTorch uses NCHW format for its 4 dimensional tensors, different mobile inference frameworks can use either NCHW or NHWC format. If possible replace them with operations that preserve tensor dimensions.

```
# bad: NCHW dim order is assumed
features = features.view(batch_size, num_channels, height, width)
result = conv(features)
# ok: dim order is irrelevant
flattened_features = features.view(batch_size, -1)
result = flattened_features.sum(dim=1)
```

Some PyTorch versions have issues with different ONNX opsets. If you are encountering issues exporting model with interpolation, softmax layer with set dim parameter, try to update your PyTorch to the latest available version and set `opset_version=11` parameter in your `torch.ONNX.export` function call.
