// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/diffuse" {
properties{
   _Shininess("Shininess",Range(1,64))=8
}
	SubShader {
	Pass
	{
	    Tags{"LightMode"="ForwardBase"}
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "unitycg.cginc"
		#include "lighting.cginc"


		float _Shininess;
		struct v2f
		{
		    float4 pos:POSITION;
		    fixed4 col:COLOR;
			
		};

		v2f vert(appdata_base v)
		{
		   v2f o;
		   o.pos=UnityObjectToClipPos(v.vertex);


		   float3 N=normalize(v.normal);
		   N=mul(unity_ObjectToWorld,float4(N,0)).xyz;
		   float3 L=normalize(_WorldSpaceLightPos0);//为了保证让两个向量处于同一坐标系，要么用_ObjectToWorld*N，要么_World2Object*L

		   float ndot=saturate(dot(N,L));
		   o.col=_LightColor0*ndot;
		   float3 I=-WorldSpaceLightDir(v.vertex);//世界光源到目标位置的光向量
		   float3 R=reflect(I,N);
		   float3 V=WorldSpaceViewDir(v.vertex);
		   R=normalize(R);
		   V=normalize(V);
		   float3 SpecularScale=pow(saturate(dot(R,V)),_Shininess);
		   o.col.rgb+=_LightColor0*SpecularScale;
		   return o;

		}
		fixed4 frag(v2f IN):COLOR
		{
		    return IN.col;
		}




    

		
		ENDCG
		}
    }	
	}


