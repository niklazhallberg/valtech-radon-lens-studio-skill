# Physics Toys

This guide will cover physics features in Lens Studio, including Physics Matters, per-object world settings, and cone and cylinder collider shapes, using the Physics Maze and Physics Racetrack assets.

To learn more about Physics in general in Lens Studio, visit the [Physics Guide](/lens-studio/features/physics/physics-examples/physics.md).

[](/img/lens-studio/physics_toys-2.webm) [](/img/lens-studio/physics_toys-5.webm)

## Getting Started[​**](#getting-started "Copy to clipboard")

You can find the `Physics Maze` or the `Physics Racetrack` assets in the Lens Studio Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) to learn more about using assets from the Asset Library.

Once imported, locate the `Physics Maze` or the `Physics Racetrack` prefab in the Asset Browser. Drag and drop it under an Orthographic Camera in the Scene panel.

If you don't have an Orthographic Camera, add one by clicking the "+" button in the Scene panel and searching for "Orthographic Camera."

To edit the asset's contents, right-click the prefab in the Asset Browser and select `Unpack for Editing`. Click [here](/lens-studio/features/package-management/asset-packages-introduction.md) to learn more about Asset Packages.

The Physics Toys collection contains two independent components:

**Physics Maze**

* Demonstrates interactive physics objects with customizable material properties
* Features head-attached environments with drag-and-drop functionality

**Physics Racetrack**

* Implements vehicle physics with torque and constraints
* Includes slow-motion zones and collision effects

![](/assets/images/ls5-physics-component-imported-prefabs-dfe607b4f8f2b3a82faca4e29bac6a75.png)

## Physics Maze[​**](#physics-maze "Copy to clipboard")

This component creates an interactive maze that responds to head movements, allowing the ball to roll naturally. For optimal viewing, ensure your preview window is using the Front camera and select a preview video with a person in it.

### Physics World Settings[​**](#physics-world-settings "Copy to clipboard")

Physics World Settings, as the name suggests, are settings that apply to the entire physics world in a project. A Lens Studio project can have multiple physics worlds, each with its own settings. If you select the Prefab **Physics Racetrack** in the `Scene Hierarchy` panel, you will see it has a Physics World component. The **Settings** field of the component is linked to a World Settings asset. All children of the Prefab will inherit the Physics World Settings asset.

![](/assets/images/ls5-physics-component-physics-world-component-a36e078335d862e07893571b6ee2877e.png)

Right click on the Asset linked in the field **Settings** and choose **Highlight**, the asset will get highlighted in the `Asset Browser` panel. Click on the asset, you can find these and edit variables:

* Gravity
* Default Matter
* Simulation Rate
* Slow Step
* Slow Time
* Max Speed
* Max Relative Speed

![](/assets/images/ls5-physics-component-physics-world-asset-settings-fc53d792396564347354b3f232be236b.png)

To learn more about Physics World Settings, visit [Physics Assets and Components](/lens-studio/features/physics/physics-component.md).

### Drag Script[​**](#drag-script "Copy to clipboard")

The included custom script, Drag Script, enables you to drag objects using raycasting. Raycasting projects a ray into a scene and determines whether the ray collides with any object in the scene. In this template, a ray is cast when you tap on the screen. If the ray collides with some object, the object follows your finger until you release the screen.

Try dragging the objects in the scene listed below:

![](/assets/images/physics_toys-4-dfb7c45daddcfebf4d7856996e5842c7.png)

### Physics Matters[​**](#physics-matters "Copy to clipboard")

Attach a Physics Matter asset to each Physics Body and Physics Collider component. Within each Physics Matter asset, you can adjust the component’s friction and bounciness.

In the `Asset Browser` panel, find the **Physics Matters** folder under each imported asset. You will find several Physics Matter assets with varying settings. For example, notice that the bounciness of the asset used for the beach ball is higher than that used for the baseball. Even though the Physics Body shapes are the same, the balls bounce differently after colliding with the floor.

![](/assets/images/ls5-physics-component-asset-browser-physics-matters-5e60c6cf13b4d117153d48d5c7890930.png)

To learn more about Physics Matter, check out [Physics Assets and Components](/lens-studio/features/physics/physics-component.md)

### BindTransform script[​**](#bindtransform-script "Copy to clipboard")

Once the physics simulation starts, the physic objects (scene objects with dynamic Physics Body components) move in world-space. The Head Binding effect allows the maze physics objects to track your head. Since you cannot make the Physics Object a child of the Head Binding, utilize the BindTransfrom script to bind the Physics Object's initial transform to a pivot point on the Head Binding object.

![](/assets/images/ls5-physics-component-bindtransform-scenehier-ffb6f47ed590b8e1d1de17cc65dbfa82.png)

![](/assets/images/physics_toys-14-ba53ef3de0a0f71581c8ec25cbf27cb2.png)

### Enable Smoothing[​**](#enable-smoothing "Copy to clipboard")

Navigate to **Physics Maze\_\_PUT\_UNDER\_MAIN\_CAM > Effects > Maze Colliders > Floor 1 > Floor**. In the `Inspector` panel, you can find a Physics Collider component on the Floor object.You can then find the **Smoothing** option. This option smoothly interpolates between changes to help reduce noise. This template uses **Smoothing** to reduce motion tracking noise.

