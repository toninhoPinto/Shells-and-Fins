Shader "Custom/ShellsVertex"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_FurMaskTex("Fur Mask", 2D) = "white" {}
		_FurTex("Fur Texture", 2D) = "white" {}
		_Size("Size of Fur", Range(0, 1)) = 0.5
		_Comb("Comb fur", Vector) = (0,-1,0,0)
		_CombStrength("Comb Strength", Range(0,1)) = 0.25
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100


		//Base mesh
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
			float3 normal : NORMAL;
		};

		struct v2f
		{
			float2 uv : TEXCOORD0;
			float4 vertex : SV_POSITION;
		};

		sampler2D _MainTex;
		float4 _MainTex_ST;

		v2f vert(appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = TRANSFORM_TEX(v.uv, _MainTex);
			return o;
		}

		fixed4 frag(v2f i) : SV_Target{
			// sample the texture
			fixed4 col = tex2D(_MainTex, i.uv);
			return col;
		}

			ENDCG
		}


		//shell 0
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 0.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 1
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_LAYERS 1/30.0	
			#include "ShellsVertexShared.cginc"
			ENDCG
		}

		//shell 2
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 2/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 3
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 3/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 4
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 4/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 5
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 5/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 6
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 6/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 7
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 7/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 8
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 8/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 9
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 9/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 10
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 10/30.0
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 11
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 11/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 12
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 12/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 13
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 13/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 14
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 14/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 15
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 15/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 16
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 16/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 17
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 17/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 18
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 18/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 19
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 19/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 20
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 20/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 21
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 21/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 22
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 22/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 23
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 23/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 24
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 24/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 25
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 25/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 26
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 26/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 27
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 27/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 28
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 28/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

		//shell 29
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#define FUR_LAYERS 29/30.0		
		#include "ShellsVertexShared.cginc"
		ENDCG
		}

	}

}
