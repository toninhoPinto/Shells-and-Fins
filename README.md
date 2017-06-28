# Shells-and-Fins

This project shows two implementations of the shell fur method, with one of the implementations also having fins.

## Table of Content
- [Introduction](#introduction)
- [Shell Vertex Shader](#shell-vertex)
- [Shell Geometry Shader](#shell-geometry)
- [Fin Geometry Shader](#fin-geometry)

## Introduction

So the shell based fur method is all about extruding the original mesh several times. 
For each time it is rendered with increasing alpha mask.
The result is an effect similar to strands of fur that become smaller and smaller.

Pros: Easy to implemen while still providing a good visual effect.
            comparatevely light for a fur solution.
            
Cons: Does not simulate each strand individually
      At certain angles the gap between each fur layer is more noticeable.

We will be working over this image provided by a friend.

![](http://i.imgur.com/7UMPY2L.png)
(base mesh)

## Shell Vertex

This effect is based from "Unity 5.x Shaders and Effects Cookbook". I did this one from memory so it may use slightly
different calculations. I highly recommend the book if you are a beginner.
The main difference is that it is implemented in a vert/frag shader, mostly due to personal preference.

Since the vertex cannot create aditional geometry, 
to create the new layers we do it by rendering the original mesh several times (multiple passes). 
In each pass we extrude the vertexes bit by bit.
Then each fragment shader of the pass calculates how thick the strand should look.

![](http://i.imgur.com/DkuONUG.png)

To avoid repeated code, it was split into two files. One has the actual vertex and fragment shader code.
The other calls those two programs several times with different values.

Pick the number of layers you want because those are static.
In this case i picked 30 passes/layers.

```//shell 0
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 0.0
		#include "ShellsVertexShared.cginc"
		ENDCG
}
```

So for each pass we declare a value from 0 to 29/30 and then call the file that has the vertex and fragment programs.

The vertex shader is fairly simple
, you just need to extrude the vertices by an increasing ammount depending on the number of the layer and 
the size of the fur that you want.

``` o.vertex = UnityObjectToClipPos(v.vertex + (float4(v.normal, 0) * _Size * FUR_LAYERS)); ```

Then in the fragment shader there are three textures.
One is the base coloring texture, this is used for color only, 
this way the color of the fur matches the color of the base mesh.

The second texture works as a pattern. Defining where a strand should end. 
Similar to a heightmap, but instead of saying how much a vertex should be extruded, it says how soon a strand should end.

The third texture works as a mask. In this example it is used to discard the fur in the mouses tail, feet, eyes, mouth and ears.

```
	fixed4 col = tex2D(_MainTex, i.uv);
	fixed4 furPattern = tex2D(_FurTex, i.uv);
	fixed4 mask = tex2D(_FurMaskTex, i.uv);

	col.a = furPattern.r * mask.r;

	if (col.a <= .1 * FUR_LAYERS * 30) discard;
```

The last line increases the masking value the further away the fur is from the body, making it end in a point.

You should end with something similar to this.

![](http://i.imgur.com/29BhgNq.png)

### Add Combing/Gravity

```
float3 direction = lerp(v.normal, _Comb.xyz * _CombStrength + v.normal * (1 - _CombStrength), FUR_LAYERS);
o.vertex = UnityObjectToClipPos(v.vertex.xyz + (direction * _Size * FUR_LAYERS));
```

This is the gist of combing. On the file itself I actually pass both the vertex and the normal to world coordinates so that the
Comb vector also works on world coordinates instead of object coordinates.

The idea is, instead of purely using the normal vector for extruding the vertexes, 
we use another vector in combination in order to point the fur in other directions.

First we interpolate the normal with the comb vector using the combstrength value, the result is an inbetween vector.
Then we interpolate a second time with a different value for each layer. The objective is to have the base of the 
fur strand point more towards the normal direction while the end of the strand pointing more towards the inbetween vector.

## Shell Geometry

In this implementation the final effect has three passes:
Base mesh
Shells
Fins

We will talk about the shells for now, with the fins separatly on the following section.
With the geometry shader we can now create new vertexes. So instead of multiple passes, we can create all the layers on a single
pass on the geometry shader.

The vertex shader is very basic, just pass along the vertex positions and normals.

Then on the geometry shader you have a loop from 0 to nLayers.

```

for (uint i = 0; i < _FurLayers; i++) {
					
    heightOffset = _Size * i / _FurLayers;

    displacement = normal0 * heightOffset;
    pIn.vertex = mul(vp, v0 + displacement);
    pIn.uv = IN[0].uv;
    pIn.normal = n0;
    pIn.layer = i;
    triStream.Append(pIn);

    displacement = normal1 * heightOffset;
    pIn.vertex = mul(vp, v1 + displacement);
    pIn.uv = IN[1].uv;
    pIn.normal = n1;
    pIn.layer = i;
    triStream.Append(pIn);

    displacement = normal2 * heightOffset;
    pIn.vertex = mul(vp, v2 + displacement);
    pIn.uv = IN[2].uv;
    pIn.normal = n2;
    pIn.layer = i;
    triStream.Append(pIn);

    triStream.RestartStrip();
}

```

Basicly for each layer you offset the vertexes on the normal direction by a size value.
The layer value is also stored for the fragment calculations.

The fragment shader is then the same as the previous implementation but instead of using FUR_LAYER it uses v2f i.layer.

### Add Combing/Gravity

```d0 = float4(lerp(n0, _Comb * _CombStrength + n0 * (1 - _CombStrength), i / _FurLayers).xyz, 0);```

Just like the previous version, for each vertex interpolate between the vertex normal and the Comb vector using the CombStregth.
Then a second interpolation using the current layer 
so that the point of the strand is more affected than the base of the strand. 

## Fin Geometry

![](http://i.imgur.com/1BcqipI.png)

Fins are quads perpendicular to the mesh surface that have a texture of a few fur strands. 
The objective is to improve the silhouette of the object and hide the gaps between the shell layers.

Both the vertex and fragment shader are basic so i will just focus on the geometry shader.

I followed a few papers that i will link in the end, but overall the method can be done in several ways.

The objective is to create planes along the silhuette. The method found on most papers include using triangle or line adjacency.
Unfortunatly unity does not provide such data so we will use line as the geometry shader input. We can still somewhat calculate
a silhouette using the normals, the eye vector and a dot product.

If its on the silhuette we extrude two new vertices along an averaged normal. The uvs are simple since its just a quad.

Papers for shells and fins on geometry shader:


http://developer.download.nvidia.com/SDK/10/direct3d/Source/Fur/doc/FurShellsAndFins.pdf
http://www.bartverdonck.com/media/FurShaderPaper.pdf
http://developers-club.com/posts/228753/
http://www.kwintenvdb.com/pdf/Fur%20Geometry%20Shader.pdf

