// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/touming" {
	Properties {
		
	}
	SubShader
	{
	//Tags{"queue"="transparent"}
	//
	pass{
	blend SrcAlpha OneMinusSrcAlpha
	 ZTest greater
	 ZWrite on
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
	     fixed4 color=fixed4(0,0,1,0.5);
		 return color;
	 }   
	   ENDCG
	}
	pass{
   	blend SrcAlpha OneMinusSrcAlpha
	 ZTest less
	 ZWrite on
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
	     fixed4 color=fixed4(0,1,0,0.5);
		 return color;
	 }   
	   ENDCG
	}
	}
}
