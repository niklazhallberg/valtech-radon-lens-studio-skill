# Export from TensorFlow

Models built with TensorFlow should be converted to the TensorFlow Lite format before being imported into Lens Studio. Refer to the official [TensorFlow Lite Converter](https://www.tensorflow.org/lite/convert) guide for detailed instructions. The TensorFlow Lite converter takes a TensorFlow model and generates a TensorFlow Lite model, which is an optimized FlatBuffer format identified by the `TFLite` file extension.

To run on mobile devices, TensorFlow models are converted to an internal format that leverages limited computational power. Our TensorFlow converter aims to support popular neural network architectures and common neural operations.

# Quantization

SnapML supports TensorFlow Lite 8-bit quantization. Learn more about [Quantization](https://www.tensorflow.org/lite/performance/quantization_spec) on the TensorFlow website.

Check out the [Multi-Class Classification Template](/lens-studio/features/snap-ml/snap-ml-templates/multi-class-classification.md) and the corresponding [training notebook](https://github.com/Snapchat/snapml-templates/blob/main/Quantization%20With%20TFLite/classification_and_quantization_with_tflite.ipynb) to learn how to generate and quantize multi-class classification models.
