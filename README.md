## Glasan FX Widgets

This is a collection of widgets used by [Glasan FX](https://github.com/YuriSizov/glasan-fx), a sound effects tool made with [Godot](https://godotengine.org/).

These components are extracted from the main project and made into self-contained packages for your convenience. You are free to use them in your projects — just like any other part of _Glasan FX_, which is licensed under MIT!

Note, that these widgets are created for one specific project and were not intended to be universally applicable or overly adjustable. Some configuration properties are exposed, as well as many shader parameters, per the needs of _Glasan FX_. In other words, these components are made to be as pluggable as possible, but you are expected to tune them to your liking and needs, if you choose to use them.

If you want some kind of collection that is more universal, do let me know though!

## How to use

You can find source code and scene files for widgets in the `widgets` folder, split into subfolders for each individual widget. Each folder typically contains one scene file, one script file, one theme resource file, and a number of shader files.

- The script and shader files can be copied directly into your project.
- The scene file can also be copied directly, however it contains references to the script and shader files by their path. Those need to be adjusted. Look for `res://widgets/<name_of_widget>/` and replace that according to your project structure.
- The theme file can be used directly, however a better way to do theming in Godot is to have a project theme, configured in the project settings. If you have one, you can import definitions from the widget's theme file into it.

### How to import theme definitions

1. Open your project theme in the Godot's theme editor.
2. In the top right of the theme editor click the "Manage Items" button.
3. Select the "Import Items" tab, then "Another Theme" tab.
4. Choose the path to the widget's theme resource.
5. Select all definitions with data and click import.
   - In theory, you're done here. However, at the time of writing one thing is not copied this way — base type of the widget's type.
   - To fix that, after you've imported everything else, go back to the main theme editor panel and select the widget's type from the drop down list.
   - Switch to the last tab with a wrench icon and enter the base type for the widget. The base type should be the same as the type of the node at the root of the widget scene (e.g. for `GlowButton` it's `Button`).

### Shader considerations

For the sake of each widget being self-contained, some code has been duplicated, specifically some shader code. Several functions are reused across multiple widgets and in _Glasan FX_ they are all extracted into a dedicated shader include file. You can find this file in the `shaders` folder, if you decide to take several widgets and optimize your code a bit.

Also the glass-like overlay and the glowing label effect are reused in several widgets. Those can all use the same file, and in _Glasan FX_ this is indeed the case.

## License

Glasan FX components are provided under an [MIT license](LICENSE).