There are more than one colliders used in this example! Check out the rest of the Floor objects to see how they are set up.

![](/assets/images/ls5-physics-component-physics-collider-07d1608318fdc5d3e243116878166e29.png)

Enable the **Show Collider** field to see the smoothing effect.

[](/img/lens-studio/physics_toys-18.webm)

### Overlap Events with the Behavior script[​**](#overlap-events-with-the-behavior-script "Copy to clipboard")

The Maze example uses a [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) script to:

* Set up overlap zones for Physics Overlap Events.
* Trigger the rotation of each floor.
* Trigger the position of the lift.

View each Behavior script to see how it's configured.

![](/assets/images/physics_toys-15-8c9f58e55cf9fa2ec5e3bf57ce867fbf.png)

## Physics Racetrack[​**](#physics-racetrack "Copy to clipboard")

The racetrack example applies torque to the wheels of a toy car. When friction is enabled on the wheels and race track, the car moves forward.

Disable the Maze Example before testing the Race Track Example.

![](/assets/images/ls5-physics-component-racetrack-hierarchy-e5ac5774a3cd399db760cfa44afd5a74.png)

The racetrack example mainly uses the device’s rear camera. To test the example:

1. Click the **Switch Camera** button in the `Preview` panel, located at the top right corner of the panel.
2. Tap on the screen to enable the car.
3. Keep pressing on the screen to move the car forward.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABFoAAABSCAIAAADrQCe6AAAlL0lEQVR4Xuzde1CU1xnH8bO4AnJzAYFVY8VlYbl7TaJ1TOskNmniJDWJttFETR3TmqmZpkmmTTK9TWou05jYas1kUq2JjdaaaGsdNRpvrbGqCCiCLAIiajUiqGABEdg+s8+w0wFFLBVX+H7m/eOZ5wwH+PM3z3vOa8kYMcZ0XwAAAABQVlIoRXiErVU/wPQMAAAAANCD4xAAAAAAEIcAAAAAwGr8EgAAAACMHnvP5GnT+4SEmKupOlexfu2ne774e3ebDgEAAADAxEmPaRa6qqh+MRKWODvU3QAAAADQwGPaJWGpZ8QhAAAAAODs0P0Tv5WSlrZz65acrH2mBwAAAADw7MypvnrxshVdd7OcTqmGj7rrqVnfmzxthhTyZI4YGd2vn+lyDmfiI49PSUpJe2rWM7179zY3FQAAAACmQ+mZQ78z/btaj59wv69/4XzV55s2bPtsg+kqNTU1Ho/HYrHU1dU1NjYZAAAAALglZ4dskVGPP/Hkgw9PMl2l4sszv5v/5qa/rV00/y2Pp9l0GQAAAADEoXde/+WCt+ZtWLdWkol2Jj46ua/NZq4hMio6LDxca2W1WgcO+sr//KpbweG8dZ+uPn3qpFHX3bnzAAAAABCHSouPFhe5i47kr1+zWkJRc3Oz9p2uFC0kjSxaulyeX739m4xhw1/79YJ57yx88dVf6Gr60OFzX3r57cUfvPram/PfW/KjV35+5+ixuiQZZsH7S/VnM4aNMC2mPDlTm7PmzJWGfcBA3f/1dxcZ1e7O6uv3fUM3eWbu89qJ6GuTjj7hERHalFXt3D12nAEAAADA2aFrOV9VWV5WGu9wSj14iOPA3n9KERBgCQjoJUVoWMT02XNCQ8NMC1dquuQNGeBoQwpnksvhTPQYT9ae3VeuXJGxz7CRd8pSakZmXm62FN56qG6Ym50lDYtF9ze9elk7uLN0iosKdZMhCU7jlehK1o5wupJz9u/TVW1K5DMAAAAAmA5dS3Bw8ICBd2h99szpVqtBwUGShSRX7Ny6+WBOtkxgvv/cC5pY/rF9i0yW1n2ySoZLAQEBM2bPiYmNk75GF5GanqlFdExsbJwsmYbL9Xk52eZqOrLzqRMnaqqrpehri5RHI5BpkZiU8t9L5yrOVlacNW0BAAAAIA5J0khMTpn69OzAoGDtFLsLTRtr/vSxHDRatXzZ2lUfO5xJEpCkmX8od+WHf5DX7Tat/+v2zRu9c55eCYkuKfJycy7XX5YiJs4uQcibizKkr0sNDbJ0FR3Z2ePxuAsOG6/BDod3OpQi9ZUrDVLL/6IDLuNVmH/Y3D4AAAAAjB57z/zFv5cDO1LcxDjkcCYuXLJ84ZKPnv/JT0fdPUabhw/lnjn9L619Ghsb5UupvkZ8glOLtMxhP3jhx/rc+8BDvlUNJwezs7SjQSg5LcN47ZfBURsd31kU+uJQfIKMrfp751o7Pt8inQF3DAoJDR08JKElDuWZ2wcAAACAiZMe6xMSIp9LnTxt+k08O6QjFy1U7oH9S99baNq4VFOtsxdl7z9ACz0OpIVPnN2uRdaeL+766lgpUtIzd+3YnpyaLnVdbW1B3kHTyg3u7As58Q5HQpLLYrHIJGrrxvX3PfCg1DJEkr6sylt2RUcKjD8BAAAAsHjZCnNtEoS0kFB0c+OQfHRVY8PJ8vKS4qIOHrP58vRpLeRltq2fbdTa2tvq8ZimxkY92COO5OddulQTFhaenJomkyj9Z3Ky9smsqZM7V1VWygGnWHv/QfFD9OBQcdGR6uqL8l8MGjxY3peTvjRPlpfJH2AAAAAAcLNc24u2P1n5R3Pjjh8r0aKhoUFvjdNbEORibinq6+u009TUJJe8jRt/b3CfkG8+8qg2s/bu7vzO+r6cxCHJWnoHt9s7BTpamC9xSDrS9w6R8o0fAAAAACCvibU/7ak6V9G5qxS6SsnRIrkLQT8Q9MSMp51JLrlTW74O9NxLr8ijV8m1Cj96fEgGOO6Cgk7u3OqOhL42mwYhbyjK105LZMozfgAAAADA6hXLJfC0E5bW/2VN56ZDXaX64oX3f/vunB++aLVax42fII9pUVZaumvHNtOipMh94XyVLTJKG9n79no8zZ3fWZOPbGWxBEhdX1dbXnZc78TzNeXbR/LbjR8AAAAAsGfXTnlu8UXbelJIi/aTiV5p3arwOXL40AeLFsgJHx3m6FVy2zZvXDT/De34fpd+0VVp3ZbHeG5oZ42Px4+Van3Um4KMNOvqysuOabP0qFsSkekBAAAAAFgyRowxXUvvprMPGCg55EJVpYQfP9nZ/wEAAAB8X0iu0m7/QNGzM6e26pSVFHrvF7DdspfllO++hFMnyv1wZ/8HAAAA8H0hc22Hsg904mU5fwUAAAAAfUJC27+J7s8rPuopcQgAAAAAd81pECoqLJj3s5d1tYOspjsCAAAAwF1zTIcAAAAAgDgEAAAAAMQhAAAAALDqx1K7LwAAAABgOgQAAAAAxCEAAAAAsJo2AAAAAOS53eaWynC5jL8hDvUODIyx94+zD4yLs4eEhRt/smblh1I4XKnmdlDqLvDDv7axoaG29t91tZfkO1bNTU1GAQAAAMQhZ3JaxrCRFovFdFOwBgZGyGOL9Hg8VRVnL56vNAAAAABxSLJQ5vBRpmeAhN7o2DgpemIiAgAAAFcpkIUgiahvZLTpjgAAAABrB88LyTty5npczvivjR5hj402HVB/ucFdUrZjd/bF6hrjxxAVE1tTfaGHnyMCAADIcLm67eUN7WM6JHcnXPe80NC0pG8/PEGzUEcEBwUOTU2aMeWhoKBA4994a65PSKi5fQAAACCqX0xScqr5v2A69B/2zjy+xmt74/tXSKoZFDlJS0IRkWZAJhEJuFKu6OWqgpJAzK42VTXPTWqeZ0IJUJpS3CKKCAJESUgTaJNABjQDmgC/52Z/+nb3nOTM5xWyvt0fn/3uvc97tj+KJ2utZ8FHjmmiaRNXpjtVrSwbuzqdPp/Iyhj2tR3qOTrZ29e2rmplZmaOlaKiwuzM7OycrOtXUzLS0lkZABdT2Clsatgq7GxtFHbm5mZW1tbSbn5eXl5u3v+unZV182YaLo850wvIoYcF+YwgCIIgCIIo+R9LVdoEtq/f0LlBQ2dWOvg35NGY/adOHDPdNRp5eDs6OUEIVatRAyupvyQvmhXOVMCB4t0rTCtIDtnaMU3wuJAemJex6JCLq7tfQAB0har2gEbC8PTyhtKIjzuWlJT4slSQi6tb/QZOuAwrHUgjro7qN2jAWAD/P/BK4sX0jIz8vFzd5NBbFqwUCIIgCIIgKA4TNmYC5Ic2P3DvEzooqHOXBbPC79/NMZYEsneo4+7hWb+BM96vInucoXyUZM9HPXu3+aA9Jvfv3t23K1qzPCM5pGt/oenz1zBNTP58ICtjWFlX7dSlq8JWocVJ63YdP2wW0GL7ls2QFnLesJl/gGMDRx6wAifj4hLOncXExc29ddu2GkNeXEFdTrx08vhx7W9eqVIlVhIEQRAEQRCEpIW0BIfxkYgp49HmkRlG68B2QZ0/giJipVPLwUFJDkELSTcR5Vm5rh0iXF3dgvv3F7WQNqIIH0HshcmCwtYWN3R1c5O00JFDh+JPxCEFDiPh3BlII6Yd0E54FV7IDIAgCIIgCILw9W8paSGdFBGS65ihQNj8U70WAm5NPJkAz6BTusz4aeGNPLxIDhkZmCt8OTxkZGgPTEqMIPERe/I8e9lA0iDaI8kMXil0/tzZ3dE716xYPm9mBEbU+kg8JiUmKuWtIaAEKcVMT6s2geINeZCHCSBMpFPGHV7ITAxBEETFShWZLLxby75X39AW8v7JRhAE0aptO2l+6kTcF8MHDe/Xu8QxaXQYDghtbJyNkinHNGHvUFvpWFTkatxE6T2D/vOZb/MWJIeMSctmHqgLgllCu1bNWBkGGWjtgzoygWupqWuWLz96KAYTKaMMhgR4PLBvDwSSkihqFRiIl8jg7sB0BDVO327dhAsjcKTmhcaFIAhCYffOv7p0HRY2euaiFQtXrZ86c17/ISNaB35QsaIJpVFw6ODmLVt17xMip5MSQRCEWK6DOhw1+W/IRtu5JUqs6mEGs2h2OIrDUQJ0JObAd1s3qSkuUrpJ1NpVojzjdO3VG3VQVDtkNMzNzPgEuVxib6KmTVzq2L/LtCMz+97pC0kXL6cyk9G91ydi1AUZaEg8U6sxciGK8nNz4bggxoii1q9l8uLh5R0vKHsXlSAV/B64CR6O4QcDMugfgiAIt8ZN+g4aav5mFWnFxtYWw7Opr3cz/9VLF+bev6+aamJrZ1dQkH/4wI9MX168eMH4BP+9DAiCIDSW33CxZEQy0tJmTh3P5zPmLFRysZOkGowWxPIhURTdz8np0LnLXzGiEWF4IUWHjMOBo/G5+QVotxobnyD2JtJeC3HDuk7tWjb1dDOdjxy3XxOcCc4wLYDAgHASCnsUPGVOTqDHPLx8IMYwYLHQOjBQKZVO9L6DRTgzMQRBEE2bBwwe+TnXQilXLh/cu3vH5o2xP8Xcy8nBSu336o6bGvGWilmlt6/fB0Ef4k8xZgD4S/3Y4Z+2bdxwFTnxZQmCIAgkoc1dthpyBR4GSkYIfB0HjFvC9N9d0T/+EC0UhpQaidq3O1oMK0FBGS1ljqJDCOlgKKXPMb1AQAm9iUykKET9IAZboDE8vL3ReogL6+ys7AtnT4sCA8LJ3sFBslKA0RzflRO4yWGwkoB3HBNAuyRYhDMTQhAEdW1+o1PX7ujd/PTJ06jIVedOx0tbu8y29wzu7+PnZ2Fp4eXrF/vTQWZsbt+6uT1qPSt7EARBwLoNgRcMOFz/PTmtD4/JIEvNQLfroE7/luanjh+DyMFrRZGDx9JiU4cP7q/v5NzIw1O6LS5D0SGTgDoieT+oOdcToSFRP4gFRcH9B/j5B+CMFP+B3cLAocPFMqH9+/ZKvU3xKpmz0fDVxdVNeUwFhLmUfLSlNqwmgiAIooaNjXXVqphcSbwkaiHwuKhwW1Tko4ePiiNI/vokM7zxho3Ctqa9g94FSBUqVLCv/d47NWsxFaysrB3q1DU3N2emgSAIatJq0iQ63nRVCPh8z98pOsihPSsrHfwMS7oDXoUXkhwyYs/QyraK6mqc5dQMZmLqOTqJoSFRPxQVFq5ZsYwbyu3fuxeSQ9I8Yq0RBAa3VRBeKBOIVsHvodj7bhl+hS4SHRTEMJd0VSgiZjIIgiCkeqGcrDtMBTQFWDZ/9uolC/d8t0NanDZ7wdJ1Gxu6uPCsY8wxJn41S6ljxmdjJs5bsWbqrHnjp0fMW7F23LRwVU31r4+64bNzl6+RVj7+JAQr4fOXWFhYDg0bPXfZqrFTZwwL+1I6ULmyWY/gvuHzlny9aNmYKdPxWaSs/KN9BwS4WOk09vSetXglhqePLysFbPEzOMxeXwiCEJUM/AxYKezcuhnH1LyBCxi9QWmQGBqSSpiuCXLo0aMH6vUYbBXEFxremvbTMROQCrhs/aZB/wnDoyG7r7AcgqfcmOEhg3t3YWUShY2t4CaXoiQeJEO5y0mXNq6LhO+2pIg8hKyzm+lp0hyZdUwukLknXRJaiHuCQ7lBJsFBgZXEtaupzGQQBEHcvpn+5MljTBp5+ZTot/nbjWsXE84lX06UVipWqIgUOzHdDgPxH7EY6cvJMxwbNoR04SvYreVQOzh0SLuOnf4e/KnIPyuGg7CCD/YfOsLVvVFluOYIIJD1xcSpAa3bVq32Nh6fP38OFYTM+y7dew35dBQrnZ4hA5Dyh9F38DBv3+ZMBZ9m/tjiZ3CYvdYQBAGpAyGkVtJAosRGTJlQol7CIrZwgBkAIufS/OKF89L8cMx+iBxcD6VElxKwrg4UXoq1RgZqITQygnUeD4shDQ+PWDRk99WTQ9ZWlsEfBzX1cC3bVrAKaZ6fn68+LQ2+2wgESfbtYpRG+MvVislFekaGquUdlBsM7korYcrJyWQmgyAI4tmzZ1dTUnnW3BcTp8EawcLSkqllbvjUaWNH/Xr9Oua593/HHGPh7HC+W6lSpc4f94CqefLkyY4tG2dOnTBz6qQ90TvzcvOw+2GXrtyVQT1V3qri9L4LQuhwWZgXPm39yiV8vXlAq5r29pjAzm7cp8PDhvRfOCv8WkoKVlwbNW7g7KJN/l7wwMFKigiPaPGOLVY+IAgCSmbS6M/QbggT9aZzEVPGww6bCeARi9hihiH+0/RmeroY84HNDK6HUiKmiYz0NCH5uQYzgK49eyvlB+Kxz4BBhuy+YnKotv27g/t0gYOcNqqppZ8n79MqP6K/NqJATBNQRNBFvOhIFCFKL5QBpMPx79UJ+C2atHyIIAhiU+Sq7MxMTKrXqN4jOOTrhUtHT5rRtVewexNPqBqmwu/37yEIj/xkzB8/eYI5huTEDbly5/btlOTkDWtWHI05CD/ZjLRf9+/ZdWj/XuwimFPPyYlpwc/nzi6eHR53JObGtasYfLFRcZw/8/bt77Ztzs/Pg/0DLOkily9OunQR32j3TqkmqN9u+gahJFERwRxC0kJ4lLQQjuEwIwiC+FOcoO8QbNx4NAkTPGJi3NokPcUV/6D4QgNASEeNZtNv9xWTQyEfB6EBqzZlRSHdglr6esBKe2RoD/1EkczWBefPnGUvHS7f9eJq6lVmMgiCIPJyf0eM5dzpU4jnFKuFCnXqvocGrINHhn29cBl00VsWlkxrfrtxAzIG48LZM0zgzInjOqUo/7jne0SulBa5pMF9qr5dTcgUyFuxYA6+8djhGFYK58+cQs2xqIhCBg6BIlLVQjiGw+y1hiAImGULJtqagY0bjyZh8hoLPzWaTb9dOeSQ/NgpakiWcZjIL4rEUAlPc9fI5aREpQQ5ha2t0gtl4GZamvTtHp7e7YM69ukXCte7UWPHSwOP3Xr2Rn9YHJDCWTkIgpkYgiBIEa1fuXTcZ8O3bliX+PPPDwp48S6EhwV0UdjYibysSFferla9Tt26zi5uTbx93D28/qwO0pzjUFhYeAvZxSqkJidjYmllOWHGzG69Q953a/Tmm28y7Thz8oSqIlLVQjjGXl8IguDG2TDLxgSVh5hjYP5y5YfeZTb2tWuLLzT6D+4vJSQYuiu/HJIfLoo6tW8p19/Z+dJcobDRLkstl9sYSCuiVbec1m2t2gaOCPu8T78B6L7q4uYORybpJqLxN9oi4QB0EdQRVBPPSJEBgiAoJ+T40cMrF80dM3JIxOTxP/6wC85yWH+nZs1+Q4brlAHSI7j/V/MWfzVv0ehJ00d8MSZ02MhP+ungT4AsuBcvXjAV9n6/M/lyEi8uavmPwOGfj56zbNXILyfAvKFSpcp6KKLypIUIguAV/xFKESE8YhFb2rRkNWK307s5d0U3Tj1/R9VtDEtEEm27VysJKjzu2BplyG55kUOcRu/LFCDKyEiT5rVq19G+bicpqWRz7ewcmWIv6ICEnqo6lSpBHUE1te/YkckLQRDErYx0aI/wyeMePHiAx7r1HeGRwLQAjYbGTPkqoHWbt6tV4543t2/dun41NfHnC8xgYIK3fP7spXNnnYk/gYtxXzsnZ+fg0MEweIUM01URlR8tRBAElEyx3VkNpgIWsYUD6luy4hharzIjcS01WexBZLhbN/7cZvrDfSMmXEw4L7U/wiMWDdo1GRVZ2eOXa78xWbh+NQWigs9d3dzi4+I0ZrtBgWzfsllMscMHxRfKXMsEdwTUFucX5EGkFRYWIXgl3s3c3AwqyMbGFjl1iBSZ1OmBIAgCyWaVzcxePH+BChymwr2c7BNHDrX7sDN3yv71+jWmCb8WrWwUCp5qv/+HXQ8fPpActBev3cAMBtIFrt8YcGWwe7emd1Nf/9ZtkdT3Xr16QZ0/QomzNooIkz4DeJpcedFCBEFwSaMmrA2pc+rEMSYg6iWj18PARBslTH9KtYB9u76DkNA12IUPii/ExEBFtHrJAiPulpfoUGHR49hTCbsPxDJZgJaAipB0DnLJtFEgouRo5h8gRo3wQtlu/u3WTUsXzEe7oYTzZ80rm3Xr9Qn6w7q6uol5fTBogrcsWrLiGA5L/WRNAUEQRKePu0csWBqxcElpiSJVLKz+rLQsYiqoWs+97+aOSUF+we4d26CFhIYYTsyoIJvuzq2bP0TvnD5u9OOiQp16bkD8fLNqOUqkMDApJ1qIIKhqSHMxj4yk/nIFbnWCLfVgPQSe2AoJL2SvOvLLod8ybjMdycy+C/0jCqFFa7fGnjxfhEW5OBkXJzScauDh5cO0BlpIDA2h+alsxg/WVa2tLa3/uklAC8g5BIKQRCcpIlXyC3LRrMNExg8EQRBn4+N5yhlSQfCr0m4NGwVcEDB5/LjobnY2E3j67Cn35kZrVNWMbsgkpeaqrQLbM8OwsbWDAzhG2/YdmAA0TUHBQ12tcWAfhxIpjPLmI0cQ1HoVZtlMAI9CS1ZZwTeKPte8qElLgjp1EUND+3ZFMz0gORR7SudMbsieVVHRF6+kyiyERNC3VLSJa922LQ/4aAR2bX44qVRQZEpEj2yufGClAOO4Zs0DRBMFJUUEmYSr4hgOw1BB7JiEwBEjCIIwagYymg7xVA3U/DT28rG1e6eymTnciuApN3ZauIWFBXZPxB6FIiqx2UX3Pv2cXd0lx85fki5yq4OefUMdGzpbWlm5uDceMWqMexMPZhjI3LOwtIAJeOduPQP/2QHfiHy56jaKkEFDocqKLXM0CxuCIKj1qmiWLZpo44D8VxLTlOBxB5GjpVF4h7+Hhnia3yuP/LVDaRm3V22KbtfSt6q1JdOaPKRA7I9lLxUkkgX37y/V1UDkWFtbnzx+XLXPqZhWh1CSGGbhBUUmJf54nIODA5SPeBNcA0PVaAETLs+UrirqN/wemVEhCIJYuWhe6IjP3q1ZE/WKA4ePZCocO3zo++1bVNqknmnRpi3vvoeBlgBTx44q/nPvmI9/CysrK6+mvhjSefQ1wqOBVUN7vvsW+SQVK1Xs3K0XxvPnz9Alie+ichf+Ckx3CIKgJDp1aXLcBdtkrF66AC4OUiIfRA7qlBA1UvUhENPqxLanuPyCWeGYUHRIT7Ky723csW/x2m2qg5VhIHu4/asEHNgGDh3GhQRMCCRnAjzC3nrgsGFcYIj+2niJDPeE6EpK1CoG1SowkE/Eq4pxoY3rIo1+Z4IgiKzMO3OmT0b85+HDh0rFOQjFb/kmcnvUN6odUVOSr6xbsfRaSop0mE8y79yeO2NySnIyzLIlO7iDe3dvilwF9VKsal789RXPnxf/+kz4UqwwflIFaKr4WdMmQvnwUBW0EDQSlNi+6J1L5nz9CPfXAoIgCFifSfOuPXtD8KgRS0Gd/i2WgjOjAtmDLD4m4OvfYsacBX0GDGrk4YVAvSTJ8Ih2STD7hhZSMsjm2qlc8X+uTXyZJrr0DGHGYPLnA6X59PlrjH4+eusGTOo66WYviFwydOZhhnHk0KGEc2eYLtxIuaLHbbkwQ0YfjxSpcQNfs2IZJmKCHKJYUFPIZuGxVJ1vSxAEoWPjVDjIWVha5mRlwrP1jz/+YJowNzdHoVDR40KufyRQO4RqHwienOwsrqaMCEzhqtewMTM3g2DjPgocgiCIxJQUJuDm5FRi4Q1PNtOVqLWrkZam+Rt1BFIH+gfSS9dmcZBSPMfvdSXtRkpx9+2qKsly5R5PHx9mMH4B/pBDsoWzDuzbgwkiV7VqOVi9/T+zb9FEW7SIgAGdi6u7mZnZzZvpMJpjckEQBPH7/XsYTBcKS2kV/fTpUzi/MdPwvFhlMb0gCII4HLMfQRhun60RGUp0LiacQxPVsDETtL8S4lRItFMXF6LaoUcPCqpYWDIjwiM/ZQP8RFCKqCAbzd7ewS+AmxOUCk7CRy49I0MqOuLpdjIDecMVjqNjA1EOwVAbFhGiXYTBzQqfMAGCIAiCIAhCrLfRSX5AC5m0RAfCBo4Ovv4tkZuHW6m/CXzkNAszqh3KyspkxiA3v0CGD+rKkZhDkDdIJENEBYEXiAekmSGocv7cWWhlyWsVE+RRYBFbOACjAhwWP/vyFZ2ohYzKH2j3QRAEQRAEQZQuP6Ii1yDMorHQ6L+7oiOmjMdH5LG/WzQr4kjMAXyv5PGACe6JRWzhgFZaiKJDyPp+r54jM5jTFy7Deo7pTmx8gkm9tjFUg4YY+n1WfqDKENGCKMIE9/l/9u4oJYEoCgPwmegt3wKz1hCBELTTFtE6ekyqRMkSSSIqxSKIMiPp+hgCBiKZ9/s4Cxi4L/PPcP+zgM8erhQDAMyIH2mWr+mhmSbmJA71H+5Tz09RFPPGoVp9OPw4qO5Wypu/3+6aQlSrfRP8USpLR//+9hp5AgBAHPocjepntb3qfsztvHGVJv4Pnvq98dc4sgUAgL1D7cvGxelJZIZB7/HleRAZAgBAHJpORJPteBkgHbQsBACAKoUfiajbuS5vbZcrO2k2SqVYLaRO7dQjl7oT0oyndh0CANjKmhdxaPoe0d1tN00sq06rGbN4WgAAYC2yBAAAsN7ttGLJAAAAi3pRx98hAACAIlbO4dHxdzlWoty2DUSJg4duOY6b9Pixfkj+o5+ZcWZk6+AlHujbXQpgxIk1Sd10mjzT4BIEF3thV4C1FkTf92i11s65/gLHkFdqgMMYEF800GevlG8BsIo8Fe4B4x7c+44k+ILgjq4JRM5pDxpI/cKwqQBeZa8XMO4XOwRCG620PMqYwVCOZgdboukaWAUzwsJuwLj/ai6CNTGQJAndrDFqmMHx1Uc9EeIvkVpNLMGGU3A0X/yI4V0XtW17Pp/ruq6qKs/z0+lUliU6u66TSCApjGUtNB7YAcrbRiB0z/D29Cb1ioCQXjeMeJ3FRdprFxx3y9/hzS0oVhX4uhC6MeOrI0wd6Nuq3RwcggqYuhUONcbEHjaxNpYetHgLhXuO8VFWYXcFDDF81T9eZYEOCLE3UTwI+bXumPb06hVMPZXceYDmJ79wApx+MWSCia6GKHdTqpcGSCrhe4eBU8NOjSO+gyeGEtI2RX7a7XYfP358fHw85gX6kLzm88Vqtd5stpv1er1Zb7fbzWYzn2dxrJUmubnERKSTdgCzxOXaTp3PbUPoWoa3Vc8QwSRfSWLSDOlBiy/PDNBiOolPgAnFpDIMG1ut/CvLGorjgu+6zjHnFhcC3OiIvooiTFHkRVXkkes2m/X92/v1egWOTefq87lEkiUZHNjLulFGD3VA0rOLFNvQ4a8j4CkEvPyB5jESNaKjpGtpfTUBjLXGGm3IrM7rwC3m4g7/TKzHq0ZosLu1akKiEKmGykccI/TASA7gVgSHmPW5OeRlURSQGWUNkbC928xmGQ1EMarKqszr8gS3dU0F7jbWaZYkadK2zeFweH5+Qp2CW6FjrGNorpxKbJzN5mk2UzY+t30NQUy6WK7uH969fXh4c4+IW62W6SwzsY2MCrndOSqFiLE8L/Z78N7tn5/y07FpCrzUDgHWReQahbYfwPp2IT3KGiCdJYjF/gwXGYH0oLEmJgp3vunYSpX3oIHWaktdPvsZZYSvz4sqAk2z9lDFBUgA4K1zVN9rLAFeNfLqwlNf0q9D3KL6o5UQGq8vGLmq4KkcxLlpHC8uay3le2ugf9u1zQWIbzDAFFIC+q4vizLPc7BarVYPDw+//vLu/u7Ncr7Ax8T8XNdVgalPJfx53O8Px1MOFnGSLilHbLbA3fbuzd16ky6XOkkiy79etCbfVVW/fyo/Pe4eHz/tdnuEU12BI64SF1QCINVsNnv3/v1vf/wOGaDj8/Pz8XjEWoRUyEtZusgyBJ7C4LIsOVnFiFO2RoNAhq4AaMSy/xnz14c/ox8dq80dtevtVb+NfjjA8WmayJLQeig8kfPgdf79wbX4tcCLHy1l8G/7cYmbGh4DE1hGa82pnjoVDaIK538jhs97Nyo3+rOdlR/q85cUpBGk+FBq7UzHeYorMJU4yZPCRiBjWeSpDcebMkLv/CdDdpNHX1O9LhfGhq2hmLv0XW8dfRb2Gr1gX/r/3x40eO1+BsiW4xtM1Es+iZyU4f9E8n/KQeJTXbserdD/puTqO/tUdMKlvhzhQXeifSfnWGYxsd4UNHS0LWRWIZMMbIVSDhlJjT1wdeThT1gkJ4sa6uJ6ay1eGWNAJEmCvUrTNOODHtAiEudAIydOCrCKocUR8ufctSmkbvaRo4FeMknjvWzPAGfGGwZGhLt2aBSLHfQKB4summK085X5/Lfy61MOpJq2QZEQ40DzOCGtlDWaB4z8ErI0tXKhcWqUwG8fBo2rFdnBabEUJhucbaIe0MSXZQZnjf5ZRyaCkBBeG7FgmEJOVZgPHNobqnlG6ot4M8syENDKagNTYhSGxDbBALYyGq2kGk6NGSq7j3wCJk2TZDGfI2llWdJ3SzKJ6+BO9hrxEj9yLcYNNIE7uQt3jBJjMtCLzrZpxMEqGvbairUERUa7HB6BFh3H2yEBGcrE0FFo4QIOAG8OtA9Az4FHGDzEGGctfMNjlQAK+SvLzGKRjg/DoQaIjtG2EL+m1p+QMkDIiYAsK7xCM95O4+WCDkFWGIw9CXY389kcXoNBaizGc43D18P+aX84VHWBZyxN6D0n786ALM3SNMUTqW1VWAVkRCFJUkxellWO/evx1LUink7iBArIRk1U8EchspdjpZqyKOuqKcsUffgK08lPK7z00S2rzIivGKTjT4y/AUonQP7J+YpBAAAAAElFTkSuQmCC)

