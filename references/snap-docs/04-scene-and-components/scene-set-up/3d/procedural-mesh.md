# Procedural Mesh

## Overview[​**](#overview "Copy to clipboard")

With the help of the [Mesh Builder](/api/lens-studio/Classes/OtherClasses.md#MeshBuilder) class, Lens Studio supports you to dynamically manipulate 3D mesh on the vertex-level in run-time. This will enable you to achieve procedural effects. Using MeshBuilder, you can dynamically add or delete vertices, and move each vertex as you like.

## Getting Started[​**](#getting-started "Copy to clipboard")

Open a new Lens Studio project. Add a new Mesh Object in the `Scene Hierarchy` panel by pressing the `+` button and selecting the empty Mesh.

![](data:image/png;base64,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)

In the `Asset Browser` panel, select `+` → `Script`. With our object selected, add a Script component in the Inspector panel. Select + Add Component → `Script`. Then select the + Add Script field and select the script resource we just created.

![](/assets/images/procedural_mesh_guide12-27a371de5899da2d12d9306d20cdb5ad.png)

Open up the script and we can initiate a new procedural mesh with the Mesh Builder class.

```
//@input Component.MeshVisual meshVisual
var builder = new MeshBuilder([{ name: 'position', components: 3 }]);
builder.topology = MeshTopology.Points;
```

This code will create an empty procedural mesh. The constructor defines what property that we can manipulate. In this case, we can manipulate the position of each vertex that forms the procedural mesh. After the constructor, we define the topology type of our procedural mesh object to be points.

Last step is to assign a material to the mesh, so that we can control the color of our mesh in the Lens Studio editor or use code to dynamically control the color of the mesh. In the `Asset Browser` panel, select `+` → `Unlit Material`. We can then attach the unlit material to the Render Mesh Visual Component.

![](/assets/images/procedural_mesh_guide10-0db7dda355523e5ce9578c3de8e02706.png)

Double click on the Unlit Material. In the Material Editor connect the surface color node to the base color in the graph editor.

[](/img/lens-studio/procedural_mesh_guide3.webm)

We can also enable two-sided in the material so that the mesh can be seen from both sides:

![](/assets/images/procedural_mesh_guide7-71476ef68faaf6ab388697f379922787.png)

## Indices[​**](#indices "Copy to clipboard")

A 3D mesh is formed by a group of vertices. In MeshBuilder, each vertex is assigned with a unique index number based on the order of vertex being added to the MeshBuilder object.

In MeshBuilder, there are two levels of data:

![](/assets/images/procedural_mesh_guide9-2212b32c95c742f4fb441b4b7f37f300.png)

The first level stores information for each vertex, such as the vertex’s position, color, normal, and etc. The information is stored under corresponding vertices.

What is stored per vertex is defined by the Builder. For example, if you wanted to store both position and color as in the image above, in your builder you would write:

```
var builder = new MeshBuilder([
  { name: 'position', components: 3 },
  { name: 'color', components: 4 },
]);
```

The second level stores an array of vertex’s indices. Rather than from vertex 0 to vertex 2 like in the first level, we can have them stored in a customized order with repetition and the MeshBuilder will group vertices based on the order. Under different topology types, the grouping will be different.

For example under Triangle Topology, the Mesh Builder will group every three vertices to render a triangle based on the information stored under each vertex. With the code below, a triangle can be formed by vertex 0, 1, 2. The second triangle can be built with the reversed order of indices. This code will give us two triangles facing opposition directions:

```
builder.appendIndices([
   0, 1, 2 // Triangle 1
   2, 1, 0 // Triangle 2
]);
```

## Topology[​**](#topology "Copy to clipboard")

At the initiating state of a Mesh Builder object, topology defines how we apply the function: `appendIndices()`. Here are the explanations and examples for each topology type.

### Points[​**](#points "Copy to clipboard")

By selecting points, the procedural mesh will only render points (vertex) on the screen without any line or face. We can add the 3D position for each point that we want to add with appendVerticesInterleaved().

```
builder.appendVerticesInterleaved([
  // Position             Index
  0,
  0,
  0, // 0
]);
```

The code adds three points to our procedural mesh as data. The points are at `[0,0,0]`. As the topology is points, the mesh is rendered as points. We can use `appendIndices()` to add the index of the vertices that we want to render.

```
builder.appendIndices([0]);
```

After we assign procedural mesh to a scene object and update the mesh with the following code, we will have our first point procedurally generated at position \[0,0,0]:

```
script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

**Please note that one point takes a single pixel to render, this may make it challenging to see on the screen.** However, we can loop this code 10000 times to see a cluster of points. The complete code:

```
//@input Component.MeshVisual meshVisual
var builder = new MeshBuilder([
  { name: 'position', components: 3 }, //attribute 1
]);

builder.topology = MeshTopology.Points;
for (var i = 0; i < 10000; i++) {
  builder.appendVerticesInterleaved([
    // Position
    Math.random(),
    Math.random(),
    Math.random(),
  ]);

  builder.appendIndices([i]);
}
script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

![](/assets/images/procedural_mesh_guide15-8b0eedf5f5fc92ae657bb51497987abb.png)

By control the position of the points that we want to add, we can also have a square face:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([
  { name: 'position', components: 3 }, //attribute 1
]);

builder.topology = MeshTopology.Points;
for (var i = 0; i < 10000; i++) {
  builder.appendVerticesInterleaved([
    // Position
    Math.random(),
    i / 10000,
    0,
  ]);

  builder.appendIndices([i]);
}
script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

![](/assets/images/procedural_mesh_guide14-f2ba236ad54747bb0c14dc5f06ce89ed.png)

Or a line with the code:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([
  { name: 'position', components: 3 }, //attribute 1
]);

builder.topology = MeshTopology.Points;
for (var i = 0; i < 10000; i++) {
  builder.appendVerticesInterleaved([
    // Position
    0,
    i / 10000,
    0,
  ]);

  builder.appendIndices([i]);
}
script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

This method to make a line or face is both inconvenient and inefficient. Here are a few topologies that can enable you to quickly build lines and faces.

### Lines[​**](#lines "Copy to clipboard")

Lines can be defined by the two points at both ends, so with the Lines topology, our MeshBuilder will render a line between every two vertices. We first need to change the topology from Points to Lines:

```
builder.topology = MeshTopology.Lines;
```

In this mode, indices are lines, each formed by two vertices. We first need to add two vertices and a third vertex for later demo:

```
builder.appendVerticesInterleaved([
  // Position      Index
  0,
  0,
  0, //0
  0,
  10,
  0, //1
  10,
  0,
  0, //2
]);
```

Then we append the index of vertices to our mesh builder so it renders a line between vertex 0 and vertex 1.

```
builder.appendIndices([
  0,
  1, // Line 1
]);
```

Here is the rendered result:

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAmYAAAIICAMAAADzDNKSAAAC6FBMVEUl2CQm2CQn2CUn2SQo2CYo2SQp2SYp2Scq0C4q0S4q0i8q2Ckq2Sgq2Skr2Cos1DEs2Sst1i8t1jAt1jEt2Csu1TEu1TIu1jAu1jEu1jIu2iwu2y0u2y4v2C4v2y4v2y8w1zEw2y8w3DAx1zMx2DEx2i8x2y8y2jAy3DIz1zUz2jE01zU02DM03DU12DQ12DU33Dk63D083D8920M93EE+3EM/3EU/3Eo/3URA3UhA3UtB3UlC3UtC3kxC3k1C30xC301D3U1D3k5I5VJWi1hqampra2tsbGxtbW1ubm5vb29wcHBxcXFycnJzc3N0dHR1dXV2dnZ3d3d4eHh5eXl6enp7e3t8fHx9fX1+fn5/f3+AgICBgYGbm5ucnJydnZ2enp6fn5+goKChoaGioqKjo6OkpKSoyaqoyKqnyKqA3oaC34mL35KpyquqyquqyqyM35SuyrGvyrGxyrOR35izyrV52YB/34WA34V524GwyrKX35yX35163IGW35x/3oSe36N52YGvyrJ52oGB3oe0yra0yre1ybe1yra1yre2w7eV35yS35iC34qD34l624GD34qxyrSyyrSyyrWzxbSP35iQ35eQ35iR35eK35KS35eL35GT35mV35u2yri237m4yrm6yru8yr2+38C/v7+K35FM6VaL35OM35KO35atyrCuyrCpyauryq2ryq6syq6w37OB34mzyre0w7Wnyap73oF73oJ43ICN9Jd62YCO35etyq+qyq2f36Sf36Wk36l53IB53YCM35N93oSa56GE34qE34uX35+Y35952oCZ36Ca36J83oON35WB34iN35R63oF42oCc36GX35543YCp362B34d524CA3oV53oB83oKO35SO35WA34aA34eP35aP35ed36Z93oOg36Za5GN+3oSF34yF342G342H346I34+K35C/yr/CysLEysTHysfH38nIysjKysrO39DW39fa39ve39/f399eD8AwAAAe4UlEQVR4Xuzdxa4baRSF0X7bsi8zhZmZmZmZ08jMzMwM0x5HPUgpulup+3t9L7AnS7aPLJcfORxPmpnMhJmEmTATZhJmwkyYSZgJMwkzYSbMJMyEmYSZMBNmEmbCTJhJmAkzCTNhJswkzISZ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)

