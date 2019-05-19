// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/tex2d" {
	Properties {
		
		_MainTex ("Albedo (RGB)", 2D) = "" {}
		_F("F",Range(10,50))=10
		_A("A",Range(0,0.1))=0.05
		_R("R",Range(0,1))=0.5
		_speed("speed",Range(1,100))=1
	}
	SubShader {
	Tags{"queue"="transparent"}
	  ZWrite OFF
	 //   blendop revsub
		//blend  DstAlpha one
		blend SrcAlpha OneMinusSrcAlpha
     pass{  
	  // ColorMask r
		CGPROGRAM
		
		#pragma fragment frag
		#pragma vertex vert
		#include "unitycg.cginc"
		#pragma target 3.0
		sampler2D _MainTex;
		float4 _MainTex_ST;
		float _F;
		float _A;
		float _R;
		float _speed;
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
			o.z=mul(unity_ObjectToWorld,v.vertex).z;
			return o;
		}
		fixed4 frag(v2f IN):COLOR		
		{	
		   float2 uv=IN.uv;
		   float uv_offset=0.03*sin(IN.uv*_F+_Time.x*_speed);
		   uv.x+=uv_offset;
		   uv.y+=uv_offset*0.5;
		   fixed4 color_1=tex2D(_MainTex,uv);
		   uv=IN.uv;
		   uv.x-=uv_offset;
		   uv.y-=uv_offset*0.5;
		   fixed4 color_2=tex2D(_MainTex,uv);
		   fixed4 C1=(color_1+color_2)/2;
		   if(C1.r>0.9)
		   {
		        C1.a=0;
		   }
		   else
		   {
		      C1.a=0.4;
		   }
		//   distance()
		   return C1;


		}



		ENDCG
		}

	}
	
}