### Physics World Settings and slow motion[​**](#physics-world-settings-and-slow-motion "Copy to clipboard")

The racetrack example has two World Settings Asset. They are used on multiple objects in the scene. The **WorldSettingsAsset1** asset is used for the three Balloons and the **WorldSettingsAsset2** asset is used for the Car, the Slow Motion Zone. The Drag Script also need to reference the **WorldSettingsAsset2** asset.

![](/assets/images/ls5-physics-component-worldsettingasset2-c94684ffe6ad5331fcf0b1e49ee0f95f.png)

The[Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) script on the **Overlap Zone** object calls the functions in `SlowMotionSetting.js`. Whenever the car passes through the **Slow Motion Zone**, the script triggers the slow motion effect. Modify the effect’s Slow Step and Slow Time attributes in the Physics Back Camera World Settings asset.

![](/assets/images/physics_toys-19-1fb298eb1ab9244c674e2299d6696611.png)

### Collision Events with the Behavior script[​**](#collision-events-with-the-behavior-script "Copy to clipboard")

This example also uses Behavior scripts to handle Physics Collision Events and to change the Wall alpha to show the border of the Ground Collider and Wall Colliders.

[](/img/lens-studio/physics_toys-22.webm)

### BindTransform script[​**](#bindtransform-script-1 "Copy to clipboard")

