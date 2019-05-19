// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/jianbian" {
	Properties {
		_Color1 ("Color1", Color) = (1,1,1,1)
		_Color2("Color2",COLOR)=(1,1,1,1)
		_S("S",Range(-0.5,0.5))=0
		_R("融合带",Range(0,0.5))=0.1
	}
	SubShader {
	
		pass
		{
		  CGPROGRAM
		  #pragma fragment frag
		  #pragma vertex vert
		  #include "unitycg.cginc"

		  fixed4 _Color1;
		  fixed4 _Color2;
		  float _S;
		  float _R;
		  struct v2f
		  {
		      float4 pos:POSITION;
			  float Y:TEXCOORD;
		  };

		  v2f vert(appdata_base v)
		  {
		     v2f o;
			 o.pos=UnityObjectToClipPos(v.vertex);
			 o.Y=v.vertex.y;
			 return o;
		  }
		  fixed4 frag(v2f IN):COLOR{
		   IN.Y+=_S;
		   if(IN.Y<=-_R)
		   {
		       return _Color2;
		   }
		   if(IN.Y>=+_R)
		   {
		      return _Color1;
		   }
		   
             
		     fixed4 midcolor=_Color1*((IN.Y+_R)/(2*_R))+_Color2*((_R-IN.Y)/(2*_R));//中间色		  
		     return midcolor;                                
		   
		   

		  //if(IN.Y<_S)
		  //{
		  //   return _Color1*((IN.Y-(-_R))/(_S-(-_R)))+_Color2*(1-(IN.Y-(-_R))/(_S-(-_R)));
		  //}
		  //if(IN.Y>_S)
		  //{
		  //   return _Color2*((_R-IN.Y)/(_R-_S))+_Color1*(1-(_R-IN.Y)/(_R-_S));
		  //}
		  
			}
	
		  

		  ENDCG
		}
	
	}
	//FallBack "Diffuse"
}
