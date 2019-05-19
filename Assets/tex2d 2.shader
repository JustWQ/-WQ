// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/tex2d" {
	Properties {
		
		_MainTex ("Albedo (RGB)", 2D) = "" {}
		
	}
	SubShader {
	
	  

	 //   blendop revsub
		//blend  DstAlpha one
	//	blend SrcAlpha OneMinusSrcAlpha
     pass{  
	  // ColorMask r
		CGPROGRAM
		
		#pragma fragment frag
		#pragma vertex vert
		#include "unitycg.cginc"
		#pragma target 3.0
		sampler2D _MainTex;
		sampler2D _WavaTex;
		float4 _MainTex_ST;
	
		struct v2f
		{
		  float4 pos:POSITION;
		  float2 uv:TEXCOORD0;
		  float z:TEXCOORD1;
		};
		v2f vert(appdata_full v)
		{
		    v2f o;
			o.pos=UnityObjectToClipPos( v.vertex);
			//o.uv=v.texcoord.xy;
			o.uv=TRANSFORM_TEX(v.texcoord,_MainTex);		
			return o;
		}
		fixed4 frag(v2f IN):COLOR		
		{	
		   float2 uv=tex2D(_WavaTex,IN.uv).xy;//实际上使用C#代码中生产的rgb颜色中的rg来表示偏移的UV，然后和背景图叠加
		   uv=uv*2-1;
		   uv*=0.05;

		   IN.uv+=uv;
		   float4 color1=tex2D(_MainTex,IN.uv);
		   return color1;

		}


		                                                                          
		ENDCG
		}

	}
	
}
