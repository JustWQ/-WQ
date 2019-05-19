// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/vf3" {
	Properties {
		_R ("R", Range(0,5)) = 0.5
		_Offset ("0ffset", Range(-1,1)) = 0.0
	}
	SubShader {
		
		pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag			
		#include "UnityCG.cginc"
		float _R;
		float _Offset;
	    struct v3f
		{
			float4 pos:POSITION;
			float2 objPos:TEXCOORD0;
			float4 col:Color;
		}; 
		v3f vert(appdata_base v)
		{
		    float4 Wpos=mul(unity_ObjectToWorld,v.vertex);
			float2 xy=Wpos.xz;
			float d=_R-length(xy-float2(_Offset,0));
			d=d<0?0:d;
			float height=1;
			float4 uppos=float4(v.vertex.x,height*d,v.vertex.z,v.vertex.w);
			v3f o;
			o.pos=UnityObjectToClipPos(uppos);
			o.col=fixed4(uppos.y,uppos.y,uppos.y,1);
			return o;


		}
	   
	    fixed4 frag(v3f IN):COLOR
		{
		   return IN.col;
		}

		ENDCG
	 }
	}
}