This example uses the BindTransform script in two places: one on **Physics Objects > Complex Physics Body With Constraint** and another on **Physics Objects > Complex Physics Body With Multiple Objects**.

They both bind the respective objects to the **Physics Objects Pivot Point** object, which is a child of the **WorldObjectController** object.

### Car[​**](#car "Copy to clipboard")

Navigate to **Physics Objects > Car > Car**. You can find a Physics Body component on the Car object. The Car object is composed of multiple meshes, many with a Physics Body component. You can also find a Physics Constraint component, often attached to Scene Objects named Constraint. These Constraint components are linked to the Physics Body with their **Target** field and thus affect the Physics Body.

![](/assets/images/physics_toys-17-74a8970e12e824f468707f43c3d5434f.png)

### Per-object World Settings[​**](#per-object-world-settings "Copy to clipboard")

View the Balloons object under **Physics Objects > Car**.

Click on **Balloon 1** under Balloons. Notice that in the **World Settings** field, we have the **WorldSettingsAsset1** assigned here.

Right-click on the field and click **Highlight**, then click on the highlighted asset. In the `Inspector` panel, you can see the World Settings asset has a different gravity setting, which creates a floating effect.

![](/assets/images/physics_toys-1-e8312db16c8b1abd553015be3a98d338.png)