We can also connect all three vertices by changing the code in `appendIndices()`. Notice that we can reuse the used vertices to form this triangle:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([
  { name: 'position', components: 3 }, //attribute 1
]);

builder.topology = MeshTopology.Lines;
builder.indexType = MeshIndexType.UInt16;

builder.appendVerticesInterleaved([
  // Position      Index
  0,
  0,
  0, //0
  0,
  10,
  0, //1
  10,
  0,
  0, //2
]);

builder.appendIndices([
  0,
  1, // Line 1
  1,
  2, // Line 2
  2,
  0, // Line 3
]);

script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

Show more▼

![](/assets/images/procedural_mesh_guide19-f8744ba197b3c3c2a2c3bb6f7619c71e.png)

By adding color property in the constructor, we can also get these colored lines not connected together in our procedural mesh with the code below:

![](/assets/images/procedural_mesh_guide18-5378282c85e988514c7211164afcfbe8.png)

The complete code for this example:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([
  { name: 'position', components: 3 }, //attribute 1
  { name: 'color', components: 4 }, //attribute 2
]);

builder.topology = MeshTopology.Lines;
builder.indexType = MeshIndexType.UInt16;

builder.appendVerticesInterleaved([
  // Position             Color                   Index
  0,
  0,
  0,
  1,
  0,
  0,
  1, // 0
  0,
  10,
  0,
  0,
  1,
  0,
  1, // 1
  10,
  0,
  0,
  0,
  0,
  1,
  1, // 2
  10,
  10,
  10,
  1,
  1,
  0,
  1, // 3
]);
builder.appendIndices([
  0,
  1, // Line 1
  2,
  3, // Line 2
]);

