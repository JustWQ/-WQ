Shader "Custom/NewSurfaceShader 1" {
	Properties {
		 _color("main color",color)=(1,1,1,1)
       _Ambient("Ambient",color)=(0.3,0.3,0.3,0.3)
       _Specular("specular",color)=(1,1,1,1)
       _shininess("Shininess",Range(0,8))=4
       _emission("Emission",color)=(1,1,1,1)
	   _constantcolor("ConstantColor",COLOR)=(1,1,1,0.3)
       _setture("texture",2D)=""
	   _setture2("texture",2D)=""
	}
	SubShader {

	    Tags { "Queue" = "Transparent" }
		pass{
		Blend SrcAlpha OneMinusSrcAlpha
         Material{
       
         diffuse [_color] //漫反射
         Ambient[_Ambient]//环境光
         SPECULAR[_Specular]//镜面
         Shininess[_shininess]//自发光
         Emission[_emission]
         
		 
         }
         Lighting on 
         SeparateSpecular on
		 SetTexture[_setture]
		 {
		    Combine Texture * primary double//代表前面计算过关照材质的颜色
		 }
		  SetTexture[_setture2]
		 {
		    ConstantColor[_constantcolor]
		    Combine Texture * previous,Texture*Constant //代表前面计算过关照材质的颜色
		 }




             }
}

}