If you increase the gravity setting, the mass of the balloon's physics body components, and the balloon count in `ObjectsLayout.js`, you can cause the upward force from the balloons to be greater than the downward force from the car.

[](/img/lens-studio/physics_toys-3.webm)

### Cone and Cylinder Colliders[​**](#cone-and-cylinder-colliders "Copy to clipboard")

Navigate to **Physics Objects > Traffic Cone Layout > Traffic Cone**. You can see that the physics bodies of the traffic cone are composed of two bodies: one with the **Type** field set to `Cylinder` on the **TrafficCone** parent Scene Object, and another on the **Cone Body** child Scene Object with the **Type** field set to `Cone`.

![](/assets/images/physics_toys-8-a350072d487ab9bdb3809fc72b23f96c.png)

To learn more about the Physics Body Component, visit [Physics Assets and Components](/lens-studio/features/physics/physics-component.md).

### Apply Force[​**](#apply-force "Copy to clipboard")

Click on **Physics Objects > Car**, where you can find the **WheelController** script attached to the Car object. Find the script in the `Asset Browser` panel and double-click to open it in a script editor.

Notice the `addRelativeTorque`. The `addRelativeTorque` method applies torque to each of the four wheels when you tap the screen without dragging an object.

Set the friction between the racetrack and the wheels in the Wheel Physics Matter, Wood Floor Physics Matter, and Wood Ramp Physics Matter assets found in the `Asset Browser` panel. The combination of gravity, torque, and friction moves the car forward.

## Preview Your Lens[​**](#preview-your-lens "Copy to clipboard")

To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
