Shader "Custom/AlphaBlend"
{
	Properties
	{
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Alpha("Alpha Value", Range(0.0,1.0)) = 0.5
	}

	SubShader
	{
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		LOD 200
		Lighting off

		CGPROGRAM
#pragma surface surf NoLighting noambient alpha:fade

	sampler2D _MainTex;
	fixed4 _Color;
	float _Alpha;

	struct Input
	{
		float2 uv_MainTex;
	};

	void surf(Input IN, inout SurfaceOutput o)
	{
		fixed4 m = tex2D(_MainTex, IN.uv_MainTex);
		o.Albedo = m.rgb;
		o.Alpha = _Alpha;
	}

	fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten)
	{
		return fixed4(s.Albedo, s.Alpha);
	}
	ENDCG
	}
	Fallback "Diffuse"
}