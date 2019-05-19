// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/vf2" {
	properties{
		_Color1("MainColor",Color) = (1,1,1,1)
		_P("Lerp",Range(0,1)) =0.5
	}
	SubShader{
		pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag 
        #include "UnityCG.cginc"	
		float4 _Color1;
		float _P;
		float4 _Color2;
		float4x4 mvp;
		struct v2f
		{
			float4 Pos:POSITION;
			float2 objPos:TEXCOORD0;
			float4 col:Color;
		};
		/*struct appdata_base
		{
			float2 Pos : POSITION;
			float4 col:color;
		};*/
		float Func2(float arm[2])
		{
			float sum = 0;
			for (int i = 0; i<arm.Length; i++)
			{
				sum += arm[i];
			}
			return sum;
		}
		v2f vert(appdata_base v)
		{
		   v2f o;
		   /*o.Pos = float4(v.pos,0,1);
		   o.objPos = float2(1,0);
		   o.col = v.col;*/
		   o.Pos = UnityObjectToClipPos(v.vertex);
		   //o.Pos = mul(mvp,v.vertex);
           if(v.vertex.x>0)
		   o.col = fixed4(_SinTime.w/2+0.5, _CosTime.w/2+0.5, _SinTime.w/2+0.5, 1);
           else		
           o.col=fixed4(0,1,0,1);
		   return o;
		}
		fixed4 frag(v2f IN):COLOR
		{
			
			//return _Color1*_P+_Color2*(1-_P);
			return IN.col;
		}
		ENDCG
    	}
	}
}
