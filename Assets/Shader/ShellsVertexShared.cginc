#pragma target 3.0
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
sampler2D _FurTex;
sampler2D _FurMaskTex;
float4 _MainTex_ST;

float3 _Comb;
float _CombStrength;
float _Size;

v2f vert(appdata v)
{
	v2f o;

	v.normal = mul(v.normal, unity_WorldToObject);
	float4 direction = float4(lerp(v.normal, _Comb.xyz * _CombStrength + v.normal * (1 - _CombStrength), FUR_LAYERS), 0);

	v.vertex = mul(unity_ObjectToWorld, v.vertex);
	v.vertex += (direction * _Size * FUR_LAYERS);
	v.vertex = mul(unity_WorldToObject, v.vertex);

	o.vertex = UnityObjectToClipPos(v.vertex);

	//float3 direction = lerp(v.normal, _Comb.xyz * _CombStrength + v.normal * (1 - _CombStrength), FUR_LAYERS);
	//o.vertex = UnityObjectToClipPos(v.vertex.xyz + (direction * _Size * FUR_LAYERS));

	//o.vertex = UnityObjectToClipPos(v.vertex + (float4(v.normal, 0) * _Size * FUR_LAYERS));
	o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	return o;
}

fixed4 frag(v2f i) : SV_Target{
	fixed4 col = tex2D(_MainTex, i.uv);
	fixed4 furPattern = tex2D(_FurTex, i.uv);
	fixed4 mask = tex2D(_FurMaskTex, i.uv);

	col.a = furPattern.r * mask.r;

	if (col.a <= .1 * FUR_LAYERS * 30) discard;

	return col;
}