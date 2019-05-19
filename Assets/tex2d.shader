// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/tex2d" {
	Properties {
		
		_MainTex ("Albedo (RGB)", 2D) = "" {}
		_F("F",Range(10,50))=10
		_A("A",Range(0,0.1))=0.05
		_R("R",Range(0,1))=0.5
	}
	SubShader {
	Tags{"queue"="transparent"}
	  ZWrite Off
	 //   blendop revsub
		//blend  DstAlpha one
		blend SrcAlpha OneMinusSrcAlpha
     pass{    	
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
		 //   IN.uv.x+=_Time.x/3;
			//IN.uv.y+=_Time.x/2;
			//IN.uv.x+=_A*sin(IN.uv.x*3.14*_F+_Time.y);
			//IN.uv.y+=_A*sin(IN.uv.y*3.14*_F+_Time.y);
			float2 uv=IN.uv;
            float dis = distance(uv,float2(0.5,0.5));
			float scale=0;
			if(dis<_R)
			{
			_A*=1-dis/_R;
			scale=_A*sin(-dis*3.14*_F+_Time.y);
			uv=uv+uv*scale;
			}

			float2 dx=ddx(IN.z)*2;
			float2 dy=ddy(IN.z)*2;
		    float4 color =tex2D(_MainTex,uv);//+fixed4(1,1,1,1)*saturate(scale)*60;

			
			return color;
		}



		ENDCG
		}

	}
	
}
