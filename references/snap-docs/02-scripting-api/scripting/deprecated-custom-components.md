# Deprecated Legacy Custom Components

Starting *Lens Studio 5.21*, legacy Custom Components are deprecated. A legacy Custom Component is one created in *Lens Studio 5.0.13 or earlier*, including any from Lens Studio 4.x. Lens Studio deprecates these in favor of the format available since 5.0.14. That update improves authoring reliability, versioning, update flows, and provides a clearer path on how Custom Components are shared and maintained. Custom Components in the new format are a well-defined subset of Packages with consistent behavior and tooling.

When you open a project that uses legacy Custom Components, Lens Studio unpacks them into regular assets in your project. You can then fix or modernize the content and re‑export it as a new Custom Component.

![](/assets/images/deprecated-custom-components-unpack-38015f3ffbc86442143cecf06c22dbfa.gif)

If you rely on Custom Components from the Asset Library, many popular components now ship in the new format: install the latest version from the Asset Library and remove the old one.

Some legacy Custom Components from Lens Studio 4.x no longer receive updates. See [Custom Components](/lens-studio/4.55.1/references/guides/general/custom-component) in the Lens Studio 4.55.1 documentation for details.

If you have concerns, feedback, or feature requests related to this change, share them on [Snap UserVoice](https://snap.uservoice.com/forums/954406-lens-studio-desktop).
