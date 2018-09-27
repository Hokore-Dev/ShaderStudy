Shader "Custom/UnlitCutout"
{
	Properties {
		_MainTex("Base (RGB)", 2D) = "white" {}
		_Color("Base Tint", Color) = (1,1,1,1)
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
	}
	SubShader {
		Tags{ "Queue" = "AlphaTest" "RenderType" = "TransparentCutout" }
		LOD 200
		cull off
		Lighting off

		CGPROGRAM
#pragma surface surf NoLighting noambient noforwardadd alphatest:_Cutoff

		sampler2D _MainTex; 
		fixed4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) 
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color.rgb;
			o.Alpha  = c.a;
		}

		fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			return fixed4(s.Albedo, s.Alpha);
		}
		ENDCG
	}
	FallBack "Unlit/Transparent Cutout"
}