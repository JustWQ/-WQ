Shader "Sbin/vf1" {
	
	SubShader {
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag				
            
		    void Func(out float4 col);
			float Func2(float arm[2]);
			float Func2(float arm[2])
			{ 
			   float sum=0;
			   for(int i=0;i<arm.Length;i++)
			   {
			      sum+=arm[i];
			   }
			   return sum;
			}
			void vert(in float2 objPos:POSITION,out float4 pos:POSITION, out float4 col:COLOR)
			{
				pos=float4(objPos,0,1);
				//if(pos.x<0 && pos.y<0)
				//{
				//	col=float4(1,0,0,1);
				//}
				//else if(pos.x<0)
				//{
				//	col=float4(0,1,0,1);
				//}
				//else if(pos.y>0)
				//{
				//	col=float4(1,1,0,1);
				//}
				//else
				//{
				//	col=float4(0,0,1,1);
				//}
				col=pos;
				
			}
			void frag(in float4 pos:POSITION,inout float4 col:COLOR)
			{
				//Func(col);
				float arm[2]={0.5,0.5};
			    col.x= Func2(arm);
			}
			void Func(out float4 col)
			{
			     col=float4(0,1,0,1);
			}
			ENDCG
		}
	} 
	
}
