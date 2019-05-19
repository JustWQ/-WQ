// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/bianyuan" {
	Properties {
	   _sint("sint",Range(1,8))=1
	   _outer("outer",Range(0,10))=1
	   _color("color",COLOR)=(1,1,1,1)
	}
	SubShader {		
	Tags{"queue"="transparent"}
	pass{
	
		blend srcalpha oneminussrcalpha
		ZWrite off
		CGPROGRAM
	
		#pragma fragment frag
		#pragma vertex  vert
		#include "unitycg.cginc"


		float _sint;
		float _outer;
		fixed4 _color;
		struct v2f
		{
		    float4 pos:POSITION;
			float4 vertex:TEXCOORD0;
			float3 normal:TEXCOORD1;
		};
		v2f vert(appdata_base v)
		{
		    v.vertex.xyz+=v.normal*_outer;
		    v2f o;
			o.pos=UnityObjectToClipPos(v.vertex);
			o.vertex=v.vertex;
			o.normal=v.normal;
            return o;
		}
		fixed4 frag(v2f IN):COLOR
		{
		    float3 N=mul(IN.normal,(float3x3)unity_WorldToObject);
			N=normalize(N);
			float3 worldPos=mul(unity_ObjectToWorld,IN.vertex).xyz;
			float3 V=_WorldSpaceCameraPos.xyz-worldPos;
			V=normalize(V);

			float bright=pow(saturate(dot(N,V)),_sint);
			
			_color.a*=bright;
			
			return _color;
		}

		ENDCG
		}	
   //===============================================
   pass{
	    blendop revsub
		blend  DstAlpha one
		ZWrite off

		CGPROGRAM
		#pragma fragment frag
		#pragma vertex  vert
		#include "unitycg.cginc"


		float _sint;
		fixed4 _color;
		struct v2f
		{
		    float4 pos:POSITION;
		
		};
		v2f vert(appdata_base v)
		{
		    v2f o;
			o.pos=UnityObjectToClipPos(v.vertex);
			
            return o;
		}
		fixed4 frag(v2f IN):COLOR
		{
		  
			return fixed4(1,1,1,0.5);
		}
		ENDCG
		}	
		
	
   //===============================================
	pass{
	    // blend zero one
		blend srcAlpha OneMinusSrcAlpha
		ZWrite off

		CGPROGRAM
		#pragma fragment frag
		#pragma vertex  vert
		#include "unitycg.cginc"


		float _sint;
		fixed4 _color;
		struct v2f
		{
		    float4 pos:POSITION;
			float4 vertex:TEXCOORD0;
			float3 normal:TEXCOORD1;
		};
		v2f vert(appdata_base v)
		{
		    v2f o;
			o.pos=UnityObjectToClipPos(v.vertex);
			o.vertex=v.vertex;
			o.normal=v.normal;
            return o;
		}
		fixed4 frag(v2f IN):COLOR
		{
		    float3 N=mul(IN.normal,(float3x3)unity_WorldToObject);
			N=normalize(N);
			float3 worldPos=mul(unity_ObjectToWorld,IN.vertex).xyz;
			float3 V=_WorldSpaceCameraPos.xyz-worldPos;
			V=normalize(V);
			float bright=1.0-saturate(dot(N,V));
			bright=pow(bright,_sint);			
			_color*=bright;
			return _color;
		}
		ENDCG
		}	
		
	}
	
}
