# Sub-Graph Overview

The **Sub-Graph** node encapsulates a group of nodes into a single node with exposed imports and exports. Sub-Graphs are primarily used to organize node graphs.

### Exporting Subgraphs[​**](#exporting-subgraphs "Copy to clipboard")

You can save and share Sub-Graphs by right clicking on the node, highlighting Sub-Graph, and choosing `Export to File`. This way you can make your own collection of Sub-Graphs to use in your future projects.

![](/assets/images/sub-graph-overview_subgraph-1-1ab9c3d06cea7791827ec3e6b597be8a.png)

### Importing Subgraphs[​**](#importing-subgraphs "Copy to clipboard")

To import a Sub-Graph from a file, simply drag and drop an exported Sub-Graph .subgraph file into the **Material Editor** window to import it:

[](/img/lens-studio/sub-graph-overview_subgraph-2.webm)

### Navigating Subgraphs[​**](#navigating-subgraphs "Copy to clipboard")

To go into a Sub-Graph, you can click on it, press `i`, hit `Enter`, or right click on it and select `Sub-Graph > Jump into Sub-Graph`.

To exit a Sub-graph, you can press `o`, hit `Esc`, or right click on some empty space in the Material Editor window and select `Sub-Graph > Jump out of Sub-Graph`.

Get your bearings by taking a look at the path on the top of the Material Editor window which shows how many layers deep you are in Sub-Graphs. You can click on the text to bring you to that level.

[](/img/lens-studio/sub-graph-overview_subgraph-3.webm)

### Adding Options to Sub-graphs[​**](#adding-options-tosub-graphs "Copy to clipboard")

Parameters are not allowed inside of Sub-Graphs. Parameters can be imported into Sub-Graphs by connecting them to a **Float Sub-Graph Import** or **Texture 2D Object Sub-Graph Import** node.

**Sub-Graph Import** and **Sub-Graph Export** nodes have similar properties to Parameter nodes for organizing their ordering and display. See the [Parameters Guide](/lens-studio/features/graphics/materials/material-editor/parameters-guide.md) for more detailed information of these controls.

[](/img/lens-studio/sub-graph-overview_subgraph-4.webm)

Similar to Parameter nodes, the `Min`, `Max`, and `Step` fields do not clamp or snap the incoming value! These are for display and control purposes only, and can be overridden with incoming data. Use a **Clamp** node to make sure your values are clamped properly.