script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

Show more▼

### LineStrip[​**](#linestrip "Copy to clipboard")

In some special cases when we want continuous lines head to tail, like in the graph below, we can use `LineStrip` with less code.

![](data:image/png;base64,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)

Unlike the Lines topology, which needs two vertices to render each line, LineStrip supports you to only use one new vertex to render a new line as it will automatically connect to the previous vertex appended. To make the same triangle in the previous example, we can do this:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([
  { name: 'position', components: 3 }, //attribute 1
]);

builder.topology = MeshTopology.LineStrip;
builder.indexType = MeshIndexType.UInt16;

builder.appendVerticesInterleaved([
  // Position      Index
  0,
  0,
  0, //0
  0,
  10,
  0, //1
  10,
  0,
  0, //2
]);

builder.appendIndices([
  0,
  1, // Line 1
  2, // Line 2
  0, // Line 3
]);

script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

Show more▼

### Triangles[​**](#triangles "Copy to clipboard")

We can use Triangles Topology to make triangle faces. For each triangle, we need three vertices, and here is the code to make a basic triangle:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([{ name: 'position', components: 3 }]);

builder.topology = MeshTopology.Triangles;
builder.indexType = MeshIndexType.UInt16;

builder.appendVerticesInterleaved([
  // Position              Index
  0,
  0,
  0, // 0
  0,
  10,
  0, // 1
  10,
  0,
  0, // 2
]);

