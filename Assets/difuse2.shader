// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/difuse" {
	
	SubShader {	

	   //pass{
	   //Tags{"LightMode"="ShadowCaster"}
	   //}
		pass{
		Tags{"LightMode"="ForwardBase"}
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag

		#include "unitycg.cginc"
		#include "Lighting.cginc"


		struct v2f
		{
		  float4 vertex:COLOR;
		  float4 Pos:POSITION;
		  float3 normal:TEXCOORD1;
		};


		v2f vert(appdata_base v)
		{
		    v2f o;
			o.Pos=UnityObjectToClipPos( v.vertex);
			o.normal=v.normal;
			o.vertex=v.vertex;

			return o;
		}

		fixed4 frag(v2f IN):COLOR		
		{
	
		 fixed4 col=UNITY_LIGHTMODEL_AMBIENT;
		 float3 N=UnityObjectToWorldNormal(IN.normal);
		 float3 L= normalize( WorldSpaceLightDir(IN.vertex));

		 float diffuseScale=saturate(dot(N,L));
		 col=_LightColor0*diffuseScale;
		 float3 wpos=mul(unity_ObjectToWorld,IN.vertex).xyz;
		 col.rgb+= Shade4PointLights(
			unity_4LightPosX0,unity_4LightPosY0,unity_4LightPosZ0,
			unity_LightColor[0].rgb,unity_LightColor[1].rgb,
			unity_LightColor[2].rgb,unity_LightColor[3].rgb,
			unity_4LightAtten0,
			wpos,N );
		 return col;


		}



		ENDCG


		}
		}		
		FallBack"Diffuse"
	}
	

