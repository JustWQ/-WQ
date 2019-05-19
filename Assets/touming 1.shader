// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/touming" {
	Properties {
		
	}
	SubShader
	{
	//Tags{"queue"="transparent"}
	
	pass{
	blend SrcAlpha OneMinusSrcAlpha
	ZWrite off
	 CGPROGRAM 
	 #pragma fragment frag
     #pragma vertex vert
     #include "unitycg.cginc"
	 struct v2f{
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
	     fixed4 color=fixed4(1,0,0,0.5);
		 return color;
	 }   
	   ENDCG
	}
	}
}