builder.appendIndices([
  0,
  1,
  2, // Our Triangle
]);

script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

[](/img/lens-studio/procedural_mesh_guide6.webm)

Moreover, we can make a square with two triangles:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([{ name: 'position', components: 3 }]);

builder.topology = MeshTopology.Triangles;
builder.indexType = MeshIndexType.UInt16;

builder.appendVerticesInterleaved([
  // Position         Index
  0,
  0,
  0, // 0
  0,
  10,
  0, // 1
  10,
  0,
  0, // 2
  10,
  10,
  0, // 3
]);
builder.appendIndices([
  0,
  1,
  2, //Triangle 1
  1,
  2,
  3, //triangle 2
]);
script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

Show more▼

![](/assets/images/procedural_mesh_guide1-e33adc0e85bd9a93660691930ebffc2d.png)

### TriangleStrip[​**](#trianglestrip "Copy to clipboard")

This mode is helpful if you want to create a strip like the graph below. In this case, each new vertex forms a new triangle with the previous two vertices.

![](data:image/png;base64,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)

Instead of defining each triangle with three vertices, we just need to add vertex indices in the right order and the MeshBuilder will automatically fill triangles like the graph.

To achieve the same shape as the previous example, we can append only 4 vertices in `appendIndices()`:

```
//@input Component.MeshVisual meshVisual

var builder = new MeshBuilder([{ name: 'position', components: 3 }]);

builder.topology = MeshTopology.TriangleStrip;
builder.indexType = MeshIndexType.UInt16;

builder.appendVerticesInterleaved([
  // Position         Index
  0,
  0,
  0, // 0
  0,
  10,
  0, // 1
  10,
  0,
  0, // 2
  10,
  10,
  0, // 3
]);
builder.appendIndices([
  0,
  1, //First two vertices
  2, //triangle 1
  3, //triangle 2
]);

script.meshVisual.mesh = builder.getMesh();
builder.updateMesh();
```

Show more▼

### TriangleFan[​**](#trianglefan "Copy to clipboard")

This mode is helpful if you want to create a fan shape like the graph below. In this case, each new vertex forms a new triangle with the previous vertex and the first vertex (vertex 0), instead of connecting the new vertex with the previous two vertices in TriangleStrip Topology.

![](data:image/png;base64,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)

In the previous example, we define the topology to be Triangles after the constructor. Thus, when we call `appendIndices()`, we need three vertices to define a set of indices to be a face. In the previous example, we have our triangle face defined by the first three vertices.

## Skinned Meshes[​**](#skinned-meshes "Copy to clipboard")

Skinned Meshes are used to animate 3D models. The vertices of the mesh are attached to bones, and the bones are animated to move the vertices. The MeshBuilder class supports skinned meshes two ways:

### 1. VertexLayout[​**](#1-vertexlayout "Copy to clipboard")

