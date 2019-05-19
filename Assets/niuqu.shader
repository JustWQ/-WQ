// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/niuqu" {
	SubShader {
		
		pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag			
		#include "UnityCG.cginc"
	
	    struct v3f
		{
			float4 pos:POSITION;
			float2 objPos:TEXCOORD0;
			float4 col:Color;
		}; 
		v3f vert(appdata_base v)
		{
		 //   float angle=length(v.vertex)*_SinTime.w;
		 //   float4x4 m=
			//{  float4(cos(angle),0,sin(angle),0),
			//   float4(0,1,0,0),
			//   float4(-sin(angle),0,cos(angle),0),
			//   float4(0,0,0,1)   
			//};

			// float angle=v.vertex.z+_Time.y;
			// float4x4 m={
			// float4(1,0,0,0),
			// float4(0,sin(angle)/10.0+0.5,0,0),
			// float4(0,0,1,0),
			// float4(0,0,0,1)
			//};
			//v.vertex.y+=0.2*sin(-length(v.vertex.xz)+_Time.w);
			  v.vertex.y+=0.2*sin((v.vertex.x+v.vertex.z)+_Time.w);
			  v.vertex.y+=0.6*sin((v.vertex.x-v.vertex.z)/2+0.5+_Time.y);
			float4x4 mvp=UNITY_MATRIX_MVP;//unity会默认替换mul(UNITY_MATRIX_MVP,*)，导致无法计算，这里干脆直接重新复制一份mvp
		   // m=mul(mvp,m);
			v3f o;
			o.pos=mul(mvp,v.vertex); 
			o.col=fixed4(v.vertex.y,v.vertex.y,v.vertex.y,1);
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
