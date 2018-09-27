Shader "Custom/CustomSurfaceUnlitShader" 
{
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color("Base Tint", Color) = (1,1,1,1)
	}
	SubShader {
		Tags{ "Queue" = "Geometry" "RenderType" = "Opaque" }
		LOD 200
		Lighting off

		CGPROGRAM
#pragma surface surf NoLighting noambient noforwardadd

		sampler2D _MainTex;
		fixed4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color.rgb;
		}

		fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			return fixed4(s.Albedo, s.Alpha);
		}
		ENDCG
	}
	FallBack "Unlit/Texture"
}