```
var simpleSkin = script.getSceneObject();
simpleSkin.createComponent('Component.Skin');
var mesh_0 = global.scene.createSceneObject('Mesh_0');
mesh_0.getTransform().setLocalScale(new vec3(100, 100, 100));
mesh_0.createComponent('Component.RenderMeshVisual');
mesh_0.setParent(simpleSkin);
var renderMeshVisual = mesh_0.getComponent('Component.RenderMeshVisual');
var skin = simpleSkin.getComponent('Component.Skin');

renderMeshVisual.setSkin(skin);

var armature = global.scene.createSceneObject('Armature');
armature.getTransform().setLocalScale(new vec3(100, 100, 100));
armature
  .getTransform()
  .setLocalRotation(quat.fromEulerVec(new vec3(-90, 0, 0)));
armature.setParent(simpleSkin);

var node_1 = global.scene.createSceneObject('Node_1');
node_1.getTransform().setLocalRotation(quat.fromEulerVec(new vec3(90, 0, 0)));
node_1.setParent(armature);

var Node_2 = global.scene.createSceneObject('Node_2');
Node_2.getTransform().setLocalPosition(new vec3(0.0, 1.0, 0.0));
Node_2.setParent(node_1);

var node_2_end = global.scene.createSceneObject('Node_2_end');
node_2_end.getTransform().setLocalPosition(new vec3(0.0, 1.0, 0.0));
node_2_end.setParent(Node_2);

var node_2_end_end = global.scene.createSceneObject('Node_2_end_end');
node_2_end_end.getTransform().setLocalPosition(new vec3(0.0, 1.0, 0.0));
node_2_end_end.setParent(node_2_end);

skin.clearBones();
skin.setSkinBone('Node_1', node_1);
skin.setSkinBone('Node_2', Node_2);
skin.setSkinBone('Node_2_end', node_2_end);

var builder = new MeshBuilder([
  { name: 'position', components: 3 },
  { name: 'normal', components: 3, normalized: true },
  { name: 'boneData', components: 4 },
]);

builder.topology = MeshTopology.Triangles;
builder.indexType = MeshIndexType.UInt16;

builder.appendVerticesInterleaved([
  -0.5,
  0,
  0,
  0,
  -1,
  0,
  0.99,
  0,
  0,
  0, //Position, Normal, boneData
  0.5,
  0,
  0,
  0,
  -1,
  0,
  0.99,
  0,
  0,
  0,
  0.5,
  0,
  0.5,
  0,
  -1,
  0,
  0.75,
  1.25,
  0,
  0,
  -0.5,
  0,
  0.5,
  0,
  -1,
  0,
  0.75,
  1.25,
  0,
  0,
  0.5,
  0,
  1,
  0,
  -1,
  0,
  0.5,
  1.5,
  0,
  0,
  -0.5,
  0,
  1,
  0,
  -1,
  0,
  0.5,
  1.5,
  0,
  0,
  0.5,
  0,
  1.5,
  0,
  -1,
  0,
  1.75,
  0.25,
  0,
  0,
  -0.5,
  0,
  1.5,
  0,
  -1,
  0,
  1.75,
  0.25,
  0,
  0,
  0.5,
  0,
  2,
  0,
  -1,
  0,
  1.99,
  0,
  0,
  0,
  -0.5,
  0,
  2,
  0,
  -1,
  0,
  1.99,
  0,
  0,
  0,
]);
builder.appendIndices([
  0, 1, 2, 0, 2, 3, 3, 2, 4, 3, 4, 5, 5, 4, 6, 5, 6, 7, 7, 6, 8, 7, 8, 9,
]);

var boneNames = [];
var bone1 = new mat4();
bone1.column0 = new vec4(1, 0, 0, 0);
bone1.column1 = new vec4(0, 0, -1, 0);
bone1.column2 = new vec4(0, 1, 0, 0);
bone1.column3 = new vec4(0, 0, 0, 1);

var bone2 = new mat4();
bone2.column0 = new vec4(1, 0, 0, 0);
bone2.column1 = new vec4(0, 0, -1, 0);
bone2.column2 = new vec4(0, 1, 0, 0);
bone2.column3 = new vec4(0, -1, 0, 1);

var bone3 = new mat4();
bone3.column0 = new vec4(1, 0, 0, 0);
bone3.column1 = new vec4(0, 0, -1, 0);
bone3.column2 = new vec4(0, 1, 0, 0);
bone3.column3 = new vec4(0, -2, 0, 1);

const invBoneMatrices = [];
invBoneMatrices.push(bone1);
invBoneMatrices.push(bone2);
invBoneMatrices.push(bone3);

boneNames.push(node_1.name);
boneNames.push(Node_2.name);
boneNames.push(node_2_end.name);

builder.setBones(boneNames, invBoneMatrices);

builder.updateMesh();
renderMeshVisual.mesh = builder.getMesh();
```

Show more▼

Here is an example of creating a skinned mesh from scratch.

1. We create the scene object hierarchy with each of the bones.
2. We add a render mesh visual to store the mesh builder visual.
3. We add a skin to store the bone targets. These will be used to transform the skinned object to the correct point in space.
4. We declare the vertex layout in the mesh builder.
5. We add the vertices and indices to the mesh builder.
6. We add the bone names and inverse bind matrices to the mesh builder with set bones.
7. We update the mesh and assign it to the render mesh visual.

