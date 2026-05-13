# Clustering Phones

Integer values are assigned to different phone clusters. Higher integer value indicates higher performance for that device. Usage of this index allows developers to conditionally enable or disable features/behavior according to a performance profile.

| General Index | Android                                                                                                                                                                                                                                                                             | iOS                          |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| 0             | Incompatible phones                                                                                                                                                                                                                                                                 | None                         |
| 1             | 32 bit phones, OpenGL ES 2 only phones                                                                                                                                                                                                                                              | None                         |
| 2             | Android 4.3/OpenGL ES 3.0, OpenGL FenceSync KHR support                                                                                                                                                                                                                             | None                         |
| 3             | Android 7/OpenGL ES3.2+/Vulkan 1.0+, Samsung Galaxy S7 (US), Pixel                                                                                                                                                                                                                  | iPhone 6s                    |
| 4             | Android 9/Vulkan 1.1+, Samsung Galaxy S8 (US), Pixel 2                                                                                                                                                                                                                              | iPhone 7                     |
| 5             | Samsung Galaxy S9 (US), Pixel 3                                                                                                                                                                                                                                                     | iPhone 8 + 10                |
| 6             | Samsung Galaxy S10 (US), Pixel 4, Pixel 5, Android 13/Vulkan 1.3+, Samsung Galaxy S20 (US), Pixel 6, Pixel 7,Samsung Galaxy S21, S21 Ultra, Pixel 8, Pixel 9, Samsung Galaxy S22, S22 Ultra, Samsung Galaxy S23, S23 Ultra, Samsung Galaxy S24, S24 Ultra, Samsung Galaxy S25, S25+ | iPhone 10s                   |
| 7             |                                                                                                                                                                                                                                                                                     | iPhone 11, iPhone SE 2nd gen |
| 8             |                                                                                                                                                                                                                                                                                     | iPhone 12                    |
| 9             |                                                                                                                                                                                                                                                                                     | iPhone 13+14                 |
| 10            |                                                                                                                                                                                                                                                                                     | iPhone 14 Pro + iPhone 15    |
| 11            |                                                                                                                                                                                                                                                                                     | iPhone 15 Pro                |
| 12            |                                                                                                                                                                                                                                                                                     | iPhone 16 + iPhone 16 Pro    |

\* Android Phones not listed may be assigned a cluster with Snap’s Artificial Intelligence.

Example Usage:

```
var devicePerformanceIndex = global.deviceInfoSystem.performanceIndexes.general

// X is an arbitrary value that is related to a device threshold.

if(devicePerformanceIndex > X){
	// Load high fidelity model from remote assets.
}else{
	// Load low poly model from remote assets.
}
```
