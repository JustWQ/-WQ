// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/mydiffuse" {
	
	SubShader {		
		pass{
		Tags{"LightMode"="ForwardBase"}
		CGPROGRAM
		#pragma fragment frag
		#pragma vertex vert
		#include "unitycg.cginc"
		#include "Lighting.cginc"
		#include "autoLight.cginc"
		#pragma multi_compile_fwdbase
		struct v2f
		{
		  float4 col:COLOR;
		  float4 pos:POSITION;
		  //unityShadowCoord3 _LightCoord:TEXCOORD0;
		  LIGHTING_COORDS(0,1)
		};
		v2f vert(appdata_base v)
		{
		    v2f o;
			o.pos=UnityObjectToClipPos( v.vertex);
			float3 N=normalize(v.normal);
			float3 L=normalize(_WorldSpaceLightPos0);

			N=mul(float4(N,0),unity_WorldToObject).xyz;
			N=normalize(N);

			float ndot1=saturate(dot(N,L));
			o.col=_LightColor0*ndot1;
			float3 wpos=mul(unity_ObjectToWorld,v.vertex).xyz;
			o.col.rgb+= Shade4PointLights(
			unity_4LightPosX0,unity_4LightPosY0,unity_4LightPosZ0,
			unity_LightColor[0].rgb,unity_LightColor[1].rgb,
			unity_LightColor[2].rgb,unity_LightColor[3].rgb,
			unity_4LightAtten0,
			wpos,N );
			TRANSFER_VERTEX_TO_FRAGMENT(o);
			return o;
		}
		fixed4 frag(v2f IN):COLOR		
		{	
		    float atten=LIGHT_ATTENUATION(IN);
			fixed4 col=(IN.col);
			col.rgb*=atten;
			return col;
		}
		ENDCG
		}
		//================================
		pass{
		blend one one


		Tags{"LightMode"="ForwardAdd"}
		CGPROGRAM
		#pragma fragment frag
		#pragma vertex vert
		#include "unitycg.cginc"
		#include "Lighting.cginc"
		#include "autoLight.cginc"
		#pragma multi_compile_fwdadd_fullshadows
		struct v2f
		{
		  float4 col:COLOR;
		  float4 pos:POSITION;
		  //unityShadowCoord3 _LightCoord:TEXCOORD0;
		  LIGHTING_COORDS(0,1)
		};
		v2f vert(appdata_base v)
		{
		    v2f o;
			o.pos=UnityObjectToClipPos( v.vertex);
			float3 N=normalize(v.normal);
			float3 L=normalize(_WorldSpaceLightPos0);

			N=mul(float4(N,0),unity_WorldToObject).xyz;
			N=normalize(N);

			float ndot1=saturate(dot(N,L));
			o.col=_LightColor0*ndot1;
			float3 wpos=mul(unity_ObjectToWorld,v.vertex).xyz;
			o.col.rgb+= Shade4PointLights(//点光源
			unity_4LightPosX0,unity_4LightPosY0,unity_4LightPosZ0,
			unity_LightColor[0].rgb,unity_LightColor[1].rgb,
			unity_LightColor[2].rgb,unity_LightColor[3].rgb,
			unity_4LightAtten0,
			wpos,N );
			TRANSFER_VERTEX_TO_FRAGMENT(o);
			return o;
		}
		fixed4 frag(v2f IN):COLOR		
		{	
		    float atten=LIGHT_ATTENUATION(IN);
			fixed4 col=(IN.col);
			col.rgb*=atten;
			return col;
		}
		ENDCG
		}


	}
	FallBack "Diffuse"
}