Now the mesh is ready to be animated using an animation player and a valid animation asset.

#### BoneData[​**](#bonedata "Copy to clipboard")

You can append `boneData` to the vertex layout input in the constructor of MeshBuilder. We support 4 bone influences. Bone index is encoded into the integer portion of the float, and the weight is encoded into the remainder. For example, a component if value 1.99 has bone index 1 and weight 0.99. Note it should be non normalized.

### 2. Existing Mesh[​**](#2-existing-mesh "Copy to clipboard")

```
//@input Component.RenderMeshVisual targetMesh
//@input Asset.RenderMesh mesh

const builder = MeshBuilder.createFromMesh(script.mesh);
script.targetMesh.mesh = builder.getMesh();
```

Here you can take in an existing mesh and create a new mesh that you can dynamically modify.

#### Limitations[​**](#limitations "Copy to clipboard")

Adding or deleting vertices/indices is not supported for skinned meshes. You can only modify, otherwise you will have to rebuild from scratch.

## Properties and Functions of Mesh Builder[​**](#properties-and-functions-of-mesh-builder "Copy to clipboard")

### Constructor[​**](#constructor "Copy to clipboard")

This is our constructor for MeshBuilder and you can add more attributes in the constructor. For example, we can add a second constructor “color” to the second attribute which can be defined by four numbers.

```
var builder = new MeshBuilder([
  { name: 'position', components: 3 }, //attribute 1
  { name: 'color', components: 4 }, //attribute 2
]);
```

Here is a list of attributes that you can add include:

```
// vertex position (x,y,z)
{ name: "position", components: 3 },
// normal vector (x,y,z)
{ name: "normal", components: 3, normalized: true },
// texture UV (u,v)
{ name: "texture0", components: 2 },
```

### Function: appendVerticesInterleaved[​**](#function-appendverticesinterleaved "Copy to clipboard")

This function takes an array and automatically divides them based on how many attributes there are in MeshBuilder’s constructor.

For example, after we add color attributes, the function will read every 7 numbers as information stored under each vertex. To add three vertices to the MeshBuilder, we need 21 numbers in the function like below.

```
builder.appendVerticesInterleaved([
  0, 0, 0, 1, 0, 0, 1, 0, 10, 0, 0, 1, 0, 1, 10, 0, 0, 0, 0, 1, 1,
]);
```

The MeshBuilder will segment this array like below:

![](/assets/images/procedural_mesh_guide9-2212b32c95c742f4fb441b4b7f37f300.png)

If we segment the array like the function will do, it looks like this below:

```
builder.appendVerticesInterleaved([
  // Position             Color                   Index
  0,
  0,
  0,
  1,
  0,
  0,
  1, // 0
  0,
  10,
  0,
  0,
  1,
  0,
  1, // 1
  10,
  0,
  0,
  0,
  0,
  1,
  1, // 2
]);
```

In this way, each vertex is assigned a different color based on the RGBA value. We can attach an unlit material to the mesh and connect the surface color node to the base color in the graph editor. We also need to enable two-sided in the material so that the triangle can be seen from both side:

![](/assets/images/procedural_mesh_guide10-0db7dda355523e5ce9578c3de8e02706.png)

[](/img/lens-studio/procedural_mesh_guide3.webm)

We will get this triangle with this assigned color:

[](/img/lens-studio/procedural_mesh_guide13.webm)

### Function: setVertexInterleaved()[​**](#function-setvertexinterleaved "Copy to clipboard")

We can also dynamically change modify the mesh in run time by applying this function in an update event like this:

```
script.createEvent('UpdateEvent').bind(function (eventData) {
  builder.setVertexInterleaved(2, [
    10 * Math.sin(getTime()),
    0,
    10 * Math.cos(getTime()),
    0,
    0,
    1,
    1,
  ]);
  builder.updateMesh();
});
```

[](/img/lens-studio/procedural_mesh_guide4.webm)

Remember to use updateMesh() every time you make any change to our MeshBuilder objects.

With this code, the third vertex will rotate around the center, so that we can see the triangle is rotating around the z-axis.
