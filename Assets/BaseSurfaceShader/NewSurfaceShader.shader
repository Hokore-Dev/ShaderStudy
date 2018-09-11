Shader "Custom/BaseSurfaceShader" {
	Properties {
		_TestColor ("testcolor", Color) = (1,1,1,1)
		_BrightDark ("Brightness $ Darkness", Range(-1, 1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		// 유니티 내장이 아닌 CG 언어를 이용해서 스크립트를 작성하는 부분.
		CGPROGRAM

		// 전처리, 스닛핏 / 조명 계산 설정이나 세부적인 분기
		#pragma surface surf Standard fullforwardshadows

		struct Input {
			float4 color : COLOR;
		};

		// half   = float / 2
		// fixed4 = half  / 2
		float4 _TestColor;
		float  _BrightDark;

		// 색상이나 이미지 출력 부분
		void surf (Input IN, inout SurfaceOutputStandard o) {
			// 조명의 영향을 받음
			o.Albedo = _TestColor.rgb + _BrightDark;

			// 조명의 영향을 받지 않음
			//o.Emission = _TestColor.rgb;

			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
